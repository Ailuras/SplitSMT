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

; Uninterpreted interface for string split constraints

; Core seed variables (kept/mutated)
(declare-const x1 String)
(declare-const x2 String)
(declare-const x3 String)

; HTTP header parsing variables
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)
(declare-const content_length_val String)
(declare-const host_val String)
(declare-const body String)
(declare-const n Int)

; Preserve core structure but adapt literals to HTTP-ish markers
(assert
  (= (str.++ (str.++ (str.++ x1 "\r\n") x2) (str.++ x3 "\r\n"))
     (str.++ (str.++ (str.++ x2 ":") x1) (str.++ ":" x3))))

; Keep a large-length style constraint but change threshold slightly
(assert (> (str.len x2) 32010))

; Request is request-line + CRLF + headers + CRLFCRLF + body
(assert (= req (str.++ (str.++ (str.++ request_line "\r\n") headers_block) "\r\n\r\n")))
(assert (= req (str.++ req body)))

; Parse first line and the rest using CRLF
(assert (= request_line (split_at req "\r\n" 0)))
(assert (= headers_block (split_rest req "\r\n" 1)))
(assert (>= (num_splits req "\r\n") 3))

; Two header lines in the headers block
(assert (= header1 (split_at headers_block "\r\n" 0)))
(assert (= header2 (split_at headers_block "\r\n" 1)))
(assert (>= (num_splits headers_block "\r\n") 2))

; Each header line is key ":" value
(assert (= key1 (split_at header1 ":" 0)))
(assert (= val1 (split_rest header1 ":" 1)))
(assert (>= (num_splits header1 ":") 2))

(assert (= key2 (split_at header2 ":" 0)))
(assert (= val2 (split_rest header2 ":" 1)))
(assert (>= (num_splits header2 ":") 2))

; Relate to standard headers
(assert (or (= key1 "Content-Length") (= key2 "Content-Length")))
(assert (or (= key1 "Host") (= key2 "Host")))
(assert (distinct key1 key2))

; Select parsed values
(assert (= content_length_val (ite (= key1 "Content-Length") val1 val2)))
(assert (= host_val (ite (= key1 "Host") val1 val2)))

; Basic validity constraints
(assert (not (str.contains key1 "\r")))
(assert (not (str.contains key1 "\n")))
(assert (not (str.contains key2 "\r")))
(assert (not (str.contains key2 "\n")))

; Content-Length must be digits only (allow leading/trailing spaces handled by permitting spaces, but require at least one digit)
(assert (str.in_re content_length_val (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")) (re.* (str.to_re " ")))))

; Convert Content-Length to integer n using a custom convention: n is the length of body.
; This captures "validate content-length" without needing a string-to-int primitive.
(assert (>= n 0))
(assert (= n (str.len body)))

; SAT sub-constraints: ensure body is non-empty and host contains a dot
(assert (> (str.len body) 0))
(assert (str.contains host_val "."))

; UNSAT twist: contradict body length vs fixed body
(assert (= body "ABC"))
(assert (= n 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
