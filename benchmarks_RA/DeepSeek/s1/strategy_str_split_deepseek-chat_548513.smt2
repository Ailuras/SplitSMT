; HTTP Header Parsing with str_split operations
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

; Declare variables
(declare-const request String)
(declare-const content_length String)
(declare-const host String)
(declare-const user_agent String)
(declare-const num_headers Int)

; Declare str_split interface functions

; Constraint 1: Request must contain at least 3 headers (split by newline)
(assert (>= (num_splits request "\n") 3))

; Constraint 2: Extract host from first header line (split by colon)
(assert (= host (split_at (split_at request "\n" 0) ":" 1)))

; Constraint 3: Extract user-agent from second header line
(assert (= user_agent (split_at (split_at request "\n" 1) ":" 1)))

; Constraint 4: Extract content-length from third header line
(assert (= content_length (split_at (split_at request "\n" 2) ":" 1)))

; Constraint 5: Content-length must be a non-empty string
(assert (not (= (str.len content_length) 0)))

; Constraint 6: Content-length must be a valid integer (digits only)
(assert (str.in_re content_length (re.+ (re.range "0" "9"))))

; Constraint 7: Host must contain a dot (domain validation)
(assert (str.contains host "."))

; Constraint 8: User-agent must not be empty
(assert (not (= (str.len user_agent) 0)))

; Constraint 9: Request must end with a newline
(assert (str.suffixof "\n" request))

; Constraint 10: Total number of header lines (excluding empty ones)
(assert (= num_headers (num_splits request "\n")))
(assert (>= num_headers 3))
(assert (<= num_headers 5))

; Constraint 11: Content-length value must be between 100 and 10000
(assert (let ((cl_int (str.to_int content_length)))
  (and (>= cl_int 100) (<= cl_int 10000))))

; Constraint 12: First header line must start with "Host:"
(assert (str.prefixof "Host:" (split_at request "\n" 0)))

; Constraint 13: Second header line must start with "User-Agent:"
(assert (str.prefixof "User-Agent:" (split_at request "\n" 1)))

; Constraint 14: Third header line must start with "Content-Length:"
(assert (str.prefixof "Content-Length:" (split_at request "\n" 2)))

; Constraint 15: All header lines must have exactly one colon
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i num_headers))
      (= (num_splits (split_at request "\n" i) ":") 2))))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
