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

; Uninterpreted interface for split operations

; Seed-related symbols (preserve core structure: T_1 guards a negated equality on the raw input)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_127821 String)

; HTTP header parsing symbols
(declare-const header_block String)
(declare-const request_line String)
(declare-const header_lines String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const content_length Int)

; Keep the seed constraint
(assert (= T_1 (not (= "file:" var_0xINPUT_127821))))
(assert T_1)

; Relate input to an HTTP header block and ensure it is not a file: URL-like string
(assert (= header_block var_0xINPUT_127821))
(assert (not (str.prefixof "file:" header_block)))

; Basic structure: request line + headers separated by a blank line (CRLFCRLF)
(assert (>= (num_splits header_block "\r\n\r\n") 2))
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= header_lines (split_rest header_block "\r\n" 1)))
(assert (= body (split_rest header_block "\r\n\r\n" 1)))

; Request line sanity: must look like METHOD SP PATH SP HTTP/1.1
(assert (str.contains request_line " HTTP/1.1"))
(assert (str.contains request_line " "))

; Require at least two header lines
(assert (>= (num_splits header_lines "\r\n") 2))

; Extract first two lines as Host and Content-Length (order fixed for this scenario)
(assert (= host_line (split_at header_lines "\r\n" 0)))
(assert (= cl_line (split_at header_lines "\r\n" 1)))

; Parse Host line using colon delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))
(assert (str.contains host_value " "))

; Parse Content-Length line using colon delimiter
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Validate that content-length value looks numeric (optional leading space, then digits)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Integer constraints for content length and body length
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; SAT track: consistent length equality
(assert (= (str.len body) content_length))

; UNSAT track in the same file via an additional contradictory requirement guarded by a fresh boolean
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat (not (= (str.len body) content_length))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
