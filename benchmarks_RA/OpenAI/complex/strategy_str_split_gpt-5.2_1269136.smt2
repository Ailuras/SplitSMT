(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.

; str_split interface (uninterpreted)

; Core input line
(declare-const X String)

; Derived fields
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hour String)
(declare-const min String)
(declare-const sec String)

; Preserve seed-like web indicator but adapt for log message content: allow X to contain an embedded URL
; and end with newline like typical log ingestion.
(assert (str.in_re X (re.++ re.all (str.to_re "\u{a}"))))
(assert (str.contains X "http"))

; Avoid some seed-specific oddities to keep logs realistic
(assert (not (str.contains X "wlpgskmv/lwzo.qv#www.kliksearch.com")))
(assert (not (str.contains X "/filename=")))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 32 32) (re.union (re.range "a" "f") (re.range "0" "9"))) (str.to_re "/") ((_ re.loop 10 10) (re.range "0" "9")) (str.to_re "/") ((_ re.loop 32 32) (re.union (re.range "a" "f") (re.range "0" "9"))) (str.to_re ".jar/Ui")))))

; Log structure: "<timestamp> <LEVEL>: <message>\n"
; Split on spaces for timestamp/level/message
(assert (>= (num_splits X " ") 3))
(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= msg (split_rest X " " 2)))

; Enforce colon after level (e.g., "INFO:"), and message starts with a space after colon.
(assert (str.in_re level (re.++ (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG")) (str.to_re ":"))))
(assert (str.in_re msg (re.++ (str.to_re " ") re.all)))

; Timestamp format: YYYY-MM-DDTHH:MM:SS (no timezone), validated via split_at ':' and 'T'
(assert (>= (num_splits ts "T") 2))
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))

; Date regex: 4 digits-2 digits-2 digits
(assert (str.in_re date (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")))))

; Time split and regex: HH:MM:SS with digit validation and basic range checks via regex over allowed tens.
(assert (>= (num_splits time ":") 3))
(assert (= hour (split_at time ":" 0)))
(assert (= min (split_at time ":" 1)))
(assert (= sec (split_at time ":" 2)))

; hour 00-23, minute/second 00-59
(assert (str.in_re hour (re.union (re.++ (str.to_re "0") (re.range "0" "9")) (re.++ (str.to_re "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3")))))
(assert (str.in_re min (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Message should contain a URL-looking token and no raw control characters except final newline
(assert (str.in_re X (re.++ re.all (re.++ (str.to_re "http") (re.opt (str.to_re "s")) (str.to_re "://") (re.+ (re.comp (str.to_re " "))) ) re.all)))
(assert (not (str.contains X "\u{0}")))

; --- Create both SAT and UNSAT instances via branching constraints ---
(declare-const make_unsat Bool)

; If make_unsat, force an impossible log level while also requiring valid level set.
(assert (=> make_unsat (= level "FATAL:")))

; If not make_unsat, provide additional realistic constraints.
(assert (=> (not make_unsat) (str.contains msg "status=")))
(assert (=> (not make_unsat) (str.in_re X (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "T") re.all))))

; Ensure level extraction remains meaningful regardless of branch
(assert (not (= level "")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
