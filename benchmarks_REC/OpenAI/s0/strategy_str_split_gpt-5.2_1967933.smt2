(set-logic ALL)

; Uninterpreted interface operations for str_split
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

; =====================
; Scenario: Email Validation
; We encode two instances:
;   (1) A satisfiable set of constraints for a plausible complex email
;   (2) An unsatisfiable set of constraints to demonstrate rejection
; =====================

; ----------
; SAT instance variables
; ----------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const dom_prefix_sat String)
(declare-const label0_sat String)
(declare-const label1_sat String)
(declare-const label2_sat String)
(declare-const n_at_sat Int)
(declare-const n_dot_sat Int)
(declare-const local_len_sat Int)
(declare-const tld_len_sat Int)

; Basic splitting structure around '@'
(assert (= n_at_sat (num_splits email_sat "@")))
(assert (= n_at_sat 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part constraints: non-empty, no '@', no spaces, includes a '+' tag
(assert (= local_len_sat (str.len local_sat)))
(assert (>= local_len_sat 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "+"))

; Domain constraints: at least 2 labels separated by '.', no spaces, no '@'
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))
(assert (= n_dot_sat (num_splits domain_sat ".")))
(assert (>= n_dot_sat 2))

; Constrain to exactly 3 labels for a complex domain: sub.example.co
(assert (= n_dot_sat 3))
(assert (= label0_sat (split_at domain_sat "." 0)))
(assert (= label1_sat (split_at domain_sat "." 1)))
(assert (= label2_sat (split_at domain_sat "." 2)))
(assert (>= (str.len label0_sat) 1))
(assert (>= (str.len label1_sat) 1))
(assert (>= (str.len label2_sat) 2))

; Reconstruct domain via split_rest and define TLD as last label
(assert (= dom_prefix_sat (split_rest domain_sat "." 0)))
(assert (= dom_prefix_sat domain_sat))
(assert (= tld_sat label2_sat))
(assert (= tld_len_sat (str.len tld_sat)))
(assert (and (>= tld_len_sat 2) (<= tld_len_sat 6)))

; Character-set style constraints using regex (approximate email validation)
; local part allowed: letters/digits and ._%+-
; domain labels allowed: letters/digits and -
(assert (str.in_re local_sat (re.+ (re.union (re.range "a" "z")
                                        (re.range "A" "Z")
                                        (re.range "0" "9")
                                        (str.to_re ".")
                                        (str.to_re "_")
                                        (str.to_re "%")
                                        (str.to_re "+")
                                        (str.to_re "-")))))
(assert (str.in_re label0_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")
                                             (re.range "0" "9")
                                             (str.to_re "-")))))
(assert (str.in_re label1_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")
                                             (re.range "0" "9")
                                             (str.to_re "-")))))
(assert (str.in_re label2_sat (re.+ (re.union (re.range "a" "z")
                                             (re.range "A" "Z")))))

; Provide a concrete satisfying witness (still allows solver freedom elsewhere)
(assert (= email_sat "john.doe+tag@sub.example.co"))

; ----------
; UNSAT instance variables
; ----------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const n_at_unsat Int)
(declare-const n_dot_unsat Int)
(declare-const tld_unsat String)
(declare-const label_last_unsat String)

; Split around '@'
(assert (= n_at_unsat (num_splits email_unsat "@")))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Force exactly one '@'
(assert (= n_at_unsat 2))

; Force domain to have at least two labels (contains a dot)
(assert (= n_dot_unsat (num_splits domain_unsat ".")))
(assert (>= n_dot_unsat 2))

; But also force domain to contain no dot -> contradiction with above when domain is concrete
(assert (not (str.contains domain_unsat ".")))

; Additionally pin the email to a concrete string with a dot in the domain
(assert (= email_unsat "alice@company.com"))

; Define last label (TLD) and require impossible length constraints
(assert (= label_last_unsat (split_at domain_unsat "." (- n_dot_unsat 1))))
(assert (= tld_unsat label_last_unsat))
(assert (< (str.len tld_unsat) 2))
(assert (> (str.len tld_unsat) 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
