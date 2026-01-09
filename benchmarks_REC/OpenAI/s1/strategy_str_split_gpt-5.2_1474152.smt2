(set-logic ALL)

; HTTP Header Parsing with split_at/num_splits/split_rest
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

(declare-const X String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const parsed_len Int)
(declare-const unsat_witness Bool)

; Seed constraint preserved (mutated scenario still excludes this exact payload)
(assert (not (str.in_re X (str.to_re ".myway.com\u{1b}ToolbarUI2Host:Subject:toxbqyosoe/cpvm\u{a}"))))

; Basic HTTP request structure: request line + headers + blank line + body
(assert (>= (str.len X) 0))
(assert (>= (num_splits X "\r\n") 3))
(assert (= request_line (split_at X "\r\n" 0)))
(assert (= headers_block (split_rest X "\r\n" 1)))

; Require presence of the header/body separator: \r\n\r\n
(assert (str.contains X "\r\n\r\n"))
(assert (>= (num_splits X "\r\n\r\n") 2))
(assert (= body (split_rest X "\r\n\r\n" 1)))

; Request line parsing: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits request_line " ") 3))
(assert (= "GET" (split_at request_line " " 0)))
(assert (str.in_re (split_at request_line " " 1) (str.to_re "/")))
(assert (= "HTTP/1.1" (split_at request_line " " 2)))

; Header parsing: at least Host and Content-Length exist somewhere in headers
(assert (>= (num_splits headers_block "\r\n") 2))

; Constrain two particular lines to represent key-value headers
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line (split_at headers_block "\r\n" 1)))

; Key/value splitting by colon for each header line
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Host header constraints
(assert (= host_key "Host"))
(assert (str.contains host_value "."))
(assert (not (str.contains host_value "\u{1b}")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains host_value "\r")))

; Content-Length header constraints
(assert (= cl_key "Content-Length"))
(assert (str.in_re cl_value (re.++ (str.to_re " ") (str.to_re "[0-9]+"))))

; Parse length as an Int (uninterpreted mapping, but constrained by sanity checks)
(declare-fun parse_int (String) Int)
(assert (= parsed_len (parse_int cl_value)))
(assert (>= parsed_len 0))
(assert (<= parsed_len 1024))

; Validate that content-length matches body length
(assert (= parsed_len (str.len body)))

; SAT branch: a consistent request with empty body and Content-Length 0
(declare-const sat_example String)
(assert (= sat_example (str.++ "GET / HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 0\r\n\r\n" "")))
(assert (or (= X sat_example) unsat_witness))

; UNSAT branch (guarded): if unsat_witness is true, force a contradiction on length
(assert (=> unsat_witness (and (= X (str.++ "GET / HTTP/1.1\r\n" "Host: example.com\r\n" "Content-Length: 1\r\n\r\n" ""))
                              (= parsed_len 1)
                              (= (str.len body) 0))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
