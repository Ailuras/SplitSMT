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

; Interface: str_split (uninterpreted)

; Additional helpers (uninterpreted where needed)
(declare-fun str_to_int (String) Int)

; ----------------------------
; SAT instance: well-formed HTTP header parsing
; ----------------------------
(declare-const req_sat String)
(declare-const first_line_sat String)
(declare-const headers_block_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_value_sat String)
(declare-const cl_value_sat String)
(declare-const cl_int_sat Int)

; Split request into lines by LF
(assert (>= (num_splits req_sat "\n") 3))
(assert (= first_line_sat (split_at req_sat "\n" 0)))
(assert (= headers_block_sat (split_rest req_sat "\n" 1)))

; First line looks like: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re first_line_sat (re.++ (re.+ (re.range "A" "Z")) (str.to_re " ") (re.+ (re.range "!" "~")) (str.to_re " ") (str.to_re "HTTP/1.1"))))

; Host header line is somewhere in header block; model it as line 0 of headers_block_sat
(assert (>= (num_splits headers_block_sat "\n") 2))
(assert (= host_line_sat (split_at headers_block_sat "\n" 0)))
(assert (str.prefixof "Host:" host_line_sat))

; Content-Length header line is line 1 of headers_block_sat
(assert (= cl_line_sat (split_at headers_block_sat "\n" 1)))
(assert (str.prefixof "Content-Length:" cl_line_sat))

; Parse key-value pairs by ':'
(assert (>= (num_splits host_line_sat ":") 2))
(assert (>= (num_splits cl_line_sat ":") 2))

; Key checks (trim not modeled; require exact keys)
(assert (= (split_at host_line_sat ":" 0) "Host"))
(assert (= (split_at cl_line_sat ":" 0) "Content-Length"))

; Values are the rest after ':'
(assert (= host_value_sat (split_rest host_line_sat ":" 1)))
(assert (= cl_value_sat (split_rest cl_line_sat ":" 1)))

; Require a space before values (common header formatting)
(assert (str.prefixof " " host_value_sat))
(assert (str.prefixof " " cl_value_sat))

; Host value basic validation: " " + hostname (letters/digits/dot/hyphen)
(assert (str.in_re host_value_sat
  (re.++
    (str.to_re " ")
    (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re ".") (str.to_re "-")))))))))

; Content-Length value validation: " " + digits
(assert (str.in_re cl_value_sat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))

; Convert Content-Length to integer (uninterpreted) and constrain it
(assert (= cl_int_sat (str_to_int cl_value_sat)))
(assert (>= cl_int_sat 0))
(assert (<= cl_int_sat 1048576))

; If Content-Length is 0 then method should be GET (simple policy example)
(assert (=> (= cl_int_sat 0) (str.prefixof "GET " first_line_sat)))

; Ensure headers block contains the required keys (redundant but realistic)
(assert (str.contains headers_block_sat "Host:"))
(assert (str.contains headers_block_sat "Content-Length:"))

; ----------------------------
; UNSAT instance: conflicting Content-Length requirements
; ----------------------------
(declare-const req_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_value_unsat String)
(declare-const cl_int_unsat Int)

(assert (>= (num_splits req_unsat "\n") 2))
(assert (= cl_line_unsat (split_at req_unsat "\n" 1)))
(assert (str.prefixof "Content-Length:" cl_line_unsat))
(assert (= (split_at cl_line_unsat ":" 0) "Content-Length"))
(assert (= cl_value_unsat (split_rest cl_line_unsat ":" 1)))
(assert (str.in_re cl_value_unsat (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))
(assert (= cl_int_unsat (str_to_int cl_value_unsat)))

; Contradiction: must be both 5 and 7
(assert (= cl_int_unsat 5))
(assert (= cl_int_unsat 7))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
