; Log Analysis: Parsing structured server log entries with spaces and colons
; Core structure extended with str_split operations for timestamp and log level extraction
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

; Original Boolean variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; String variables for log parsing
(declare-fun var_0xINPUT_14893 () String)
(declare-fun timestamp () String)
(declare-fun log_level () String)
(declare-fun message () String)

; Declare str_split interface functions

; Original constraints (modified for relevance)
(assert (= T_1 (= "" var_0xINPUT_14893)))  ; Check if log is empty
(assert (= T_2 (not T_1)))
(assert T_2)  ; Log must not be empty
(assert (= T_3 (str.contains var_0xINPUT_14893 "ERROR")))  ; Check if contains ERROR
(assert (= T_4 (not T_3)))
(assert T_4)  ; For UNSAT scenario: require no ERROR (change to (assert (not T_4)) for SAT)

; New constraints for log parsing
; Assume format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
; First split by space to separate timestamp and rest
(assert (>= (num_splits var_0xINPUT_14893 " ") 3))  ; At least 3 parts: date, time, rest
(assert (= timestamp (str.++ (split_at var_0xINPUT_14893 " " 0) " " (split_at var_0xINPUT_14893 " " 1))))

; Validate timestamp format: YYYY-MM-DD HH:MM:SS
(assert (= (str.len (split_at var_0xINPUT_14893 " " 0)) 10))  ; Date part length
(assert (str.contains (split_at var_0xINPUT_14893 " " 0) "-"))  ; Date has hyphens
(assert (= (str.len (split_at var_0xINPUT_14893 " " 1)) 8))   ; Time part length
(assert (str.contains (split_at var_0xINPUT_14893 " " 1) ":"))  ; Time has colons

; Extract log level after second space, before colon
(declare-fun rest_part () String)
(assert (= rest_part (split_rest var_0xINPUT_14893 " " 2)))  ; Everything after timestamp
(assert (>= (num_splits rest_part ":") 2))  ; At least one colon for level:message
(assert (= log_level (split_at rest_part ":" 0)))
(assert (= message (split_rest rest_part ":" 1)))

; Log level must be one of INFO, WARN, DEBUG (case-sensitive)
(assert (or (= log_level "INFO") (= log_level "WARN") (= log_level "DEBUG")))

; Additional constraint: message length between 5 and 100 characters
(assert (>= (str.len message) 5))
(assert (<= (str.len message) 100))

; Final check


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
