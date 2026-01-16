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

; Uninterpreted split interface

; HTTP header parsing scenario
(declare-const req String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const body String)
(declare-const cl_num_str String)
(declare-const cl_num Int)

; Preserve core seed structure: regex over an ID-like token (now a header value)
(declare-const X String)
(assert (str.in_re X
  (re.union
    (re.++ (str.to_re "050-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "052-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "054-") ((_ re.loop 7 7) (re.range "0" "9")))
    (re.++ (str.to_re "057-") ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Basic request structure: request-line \n headers \n\n body
(assert (= request_line (split_at req "\u{a}" 0)))
(assert (= headers_blob (split_at req "\u{a}\u{a}" 0)))
(assert (= body (split_rest req "\u{a}\u{a}" 1)))
(assert (>= (num_splits req "\u{a}\u{a}") 2))

; Request line sanity
(assert (str.prefixof "GET " request_line))
(assert (str.contains request_line " HTTP/1.1"))
(assert (str.contains request_line " /"))

; At least a few header lines exist
(assert (>= (num_splits headers_blob "\u{a}") 3))

; Parse two specific headers from the headers blob
(assert (= host_line (split_at headers_blob "\u{a}" 1)))
(assert (= content_length_line (split_at headers_blob "\u{a}" 2)))

; Header lines must contain ':' delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits content_length_line ":") 2))

; Split key/value around ':'
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= content_length_key (split_at content_length_line ":" 0)))
(assert (= content_length_value (split_rest content_length_line ":" 1)))

; Key checks
(assert (= host_key "Host"))
(assert (= content_length_key "Content-Length"))

; Host must look like a domain with a dot and no spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Content-Length value: require a leading space then digits (no other chars)
(assert (str.prefixof " " content_length_value))
(assert (= cl_num_str (str.substr content_length_value 1 (- (str.len content_length_value) 1))))
(assert (>= (str.len cl_num_str) 1))
(assert (str.in_re cl_num_str (re.+ (re.range "0" "9"))))

; Numeric interpretation and validation against body length
(assert (= cl_num (str.to_int cl_num_str)))
(assert (>= cl_num 0))
(assert (= cl_num (str.len body)))

; Relate X into headers: embed X as part of Host value to force interaction
(assert (str.contains host_value X))

; Additional constraints to create both SAT/UNSAT branches:
; If X matches the 057-...\n variant, it contains a newline, which is disallowed in a header value.
; This makes some regex branches impossible while keeping others satisfiable.
(assert (not (str.contains host_value "\u{a}")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
