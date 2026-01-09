(set-logic ALL)

; Uninterpreted functions for string split interface
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

; ========= SAT instance: well-formed HTTP header parsing =========
(declare-const req1 String)
(declare-const headers1 String)
(declare-const line_host String)
(declare-const line_cl String)
(declare-const line_ua String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const body1 String)
(declare-const content_length1 Int)

; Construct a concrete request with three header lines and a body
(assert (= line_host "Host: example.com"))
(assert (= line_cl "Content-Length: 5"))
(assert (= line_ua "User-Agent: curl/8.0"))
(assert (= headers1 (str.++ line_host "\r\n" line_cl "\r\n" line_ua "\r\n" "\r\n")))
(assert (= body1 "HELLO"))
(assert (= req1 (str.++ "GET / HTTP/1.1\r\n" headers1 body1)))

; Split header block into lines using CRLF
(assert (>= (num_splits headers1 "\r\n") 5))
(assert (= (split_at headers1 "\r\n" 0) line_host))
(assert (= (split_at headers1 "\r\n" 1) line_cl))
(assert (= (split_at headers1 "\r\n" 2) line_ua))

; Parse key/value pairs using ": "
(assert (>= (num_splits line_host ": ") 2))
(assert (= host_key (split_at line_host ": " 0)))
(assert (= host_val (split_at line_host ": " 1)))
(assert (= host_key "Host"))
(assert (= host_val "example.com"))

(assert (>= (num_splits line_cl ": ") 2))
(assert (= cl_key (split_at line_cl ": " 0)))
(assert (= cl_val (split_at line_cl ": " 1)))
(assert (= cl_key "Content-Length"))
(assert (= cl_val "5"))

(assert (>= (num_splits line_ua ": ") 2))
(assert (= ua_key (split_at line_ua ": " 0)))
(assert (= ua_val (split_at line_ua ": " 1)))
(assert (= ua_key "User-Agent"))
(assert (= ua_val "curl/8.0"))

; Validate Content-Length against actual body length
(assert (= content_length1 5))
(assert (= (str.len body1) content_length1))

; Additional sanity: ensure no stray colon in keys (approximate via split count)
(assert (= (num_splits host_key ":") 1))
(assert (= (num_splits cl_key ":") 1))
(assert (= (num_splits ua_key ":") 1))

; ========= UNSAT instance: inconsistent Content-Length =========
(declare-const req2 String)
(declare-const headers2 String)
(declare-const line2_cl String)
(declare-const body2 String)
(declare-const cl2_key String)
(declare-const cl2_val String)
(declare-const content_length2 Int)

; A second request fragment where Content-Length claims 4 but body is length 5
(assert (= line2_cl "Content-Length: 4"))
(assert (= headers2 (str.++ line2_cl "\r\n" "\r\n")))
(assert (= body2 "ABCDE"))
(assert (= req2 (str.++ "POST /submit HTTP/1.1\r\n" headers2 body2)))

(assert (>= (num_splits headers2 "\r\n") 3))
(assert (= (split_at headers2 "\r\n" 0) line2_cl))
(assert (>= (num_splits line2_cl ": ") 2))
(assert (= cl2_key (split_at line2_cl ": " 0)))
(assert (= cl2_val (split_at line2_cl ": " 1)))
(assert (= cl2_key "Content-Length"))
(assert (= cl2_val "4"))

(assert (= content_length2 4))
(assert (= (str.len body2) content_length2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
