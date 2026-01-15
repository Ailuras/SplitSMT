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

; Scenario: HTTP Header Parsing
; We parse a request header block with lines "Key: Value\n" and validate Content-Length.

; Core payload
(declare-const X String)

; Split interface (uninterpreted, per provided methodology)

; Parsed pieces
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const ua_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const cl_len Int)

; Basic structure: request line + headers
(assert (>= (num_splits X "\u{a}") 2))
(assert (= request_line (split_at X "\u{a}" 0)))
(assert (= headers_block (split_rest X "\u{a}" 1)))

; Request line must look like: METHOD SP URI SP HTTP/1.1
(assert (str.in_re request_line
  (re.++
    (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD"))
    (str.to_re " ")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "?") (str.to_re "=") (str.to_re "&")))
    (str.to_re " HTTP/1.1"))))

; We expect at least 3 header lines in the header block
(assert (>= (num_splits headers_block "\u{a}") 3))
(assert (= host_line (split_at headers_block "\u{a}" 0)))
(assert (= ua_line   (split_at headers_block "\u{a}" 1)))
(assert (= cl_line   (split_at headers_block "\u{a}" 2)))

; Each of these lines is "Key: Value"; split on ": "
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits ua_line ": ") 2))
(assert (>= (num_splits cl_line ": ") 2))

(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_rest host_line ": " 1)))
(assert (= ua_key   (split_at ua_line ": " 0)))
(assert (= ua_val   (split_rest ua_line ": " 1)))
(assert (= cl_key   (split_at cl_line ": " 0)))
(assert (= cl_val   (split_rest cl_line ": " 1)))

; Constrain expected keys
(assert (= host_key "Host"))
(assert (= ua_key "User-Agent"))
(assert (= cl_key "Content-Length"))

; Host value: simple domain[:port] (relaxed)
(assert (str.in_re host_val
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))
    (re.union
      (str.to_re "")
      (re.++ (str.to_re ":") (re.+ (re.range "0" "9")))))))

; User-Agent must be printable-ish and not contain newlines
(assert (not (str.contains ua_val "\u{a}")))
(assert (str.in_re ua_val
  (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/") (str.to_re ";") (str.to_re "(") (str.to_re ")")))))

; Content-Length is a non-negative integer with no leading plus sign
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Bind an integer cl_len with a simple fixed-width encoding for 0..9999
; (avoids a full str->int operator; models typical header sizes)
(assert (and (>= cl_len 0) (<= cl_len 9999)))
(assert (or
  (and (<= cl_len 9)
       (= cl_val (str.from_code (+ 48 cl_len))))
  (and (<= 10 cl_len) (<= cl_len 99)
       (= cl_val (str.++
         (str.from_code (+ 48 (div cl_len 10)))
         (str.from_code (+ 48 (mod cl_len 10))))))
  (and (<= 100 cl_len) (<= cl_len 999)
       (= cl_val (str.++
         (str.from_code (+ 48 (div cl_len 100)))
         (str.from_code (+ 48 (div (mod cl_len 100) 10)))
         (str.from_code (+ 48 (mod cl_len 10))))))
  (and (<= 1000 cl_len) (<= cl_len 9999)
       (= cl_val (str.++
         (str.from_code (+ 48 (div cl_len 1000)))
         (str.from_code (+ 48 (div (mod cl_len 1000) 100)))
         (str.from_code (+ 48 (div (mod cl_len 100) 10)))
         (str.from_code (+ 48 (mod cl_len 10))))))))

; Validate Content-Length against the remainder after the third header line
; Require the "body" to have exactly cl_len characters.
(declare-const after_cl String)
(declare-const body String)
(assert (= after_cl (split_rest headers_block "\u{a}" 3)))
; If a body exists, it begins immediately after a blank line; model as optional leading newline
(assert (or
  (= after_cl "")
  (= (str.at after_cl 0) "\u{a}")))
(assert (= body (str.replace after_cl "\u{a}" "")))
(assert (= (str.len body) cl_len))

; Mutated/extended seed-style negative regex constraints (security hardening)
(assert (not (str.in_re X (str.to_re "Host:User-Agent:Host:PortScaner\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "nick_name=CIA-Test") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "User-Agent:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Downloadfowclxccdxn/uxwn.ddywww.easymessage.net\u{a}")))))
(assert (not (str.in_re X (re.union (str.to_re "23:59:59") (re.++ (re.union (re.++ ((_ re.loop 1 1) (re.union (str.to_re "0") (str.to_re "1"))) (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3"))) (str.to_re ":") (re.+ (re.union (str.to_re "00") (str.to_re "15") (str.to_re "30") (str.to_re "45"))) (str.to_re ":00\u{a}"))))))
; Disallow header names with underscores (common smuggling hardening example)
(assert (not (str.in_re X (re.++ (re.* (re.union (re.++ (re.union (re.range "A" "Z") (re.range "0" "9")) (re.* (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_")))) (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "\u{a}")))))

; Additional UNSAT branch (disabled by default) to ensure diversity in the file
; Toggle by asserting enable_unsat = true.
(declare-const enable_unsat Bool)
(assert (=> enable_unsat (and (= cl_len 1) (= (str.len body) 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
