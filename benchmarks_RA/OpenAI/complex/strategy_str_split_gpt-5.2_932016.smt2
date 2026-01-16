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

; --- Uninterpreted interface for str_split ---

; --- Seed-like variables (preserve core structure) ---
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_520976 () String)

; --- HTTP header parsing variables ---
(declare-const request String)
(declare-const headers String)
(declare-const header0 String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const h0_key String)
(declare-const h0_val String)
(declare-const h1_key String)
(declare-const h1_val String)
(declare-const contentLengthStr String)
(declare-const contentLengthVal Int)
(declare-const body String)
(declare-const bodyLen Int)

; --- Keep core structure: length and non-empty check ---
(assert (= T_1 (str.len var_0xINPUT_520976)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Tie seed input to HTTP request under analysis
(assert (= request var_0xINPUT_520976))

; Basic well-formedness: request contains header/body separator
(assert (str.contains request "\r\n\r\n"))
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= headers (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; Headers consist of request-line plus at least two header lines
(assert (>= (num_splits headers "\r\n") 3))
(assert (= header0 (split_at headers "\r\n" 1)))
(assert (= header1 (split_at headers "\r\n" 2)))
(assert (= header2 (split_at headers "\r\n" 0)))

; Each header line must be key-value separated by colon
(assert (>= (num_splits header0 ":") 2))
(assert (>= (num_splits header1 ":") 2))

; Parse header0: key and value
(assert (= h0_key (split_at header0 ":" 0)))
(assert (= h0_val (split_rest header0 ":" 1)))
; Trim requirement approximated: value starts with a space (common in HTTP)
(assert (>= (str.len h0_val) 1))
(assert (= (str.at h0_val 0) " "))

; Parse header1: key and value
(assert (= h1_key (split_at header1 ":" 0)))
(assert (= h1_val (split_rest header1 ":" 1)))
(assert (>= (str.len h1_val) 1))
(assert (= (str.at h1_val 0) " "))

; Constrain header1 to be Content-Length (case-sensitive for simplicity)
(assert (= h1_key "Content-Length"))
; Forbid empty value after the space
(assert (> (str.len h1_val) 1))

; Extract the digits part of Content-Length by skipping the leading space
(assert (= contentLengthStr (str.substr h1_val 1 (- (str.len h1_val) 1))))

; Content-Length must be digits only (non-empty)
(assert (>= (str.len contentLengthStr) 1))
(assert (str.in_re contentLengthStr (re.+ (re.range "0" "9"))))

; Interpret numeric value via an uninterpreted relation to allow string/integer connection
(declare-fun parse_int (String) Int)
(assert (= contentLengthVal (parse_int contentLengthStr)))

; Body length accounting
(assert (= bodyLen (str.len body)))

; --- Create both SAT and UNSAT branches within one file using disjunction ---
; Branch A (SAT-like): contentLengthVal matches bodyLen and is non-negative
; Branch B (UNSAT-like): contentLengthVal mismatches bodyLen and equals bodyLen simultaneously
(assert (or
  (and (>= contentLengthVal 0)
       (= contentLengthVal bodyLen)
       (str.contains headers "Content-Length"))
  (and (not (= contentLengthVal bodyLen))
       (= contentLengthVal bodyLen))))

; Additional sanity: request-line must start with method token
(assert (or (str.prefixof "GET " header2)
            (str.prefixof "POST " header2)
            (str.prefixof "HEAD " header2)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
