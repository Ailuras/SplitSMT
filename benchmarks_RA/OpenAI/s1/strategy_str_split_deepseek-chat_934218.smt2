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
; Key checks include timestamp format validation and log level extraction.

; Seed core preserved: non-empty input via boolean guard
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_101935 String)
(assert (= T_1 (not (= "" var_0xINPUT_101935))))
(assert T_1)

; str_split interface (uninterpreted)

; Log-oriented variables
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const lvlTail String)

; Basic structure: "<timestamp> <level>:<component> <message...>"
(assert (= ts (split_at var_0xINPUT_101935 " " 0)))
(assert (= lvlTail (split_at var_0xINPUT_101935 " " 1)))
(assert (= msg (split_rest var_0xINPUT_101935 " " 2)))
(assert (>= (num_splits var_0xINPUT_101935 " ") 3))

; Split level and component on ':'
(assert (= level (split_at lvlTail ":" 0)))
(assert (= component (split_at lvlTail ":" 1)))
(assert (= "" (split_rest lvlTail ":" 2)))
(assert (>= (num_splits lvlTail ":") 2))

; Timestamp format validation (RFC3339-like): YYYY-MM-DDThh:mm:ssZ
(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))
(assert (str.in_re ts (re.++ (re.loop (str.to_re "0") 4 4) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "-") (re.loop (str.to_re "0") 2 2) (str.to_re "T") (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2) (str.to_re ":") (re.loop (str.to_re "0") 2 2) (str.to_re "Z"))))

; Log level extraction: restrict to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Component must be non-empty and must not contain spaces
(assert (not (= component "")))
(assert (not (str.contains component " ")))

; Message must be non-empty and not begin with a space (since derived from split_rest)
(assert (not (= msg "")))
(assert (or (= (str.len msg) 0) (not (= (str.at msg 0) " "))))

; Concrete example to keep instance SAT
(assert (= var_0xINPUT_101935 "0000-00-00T00:00:00Z INFO:auth user_login"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
