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

; --- Uninterpreted interface for str_split ---

; --- Core variables (mutated from seed) ---
(declare-const var_5 String)
(declare-const var_6 String)

; --- HTTP header parsing scenario variables ---
(declare-const request String)
(declare-const headers String)
(declare-const body String)
(declare-const first_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const cl_num Int)

; --- Preserve core structure: regex constraints over (var_5 "z" var_6) ---
(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "a")) (str.to_re "z")))))
    (re.++ (str.to_re "a") (re.* (str.to_re "a"))))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (re.union (str.to_re "z") (str.to_re "b"))
                    (re.++ (str.to_re "a") (re.union (str.to_re "z") (str.to_re "a")))))
    (str.to_re "a"))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                          (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.* (re.++ (re.union (str.to_re "z") (str.to_re "a"))
              (re.++ (re.* (str.to_re "z")) (str.to_re "a"))))))

(assert (str.in_re var_6 (re.* (re.range "a" "u"))))
(assert (str.in_re var_5 (re.* (re.range "a" "u"))))
(assert (not (str.in_re (str.++ "b" var_6 ) (re.* (re.range "a" "u")))))

; --- Connect seed vars into HTTP parsing (mutate/extend semantics) ---
; request is composed of var_5 and var_6 around a 'z' marker then headers/body
(assert (= request (str.++ var_5 "z" var_6 "\r\n" headers "\r\n\r\n" body)))

; --- Basic HTTP request line and header block splitting by CRLF ---
(assert (= first_line (split_at request "\r\n" 0)))
(assert (= headers (split_rest request "\r\n" 1)))
(assert (>= (num_splits request "\r\n") 3))

; first line contains spaces: METHOD SP PATH SP HTTP/V
(assert (>= (num_splits first_line " ") 3))

; --- Extract specific header lines from the headers block ---
; We model two header lines at fixed positions for simplicity
(assert (= host_line (split_at headers "\r\n" 0)))
(assert (= cl_line   (split_at headers "\r\n" 1)))
(assert (>= (num_splits headers "\r\n") 2))

; --- Parse "Key: Value" using split_at with ": " delimiter ---
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_at host_line ": " 1)))
(assert (>= (num_splits host_line ": ") 2))

(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_val (split_at cl_line ": " 1)))
(assert (>= (num_splits cl_line ": ") 2))

; --- Constrain keys and basic value patterns ---
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value should be non-empty and not contain CRLF
(assert (> (str.len host_val) 0))
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))

; Content-Length value: digits-only (non-empty)
(assert (> (str.len cl_val) 0))
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Link integer cl_num to string length: enforce that value is exactly "0" and body length is 0
; This acts as an UNSAT-inducing core when body is forced non-empty below.
(assert (= cl_num 0))
(assert (= cl_val "0"))
(assert (= (str.len body) cl_num))

; Additional constraints: require body to be non-empty (contradicts Content-Length 0)
(assert (> (str.len body) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
