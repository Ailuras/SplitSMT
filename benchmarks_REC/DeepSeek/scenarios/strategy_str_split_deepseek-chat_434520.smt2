; Email validation scenario using str_split operations
; Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added constraints for segment counts and domain structure
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

; Declare string variables for email components
(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain () String)
(declare-fun domain_name () String)
(declare-fun tld () String)

; Declare integer variables for validation
(declare-fun at_count () Int)
(declare-fun dot_count () Int)
(declare-fun local_len () Int)
(declare-fun domain_len () Int)

; Declare str_split interface functions

; Email must contain exactly one '@' character
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))  ; Exactly one '@' means 2 segments

; Extract local part (before '@') and domain (after '@')
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part must be non-empty and reasonable length
(assert (= local_len (str.len local_part)))
(assert (>= local_len 1))
(assert (<= local_len 64))

; Domain must contain at least one '.'
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))  ; At least one '.' means at least 2 segments

; Extract domain name and TLD
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))  ; Everything after first dot

; Domain name must be non-empty
(assert (> (str.len domain_name) 0))

; TLD must be at least 2 characters
(assert (>= (str.len tld) 2))

; Additional constraints for valid email format
; Local part cannot start or end with '.'
(assert (not (str.prefixof "." local_part)))
(assert (not (str.suffixof "." local_part)))

; Domain cannot start or end with '.'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Domain must be reasonable length
(assert (= domain_len (str.len domain)))
(assert (>= domain_len 4))  ; Minimum: a.b
(assert (<= domain_len 255))

; Email must match typical pattern: local@domain.tld
; Using regex to ensure basic structure
(assert (str.in_re email (re.++
  (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") 
                  (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
  (str.to_re "@")
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
    (re.++
      (str.to_re ".")
      (re.union
        (re.++ (re.range "a" "z") (re.range "a" "z"))
        (re.++ (re.range "a" "z") (re.range "a" "z") (re.range "a" "z"))
        (re.++ (re.range "a" "z") (re.range "a" "z") (re.range "a" "z") (re.range "a" "z"))
      )
    )
  )
)))

; Ensure the email is not too short overall
(assert (>= (str.len email) 6))

; Create both SAT and UNSAT possibilities by adding optional constraints
; Comment out one of the following to switch between SAT/UNSAT

; SAT version: valid email
(assert (str.contains email "example.com"))

; UNSAT version: invalid email (uncomment to use instead)
; (assert (str.contains email ".."))  ; Double dot in domain
; (assert (str.contains local_part "@"))  ; '@' in local part

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
