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

; === Uninterpreted interface for string split ===

; === Scenario: HTTP Header Parsing ===
; We model a request header block, split by CRLF, then split each header line by ": ".
; We validate that Content-Length is numeric and matches a body length.

(declare-const request String)
(declare-const headers String)
(declare-const body String)

(declare-const crlf String)
(declare-const sep String)

(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)
(declare-const key3 String)
(declare-const val3 String)

(declare-const cl_str String)
(declare-const host String)
(declare-const ua String)

(declare-const cl Int)

; === Delimiters ===
(assert (= crlf "\r\n"))
(assert (= sep ": "))

; === Basic request shape ===
; request = headers + CRLF + CRLF + body
(assert (= request (str.++ headers crlf crlf body)))

; headers has at least 4 lines: request-line + 3 header lines
(assert (>= (num_splits headers crlf) 4))

; Extract first four lines
(assert (= line0 (split_at headers crlf 0)))
(assert (= line1 (split_at headers crlf 1)))
(assert (= line2 (split_at headers crlf 2)))
(assert (= line3 (split_at headers crlf 3)))

; Request line must look like: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re line0 (re.++ (str.to_re "GET") (str.to_re " ") (re.+ (re.union (str.to_re "/") (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_") (str.to_re "."))) (str.to_re " HTTP/1.1"))))

; Each header line must contain ": " and have non-empty key/value
(assert (>= (num_splits line1 sep) 2))
(assert (>= (num_splits line2 sep) 2))
(assert (>= (num_splits line3 sep) 2))

(assert (= key1 (split_at line1 sep 0)))
(assert (= val1 (split_rest line1 sep 1)))
(assert (= key2 (split_at line2 sep 0)))
(assert (= val2 (split_rest line2 sep 1)))
(assert (= key3 (split_at line3 sep 0)))
(assert (= val3 (split_rest line3 sep 1)))

(assert (> (str.len key1) 0))
(assert (> (str.len val1) 0))
(assert (> (str.len key2) 0))
(assert (> (str.len val2) 0))
(assert (> (str.len key3) 0))
(assert (> (str.len val3) 0))

; Constrain header keys to typical token characters (simplified)
(assert (str.in_re key1 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))
(assert (str.in_re key2 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))
(assert (str.in_re key3 (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-") ))))

; Force presence of specific headers among the 3 lines
; Host
(assert (or (= key1 "Host") (= key2 "Host") (= key3 "Host")))
(assert (= host (ite (= key1 "Host") val1 (ite (= key2 "Host") val2 val3))))
(assert (str.in_re host (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "."))) (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") )))))))

; User-Agent (simplified: non-empty printable without CR/LF)
(assert (or (= key1 "User-Agent") (= key2 "User-Agent") (= key3 "User-Agent")))
(assert (= ua (ite (= key1 "User-Agent") val1 (ite (= key2 "User-Agent") val2 val3))))
(assert (str.in_re ua (re.+ (re.union (re.range " " "~")))))

; Content-Length
(assert (or (= key1 "Content-Length") (= key2 "Content-Length") (= key3 "Content-Length")))
(assert (= cl_str (ite (= key1 "Content-Length") val1 (ite (= key2 "Content-Length") val2 val3))))

; Content-Length must be digits only, and at least one digit
(assert (str.in_re cl_str (re.+ (re.range "0" "9"))))

; Interpret cl as integer via str.to_int; require it is not (- 1)
(assert (= cl (str.to_int cl_str)))
(assert (>= cl 0))

; Validate content-length against actual body length
(assert (= (str.len body) cl))

; Additional constraints: body is arbitrary bytes but no CRLF to keep header/body split unambiguous here
(assert (not (str.contains body crlf)))

; === SAT instance: a consistent request exists ===
(assert (>= (str.len body) 0))
(check-sat)
(exit)
