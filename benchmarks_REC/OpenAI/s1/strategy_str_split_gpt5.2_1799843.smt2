(set-logic ALL)
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

; Uninterpreted split interface for HTTP header parsing

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; HTTP header input and derived fields
(declare-const var_0xINPUT_429544 String)
(declare-const request_line String)
(declare-const header_0 String)
(declare-const header_1 String)
(declare-const header_2 String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const declared_body_len Int)
(declare-const body String)

; Preserve core structure: seed-style distinctness/non-emptiness booleans
(assert (= T_1 (not (= "ywUN4ZIDAC" var_0xINPUT_429544))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_429544))))
(assert T_2)
(assert (= T_3 (= var_0xINPUT_429544 "Example:")))
(assert (= T_4 (not T_3)))
(assert T_4)
(assert (= T_5 (not (= "" var_0xINPUT_429544))))
(assert T_5)
(assert (= T_6 (not (= var_0xINPUT_429544 "4PH2ujcENG"))))
(assert (= T_7 (not T_6)))
(assert T_7)

; HTTP Header Parsing constraints
; Split request into lines by CRLF
(assert (>= (num_splits var_0xINPUT_429544 "\r\n") 4))
(assert (= request_line (split_at var_0xINPUT_429544 "\r\n" 0)))
(assert (= header_0 (split_at var_0xINPUT_429544 "\r\n" 1)))
(assert (= header_1 (split_at var_0xINPUT_429544 "\r\n" 2)))
(assert (= header_2 (split_at var_0xINPUT_429544 "\r\n" 3)))

; Minimal request-line sanity
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Ensure at least one colon-separated header exists
(assert (or (str.contains header_0 ":") (str.contains header_1 ":") (str.contains header_2 ":")))

; Model Host and Content-Length headers as particular lines
(assert (= host_line header_0))
(assert (= content_length_line header_1))

; Parse Host: value
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Parse Content-Length: value
(assert (>= (num_splits content_length_line ":") 2))
(assert (= cl_key (split_at content_length_line ":" 0)))
(assert (= cl_value (split_rest content_length_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate Content-Length numeric-ish: at least one digit and only digits (simplified check)
(assert (> (str.len cl_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Body extracted after header_2 (simulate end of headers somewhere after index 3)
(assert (= body (split_rest var_0xINPUT_429544 "\r\n" 4)))

; Bind declared_body_len and validate against body length (deliberate UNSAT core)
(assert (>= declared_body_len 0))
(assert (= declared_body_len 0))
(assert (> (str.len body) 0))
(assert (= (str.len body) declared_body_len))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
