(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------------
; SAT instance: complex email validation constraints
; -------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_labels_sat Int)
(declare-const tld_sat String)
(declare-const second_level_sat String)
(declare-const rest_after_sld_sat String)

; Split email by '@' into local and domain parts
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Basic shape constraints
(assert (> (str.len email_sat) 5))
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 3))

; Local part restrictions: must not contain '@' and cannot start/end with '.'
(assert (not (str.contains local_sat "@")))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Domain structure: split by '.' into at least 2 labels
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_labels_sat (num_splits domain_sat ".")))

; Require at least 3 labels total: e.g., sub.example.com
(assert (>= domain_labels_sat 3))

; Constrain the last label (TLD) and the second-to-last label
(assert (= tld_sat (split_at domain_sat "." (- domain_labels_sat 1))))
(assert (= second_level_sat (split_at domain_sat "." (- domain_labels_sat 2))))

; Ensure no empty labels in some positions and TLD looks reasonable length-wise
(assert (> (str.len tld_sat) 1))
(assert (<= (str.len tld_sat) 10))
(assert (> (str.len second_level_sat) 0))

; Ensure domain does not start or end with '.'
(assert (not (= (str.at domain_sat 0) ".")))
(assert (not (= (str.at domain_sat (- (str.len domain_sat) 1)) ".")))

; Use split_rest: from the second-level label onward, it should end with '.' ++ tld
(assert (= rest_after_sld_sat (split_rest domain_sat "." (- domain_labels_sat 2))))
(assert (= rest_after_sld_sat (str.++ second_level_sat "." tld_sat)))

; Provide a concrete satisfying witness to anchor the SAT instance
(assert (= email_sat "john.doe+tag@sub.example.co"))

; -------------------------------
; UNSAT instance: contradictory email/domain constraints
; -------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const labels_unsat Int)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain has at least 2 labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= labels_unsat (num_splits domain_unsat ".")))
(assert (= tld_unsat (split_at domain_unsat "." (- labels_unsat 1))))

; Contradiction: force TLD to be both short and long
(assert (<= (str.len tld_unsat) 2))
(assert (>= (str.len tld_unsat) 5))

; Also fix an email to make the contradiction clearly about the asserted bounds
(assert (= email_unsat "a@b.cd"))

(check-sat)


; [GENERATION STATUS: SUCCESS]