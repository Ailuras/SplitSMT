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

; Uninterpreted interface for string split (provided methodology)

; Seed variables (kept core structure)
(declare-const var_7 String)
(declare-const var_8 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

; Keep the seed-style regex constraints (mutated but structurally similar)
(assert (str.in_re (str.++ var_7 "z" var_8)
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                          (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))
(assert (str.in_re var_8 (re.* (re.range "a" "u"))))
(assert (str.in_re var_7 (re.* (re.range "a" "u"))))
(assert (not (str.in_re (str.++ var_7 "z" var_8 "b")
  (re.++
    (re.* (re.++ (str.to_re "a")
                 (re.++ (re.* (re.union (str.to_re "b") (str.to_re "a")))
                       (str.to_re "z"))))
    (re.++ (str.to_re "a")
          (re.* (re.union (str.to_re "b") (str.to_re "a"))))))))
(assert (<= 0 (str.len var_8)))

; HTTP request structure: request_line \n headers_block
(assert (= request_line (split_at request "\n" 0)))
(assert (= headers_block (split_rest request "\n" 1)))
(assert (>= (num_splits request "\n") 2))

; Require at least two header lines in headers_block
(assert (>= (num_splits headers_block "\n") 2))

; Extract two specific header lines (order-dependent parsing)
(assert (= host_line (split_at headers_block "\n" 0)))
(assert (= cl_line (split_at headers_block "\n" 1)))

; Split header lines on ':' into key/value
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_at host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_at cl_line ":" 1)))

; Ensure each of these lines actually contains ':' (at least 2 segments)
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; Validate expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value must be non-empty and limited to typical hostname characters [a-z0-9.-]
(assert (> (str.len host_value) 0))
(assert (str.in_re host_value
  (re.++
    (re.* (re.union (re.range "a" "z")
                    (re.range "0" "9")
                    (str.to_re ".")
                    (str.to_re "-")))
    (re.* (re.union (re.range "a" "z")
                    (re.range "0" "9")
                    (str.to_re ".")
                    (str.to_re "-"))))))

; Content-Length value must be digits only
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Connect content_length with cl_value via a definitional constraint
; (No str.to_int in this scenario: use an uninterpreted parser)
(declare-fun parse_nat (String) Int)
(assert (= content_length (parse_nat cl_value)))
(assert (>= content_length 0))

; SAT-side: a weak consistency bound between content_length and request size
(assert (<= content_length (str.len request)))

; Also relate HTTP parsing with seed vars to preserve core structure but extend scenario
; Make request contain var_7 and var_8 in a harmless way
(assert (str.contains request (str.++ var_7 "z" var_8)))

; ----------------------------
; UNSAT block: contradictory constraints to create an UNSAT instance within same file
; Force content_length to be both 0 and >0
(assert (= content_length 0))
(assert (> content_length 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
