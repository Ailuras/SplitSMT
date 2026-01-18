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

; Uninterpreted interface for string split

; Core HTTP request header string
(declare-const header_blob String)

; Derived lines after splitting on CRLF
(declare-const request_line String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const empty_line String)

; Derived fields after splitting on delimiters
(declare-const method String)
(declare-const target String)
(declare-const http_version String)

(declare-const host_key String)
(declare-const host_value String)

(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_value_num Int)

; -----------------------------
; Structural expectations: at least 4 CRLF-separated lines
; request-line, Host header, Content-Length header, and the empty line marking end of headers
; -----------------------------
(assert (>= (num_splits header_blob "\r\n") 4))
(assert (= request_line (split_at header_blob "\r\n" 0)))
(assert (= host_line (split_at header_blob "\r\n" 1)))
(assert (= content_length_line (split_at header_blob "\r\n" 2)))
(assert (= empty_line (split_at header_blob "\r\n" 3)))
(assert (= empty_line ""))

; -----------------------------
; Request line parsing: "METHOD SP TARGET SP HTTP/VERSION"
; -----------------------------
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= target (split_at request_line " " 1)))
(assert (= http_version (split_at request_line " " 2)))

; Basic validations on request line parts
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" target))
(assert (or (= http_version "HTTP/1.1") (= http_version "HTTP/1.0")))

; -----------------------------
; Header key-value parsing using colon delimiter
; For simplicity, enforce exactly one ':' split point (at least 2 segments, and the rest after 1 contains no ':')
; -----------------------------
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (not (str.contains host_value ":")))

(assert (>= (num_splits content_length_line ":") 2))
(assert (= cl_key (split_at content_length_line ":" 0)))
(assert (= cl_value (split_rest content_length_line ":" 1)))
(assert (not (str.contains cl_value ":")))

; Trim expectation: values commonly start with a single space after ':'
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " cl_value))

; Key validations (case-sensitive for this scenario)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value constraints
(assert (>= (str.len host_value) 2))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; -----------------------------
; Content-Length validation
; Use cl_value_num as the parsed integer; constrain it consistently with common formatting.
; We do not define a real parse function here; instead we constrain cl_value to be " " ++ digits,
; and relate cl_value_num to length and bounds.
; -----------------------------
(assert (>= cl_value_num 0))
(assert (<= cl_value_num 1000000))

; cl_value is exactly one leading space followed by some digit string
(declare-const cl_digits String)
(assert (= cl_value (str.++ " " cl_digits)))
(assert (>= (str.len cl_digits) 1))
(assert (str.in_re cl_digits (re.+ (re.range "0" "9"))))

; A coarse consistency relation between numeric value and digit count (not exact parsing):
; if cl_value_num is 0 then digits must be "0"; if >0 then digits must not start with '0'
(assert (=> (= cl_value_num 0) (= cl_digits "0")))
(assert (=> (> cl_value_num 0) (not (str.prefixof "0" cl_digits))))

; And digit count bounds related to numeric bounds (still coarse):
(assert (=> (<= cl_value_num 9) (= (str.len cl_digits) 1)))
(assert (=> (and (>= cl_value_num 10) (<= cl_value_num 99)) (= (str.len cl_digits) 2)))
(assert (=> (and (>= cl_value_num 100) (<= cl_value_num 999)) (= (str.len cl_digits) 3)))
(assert (=> (and (>= cl_value_num 1000) (<= cl_value_num 9999)) (= (str.len cl_digits) 4)))
(assert (=> (and (>= cl_value_num 10000) (<= cl_value_num 99999)) (= (str.len cl_digits) 5)))
(assert (=> (and (>= cl_value_num 100000) (<= cl_value_num 999999)) (= (str.len cl_digits) 6)))
(assert (=> (= cl_value_num 1000000) (= (str.len cl_digits) 7)))

; -----------------------------
; Additional realistic constraints: header_blob starts with request_line and contains Host and Content-Length lines
; -----------------------------
(assert (str.contains header_blob request_line))
(assert (str.contains header_blob host_line))
(assert (str.contains header_blob content_length_line))

; -----------------------------
; SAT branch: a consistent concrete shape is allowed
; -----------------------------
(declare-const sat_witness String)
(assert (= sat_witness
  (str.++
    "GET /index.html HTTP/1.1\r\n"
    "Host: example.com\r\n"
    "Content-Length: 12\r\n"
    "\r\n")))

; Link witness to the symbolic blob (choose to satisfy by equating)
(assert (= header_blob sat_witness))

; -----------------------------
; UNSAT branch (disabled by default): if enabled, it forces conflicting Content-Length formatting.
; To create an UNSAT instance, set unsat_toggle to true.
; -----------------------------
(declare-const unsat_toggle Bool)
(assert (or (not unsat_toggle)
            (and unsat_toggle
                 (= cl_value_num 0)
                 (= cl_digits "12"))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
