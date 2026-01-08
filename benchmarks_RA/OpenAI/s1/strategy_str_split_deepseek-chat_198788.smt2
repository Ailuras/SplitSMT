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

; --- Uninterpreted interface for string splitting ---

; --- Log analysis scenario variables ---
(declare-const X String)              ; entire log line
(declare-const ts String)             ; timestamp token
(declare-const level String)          ; log level token
(declare-const component String)      ; component token
(declare-const msg String)            ; remainder message
(declare-const datePart String)
(declare-const timePart String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Preserve core structure: keep the original negated membership constraint
(assert (not (str.in_re X (re.++
  (str.to_re "Spy")
  (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
  (str.to_re "\u{d}\u{a}")
  (re.* re.allchar)
  (str.to_re "YAHOOdestroyed!Host:\u{a}")
))))

; --- Tokenization by spaces: "<timestamp> <level> <component>: <message...>" ---
(assert (>= (num_splits X " ") 4))
(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= component (split_at X " " 2)))
(assert (= msg (split_rest X " " 3)))

; Component token should contain a trailing ':' like "auth:" and message should be non-empty
(assert (str.in_re component (re.++ (re.+ re.allchar) (str.to_re ":"))))
(assert (>= (str.len msg) 1))

; --- Log level extraction and restriction ---
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; --- Timestamp format validation: "YYYY-MM-DDTHH:MM:SS" (basic structural checks) ---
(assert (>= (num_splits ts "T") 2))
(assert (= datePart (split_at ts "T" 0)))
(assert (= timePart (split_at ts "T" 1)))

; datePart: 3 splits by '-' -> YYYY, MM, DD
(assert (= 3 (num_splits datePart "-")))
(assert (= 4 (str.len (split_at datePart "-" 0))))
(assert (= 2 (str.len (split_at datePart "-" 1))))
(assert (= 2 (str.len (split_at datePart "-" 2))))

; timePart: 3 splits by ':' -> HH, MM, SS
(assert (= 3 (num_splits timePart ":")))
(assert (= hh (split_at timePart ":" 0)))
(assert (= mm (split_at timePart ":" 1)))
(assert (= ss (split_at timePart ":" 2)))
(assert (= 2 (str.len hh)))
(assert (= 2 (str.len mm)))
(assert (= 2 (str.len ss)))

; Digit-only constraints using regex
(assert (str.in_re (split_at datePart "-" 0) (re.+ (re.range "0" "9"))))
(assert (str.in_re (split_at datePart "-" 1) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re (split_at datePart "-" 2) (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Additional log-structure checks
(assert (str.contains X level))
(assert (not (str.contains msg "\n")))

; --- Create an UNSAT side-condition (conflicting requirements on log level) ---
(assert (and (= level "INFO") (= level "ERROR")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
