(set-logic ALL)

; Mutated/extended scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Preserve core structure booleans and the input string
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-const var_0xINPUT_124328 String)

; Additional booleans for log-specific checks
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)

; str_split interface (uninterpreted)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

; Core seed constraints (mutated: keep T_1/T_2 structure, but no longer force empty string)
(assert (= T_1 (= "-" var_0xINPUT_124328)))
(assert (= T_2 (not T_1)))
(assert T_2)

; In seed, T_3 forced empty input; mutate to "non-empty input" to enable log parsing
(assert (= T_3 (= "" var_0xINPUT_124328)))
(assert (not T_3))

; Log entry shape: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by spaces into at least 3 segments
(assert (>= (num_splits var_0xINPUT_124328 " ") 3))

(declare-const ts_date String)
(declare-const ts_time String)
(declare-const level_colon String)
(declare-const level String)
(declare-const msg_rest String)

(assert (= ts_date (split_at var_0xINPUT_124328 " " 0)))
(assert (= ts_time (split_at var_0xINPUT_124328 " " 1)))
(assert (= level_colon (split_at var_0xINPUT_124328 " " 2)))
(assert (= msg_rest (split_rest var_0xINPUT_124328 " " 3)))

; Timestamp format validation (approximate but concrete):
; Date must match 4 digits '-' 2 digits '-' 2 digits and length 10
(assert (= T_4 (= (str.len ts_date) 10)))
(assert T_4)
(assert (= T_5 (str.in_re ts_date (re.++ (re.loop (re.range "0" "9") 4 4)
                                           (str.to_re "-")
                                           (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re "-")
                                           (re.loop (re.range "0" "9") 2 2)))))
(assert T_5)

; Time must match 2 digits ':' 2 digits ':' 2 digits and length 8
(assert (= T_6 (= (str.len ts_time) 8)))
(assert T_6)
(assert (= T_7 (str.in_re ts_time (re.++ (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re ":")
                                           (re.loop (re.range "0" "9") 2 2)
                                           (str.to_re ":")
                                           (re.loop (re.range "0" "9") 2 2)))))
(assert T_7)

; Log level extraction: level_colon is like "INFO:"; split at ':' gives level in segment 0
(assert (>= (num_splits level_colon ":") 2))
(assert (= level (split_at level_colon ":" 0)))

; Level must be one of a known set
(assert (= T_8 (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))
(assert T_8)

; Message should be non-empty and should not contain newline
(assert (= T_9 (and (> (str.len msg_rest) 0) (not (str.contains msg_rest "\n")))))
(assert T_9)

; Ensure input contains expected separators
(assert (str.contains var_0xINPUT_124328 " "))
(assert (str.contains var_0xINPUT_124328 ":"))

; Concrete satisfiable instance guidance (still symbolic, but pins a realistic shape)
(assert (str.prefixof (str.++ ts_date " " ts_time " ") var_0xINPUT_124328))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
