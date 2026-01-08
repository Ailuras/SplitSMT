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

; Uninterpreted interface for string split operations

; -----------------------------
; Scenario: Log Analysis (SAT instance)
; Log format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by space: [0]=date [1]=time [2]=LEVEL: [3..]=message parts
; Split by colon in the LEVEL field to extract level.
; -----------------------------
(declare-const log_line String)
(declare-const date_str String)
(declare-const time_str String)
(declare-const level_field String)
(declare-const message_tail String)
(declare-const level_str String)
(declare-const date_ok Bool)
(declare-const time_ok Bool)

; Basic segmentation by spaces
(assert (= date_str (split_at log_line " " 0)))
(assert (= time_str (split_at log_line " " 1)))
(assert (= level_field (split_at log_line " " 2)))
(assert (= message_tail (split_rest log_line " " 3)))
(assert (>= (num_splits log_line " ") 4))

; Level extraction: "LEVEL:"
(assert (= level_str (split_at level_field ":" 0)))
(assert (>= (num_splits level_field ":") 2))

; Timestamp format checks via regex
(assert (= date_ok (str.in_re date_str (re.++ (re.range "0" "9")
                                            (re.++ (re.range "0" "9")
                                                   (re.++ (re.range "0" "9")
                                                          (re.++ (re.range "0" "9")
                                                                 (re.++ (str.to_re "-")
                                                                        (re.++ (re.range "0" "9")
                                                                               (re.++ (re.range "0" "9")
                                                                                      (re.++ (str.to_re "-")
                                                                                             (re.++ (re.range "0" "9")
                                                                                                    (re.range "0" "9")))))))))))))

(assert (= time_ok (str.in_re time_str (re.++ (re.range "0" "9")
                                            (re.++ (re.range "0" "9")
                                                   (re.++ (str.to_re ":")
                                                          (re.++ (re.range "0" "9")
                                                                 (re.++ (re.range "0" "9")
                                                                        (re.++ (str.to_re ":")
                                                                               (re.++ (re.range "0" "9")
                                                                                      (re.range "0" "9")))))))))))

(assert date_ok)
(assert time_ok)

; Ensure log level is one of common levels
(assert (or (= level_str "INFO")
            (= level_str "WARN")
            (= level_str "ERROR")
            (= level_str "DEBUG")))

; Require message tail to be non-empty and contain a keyword
(assert (> (str.len message_tail) 0))
(assert (str.contains message_tail "request"))

; Concretize a satisfiable example
(assert (= log_line "2025-01-06 09:14:33 INFO: request completed"))

; -----------------------------
; Scenario: Log Analysis (UNSAT instance)
; Contradiction: same line but forced to have invalid date regex while also asserting it matches.
; -----------------------------
(declare-const log_line_bad String)
(declare-const date_bad String)
(declare-const time_bad String)
(declare-const level_field_bad String)
(declare-const level_bad String)

(assert (= date_bad (split_at log_line_bad " " 0)))
(assert (= time_bad (split_at log_line_bad " " 1)))
(assert (= level_field_bad (split_at log_line_bad " " 2)))
(assert (= level_bad (split_at level_field_bad ":" 0)))
(assert (>= (num_splits log_line_bad " ") 3))
(assert (>= (num_splits level_field_bad ":") 2))

; Force a specific bad log line
(assert (= log_line_bad "2025-13-99 25:61:61 ERROR: impossible timestamp"))

; Still (incorrectly) require strict timestamp shape AND also require a conflicting constraint on characters.
; This creates UNSAT by forcing date to match YYYY-MM-DD but also forcing a non-digit inside.
(assert (str.in_re date_bad (re.++ (re.range "0" "9")
                                 (re.++ (re.range "0" "9")
                                        (re.++ (re.range "0" "9")
                                               (re.++ (re.range "0" "9")
                                                      (re.++ (str.to_re "-")
                                                             (re.++ (re.range "0" "9")
                                                                    (re.++ (re.range "0" "9")
                                                                           (re.++ (str.to_re "-")
                                                                                  (re.++ (re.range "0" "9")
                                                                                         (re.range "0" "9"))))))))))))

; Contradiction: 5th character of date must be '-' due to regex, but we also force it to be 'X'
(assert (= (str.at date_bad 4) "X"))

; Also require a specific level, to keep it realistic
(assert (= level_bad "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
