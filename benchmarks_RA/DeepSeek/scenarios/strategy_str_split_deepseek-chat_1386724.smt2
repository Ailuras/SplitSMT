; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
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

; Declare string variables for email components
(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain () String)
(declare-fun domain_parts () String)
(declare-fun tld () String)
(declare-fun subdomain () String)

; Declare integer variables for segment counts
(declare-fun at_splits () Int)
(declare-fun dot_splits () Int)
(declare-fun domain_dot_splits () Int)

; Declare boolean variables for validation checks
(declare-fun valid_email_format () Bool)
(declare-fun valid_local_part () Bool)
(declare-fun valid_domain () Bool)
(declare-fun valid_tld () Bool)

; Declare uninterpreted functions for str_split interface

; Core email validation constraints
; Constraint 1: Email must contain exactly one '@' character
(assert (= at_splits (num_splits email "@")))
(assert (= valid_email_format (= at_splits 2)))

; Constraint 2: Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Constraint 3: Local part must be non-empty and not contain '@'
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part "@")))
(assert (= valid_local_part (not (str.contains local_part "@"))))

; Constraint 4: Domain must contain at least one '.' and be non-empty
(assert (> (str.len domain) 0))
(assert (= dot_splits (num_splits domain ".")))
(assert (= valid_domain (>= dot_splits 2)))

; Constraint 5: Extract TLD (last part after last '.')
(assert (= domain_dot_splits (num_splits domain ".")))
(assert (= tld (split_at domain "." (- domain_dot_splits 1))))

; Constraint 6: TLD must be 2-4 characters long and alphabetic only
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 4))
(assert (str.in_re tld (re.* (re.union (re.range "a" "z") (re.range "A" "Z")))))
(assert (= valid_tld (and (>= (str.len tld) 2) (<= (str.len tld) 4))))

; Constraint 7: Extract subdomain (all parts before TLD)
(assert (= subdomain (split_rest domain "." 0)))
(assert (<= (num_splits subdomain ".") 3)) ; Limit subdomain depth

; Constraint 8: Additional complex pattern - email must not start or end with '.'
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Constraint 9: Ensure overall email validity
(assert (and valid_email_format valid_local_part valid_domain valid_tld))

; Constraint 10: Create both SAT and UNSAT possibilities with additional constraints
; SAT case: Valid email with specific pattern
(assert (str.contains email "example"))
; UNSAT case: Comment out to make SAT, uncomment to make UNSAT
; (assert (str.contains email "..")) ; Double dot makes invalid


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
