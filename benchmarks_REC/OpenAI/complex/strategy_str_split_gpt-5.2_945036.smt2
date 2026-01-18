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

; Uninterpreted interface for split operations (str_split)

; Core variables for HTTP header parsing
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const body String)
(declare-const tmp String)
(declare-const content_length Int)
(declare-const body_len Int)

; Preserve core structure from seed: a regex inequality-shaped constraint over a string
(declare-const x String)
(assert
  (let ((_let_0 (re.* re.allchar)))
    (not
      (= (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "B" "A"))) _let_0 (str.to_re "A") _let_0))
         (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "B")) _let_0 (str.to_re (str.++ "A" "A")) _let_0))))))

; HTTP request must have a header/body separator
(assert (str.contains req "\r\n\r\n"))
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers_blob (split_rest req "\r\n" 1)))

; First line should look like "GET ... HTTP/1.1"
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET "))

; Headers portion still contains the blank line separator; body follows it
(assert (= tmp (split_rest headers_blob "\r\n\r\n" 1)))
(assert (= body tmp))

; Ensure at least Host and Content-Length headers exist (in some order, as lines)
(assert (>= (num_splits req "\r\n") 4))
(assert (str.contains req "Host:"))
(assert (str.contains req "Content-Length:"))

; Parse Host line with split_at around ':'
; We constrain host_line to be a line containing "Host:".
(assert (str.contains host_line "Host:"))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= host_key "Host"))
; typical formatting: optional leading space in value, but host value must be non-empty
(assert (> (str.len host_value) 0))

; Parse Content-Length line
(assert (str.contains cl_line "Content-Length:"))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value must be digits (allow leading spaces)
(assert (str.in_re cl_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Link integer content_length to cl_value via numeric-string roundtrip
(assert (= cl_value (str.++ " " (str.from_int content_length))))
(assert (>= content_length 0))

; Body length must match content-length
(assert (= body_len (str.len body)))
(assert (= body_len content_length))

; Additional header well-formedness: every header line must contain ':'
(assert (>= (num_splits headers_blob "\r\n") 2))
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))

; Tie the declared header lines to actual segments of the request to avoid free floating lines
(assert (= host_line (split_at req "\r\n" 1)))
(assert (= cl_line (split_at req "\r\n" 2)))

; Keep request line distinct from headers
(assert (not (= request_line host_line)))
(assert (not (= request_line cl_line)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
