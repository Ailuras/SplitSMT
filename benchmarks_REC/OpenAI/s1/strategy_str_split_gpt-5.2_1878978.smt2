(set-logic ALL)

; HTTP Header Parsing: split by CRLF and ':' to extract header fields, validate Content-Length

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

(declare-const T_1 Bool)
(declare-const var_0xINPUT_113237 String)

(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const body String)
(declare-const cl Int)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Preserve seed core structure but repurpose input as a sanity constraint on a separate string
(assert (= T_1 (= "-" var_0xINPUT_113237)))
(assert T_1)

; Request is headers_block + blank line + body
(assert (= request (str.++ headers_block "\r\n\r\n" body)))

; First line is request line, followed by header lines
(assert (= request_line (split_at headers_block "\r\n" 0)))
(assert (= host_line (split_at headers_block "\r\n" 1)))
(assert (= cl_line (split_at headers_block "\r\n" 2)))
(assert (>= (num_splits headers_block "\r\n") 3))

; Parse request line: METHOD SP PATH SP HTTP/VERSION
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (= method "POST"))
(assert (= version "HTTP/1.1"))
(assert (str.prefixof "/" path))

; Parse Host header: "Host: <value>"
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_at host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_at cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key "Content-Length"))

; Require value to be digits (optionally with leading space)
(assert (or (str.in_re cl_value (re.++ (str.to_re " ") (re.+ (re.range "0" "9"))))
            (str.in_re cl_value (re.+ (re.range "0" "9")))))

; Link integer content-length to body length (abstracted): enforce consistent bounds and then contradict for UNSAT
(assert (>= cl 0))
(assert (= (str.len body) cl))

; Create an UNSAT twist: also assert body length differs from cl
(assert (not (= (str.len body) cl)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
