(set-logic ALL)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; Core checks: timestamp format validation and log level extraction.

; --- split interface (uninterpreted) ---
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

; --- variables ---
(declare-const X String)            ; entire log line
(declare-const ts String)           ; timestamp field
(declare-const level_tag String)    ; e.g., "INFO:" (includes colon)
(declare-const level String)        ; extracted level without colon
(declare-const msg String)          ; message remainder
(declare-const src_tag String)      ; e.g., "src:auth"
(declare-const src_key String)
(declare-const src_val String)
(declare-const pid_tag String)      ; e.g., "pid:1234"
(declare-const pid_str String)

; --- tokenization by spaces ---
(assert (>= (num_splits X " ") 4))
(assert (= ts (split_at X " " 0)))
(assert (= level_tag (split_at X " " 1)))
(assert (= src_tag (split_at X " " 2)))
(assert (= pid_tag (split_at X " " 3)))
(assert (= msg (split_rest X " " 4)))

; --- timestamp validation: YYYY-MM-DDTHH:MM:SSZ ---
(assert (str.in_re ts
  (re.++
    ((_ re.loop 4 4) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "T")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "Z"))))

; --- log level extraction and validation ---
(assert (str.in_re level_tag (re.++ (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG")) (str.to_re ":"))))
(assert (= level (split_at level_tag ":" 0)))
(assert (= "" (split_at level_tag ":" 1)))
(assert (>= (num_splits level_tag ":") 2))

; --- key:value parsing for src and pid ---
(assert (= src_key (split_at src_tag ":" 0)))
(assert (= src_val (split_at src_tag ":" 1)))
(assert (= src_key "src"))
(assert (>= (num_splits src_tag ":") 2))
(assert (str.in_re src_val (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-")))))

(assert (= (split_at pid_tag ":" 0) "pid"))
(assert (= pid_str (split_at pid_tag ":" 1)))
(assert (>= (num_splits pid_tag ":") 2))
(assert (str.in_re pid_str ((_ re.loop 1 6) (re.range "0" "9"))))

; --- message sanity checks ---
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "User-Agent:")))

; preserve seed-style negative constraints (mutated for log context)
(assert (not (str.in_re X (re.++ (str.to_re "www.ezula.com") (re.* re.allchar) (str.to_re "FTP") (re.* re.allchar) (str.to_re "User-Agent:containsw3whoreport\u{a}")))))

; UNSAT twist: force contradictory level requirements
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
