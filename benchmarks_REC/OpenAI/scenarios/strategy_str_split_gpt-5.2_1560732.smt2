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

; Uninterpreted split interface

; Primary email under validation (intended SAT)
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const domain_suffix String)

; Secondary email constrained to be invalid (intended UNSAT)
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)

; ----------------------------
; SAT-style constraints: complex email format
; ----------------------------

; Exactly one '@' separator: local@domain
(assert (= (num_splits email "@") 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_at email "@" 1)))

; Non-empty local and domain parts
(assert (>= (str.len local_part) 1))
(assert (>= (str.len domain_part) 1))

; Basic local-part sanity (not exhaustive RFC): no spaces, no '@'
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "@")))

; Require at least one dot in the domain (i.e., at least 2 labels)
(assert (>= (num_splits domain_part ".") 2))

; Constrain domain structure: label0.label1.<suffix>
; Ensure at least 3 segments so we can name two labels and a TLD/suffix
(assert (>= (num_splits domain_part ".") 3))
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= domain_suffix (split_rest domain_part "." 2)))

; domain_suffix must contain at least one dot so there is a final tld segment
(assert (>= (num_splits domain_suffix ".") 2))

; Define tld as the last segment by splitting domain_suffix on '.'
(assert (= tld (split_at domain_suffix "." (- (num_splits domain_suffix ".") 1))))

; Domain labels must be non-empty and should not contain '@' or spaces
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len domain_label1) 1))
(assert (not (str.contains domain_label0 "@")))
(assert (not (str.contains domain_label1 "@")))
(assert (not (str.contains domain_label0 " ")))
(assert (not (str.contains domain_label1 " ")))

; Disallow underscores in the first two domain labels (common hostname rule)
(assert (not (str.contains domain_label0 "_")))
(assert (not (str.contains domain_label1 "_")))

; tld constraints: at least 2 chars, no digits, no hyphen, no spaces
(assert (>= (str.len tld) 2))
(assert (not (str.contains tld "-")))
(assert (not (str.contains tld " ")))
(assert (not (str.contains tld "0")))
(assert (not (str.contains tld "1")))
(assert (not (str.contains tld "2")))
(assert (not (str.contains tld "3")))
(assert (not (str.contains tld "4")))
(assert (not (str.contains tld "5")))
(assert (not (str.contains tld "6")))
(assert (not (str.contains tld "7")))
(assert (not (str.contains tld "8")))
(assert (not (str.contains tld "9")))

; Ensure the overall email contains '@' and '.' in the domain
(assert (str.contains email "@"))
(assert (str.contains domain_part "."))

; Provide a concrete witness pattern to keep this part satisfiable
(assert (= email "alice.smith+tag@sub.example.co.uk"))

; ----------------------------
; UNSAT-style constraints: force contradictory email requirements
; ----------------------------

; bad_email is constrained to have exactly one '@'
(assert (= (num_splits bad_email "@") 2))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))

; But simultaneously require it has zero '@' occurrences (contradiction with contains)
(assert (not (str.contains bad_email "@")))

; Additionally require domain has at least one dot, yet also assert it has only 1 segment on '.' (contradiction)
(assert (str.contains bad_domain "."))
(assert (= (num_splits bad_domain ".") 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
