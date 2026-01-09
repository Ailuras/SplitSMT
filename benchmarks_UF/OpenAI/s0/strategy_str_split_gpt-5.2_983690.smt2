(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ============================
; SAT instance: complex but consistent email validation constraints
; ============================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const first_label_sat String)
(declare-const rest_labels_sat String)
(declare-const dot_count_sat Int)

; Split at '@' into local part and domain part
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Basic sanity: non-empty local and domain
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Disallow extra '@' in either part (approximation via segment count)
(assert (= (num_splits local_sat "@") 1))
(assert (= (num_splits domain_sat "@") 1))

; Domain must contain at least one '.' (>=2 labels)
(assert (>= (num_splits domain_sat ".") 2))
(assert (= dot_count_sat (- (num_splits domain_sat ".") 1)))
(assert (>= dot_count_sat 1))

; Extract domain labels
(assert (= first_label_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." dot_count_sat)))
(assert (= rest_labels_sat (split_rest domain_sat "." 1)))

; Non-empty first label and TLD
(assert (> (str.len first_label_sat) 0))
(assert (> (str.len tld_sat) 0))

; TLD should be alphabetic-ish length constraint (typical 2..24)
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))

; Simple local-part constraints: no spaces, at least 1 char before any dot
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))

; Require local part to start with alnum (approx by excluding common punctuation as first char)
(assert (>= (str.len local_sat) 1))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat 0) "-")))
(assert (not (= (str.at local_sat 0) "_")))

; Require the full email to have exactly one '@' and at least one '.' after it
(assert (str.contains domain_sat "."))

; Make it satisfiable by providing a concrete witness consistent with the constraints
(assert (= email_sat "alice.smith+tag@sub.example.co"))

; ============================
; UNSAT instance: contradictory email constraints
; ============================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dot_count_unsat Int)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain must have at least one dot
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= dot_count_unsat (- (num_splits domain_unsat ".") 1)))
(assert (>= dot_count_unsat 1))
(assert (= tld_unsat (split_at domain_unsat "." dot_count_unsat)))

; Contradiction: enforce TLD length >= 2, but also force it to be a single character
(assert (>= (str.len tld_unsat) 2))
(assert (= tld_unsat "c"))

; Also pin a candidate email that would otherwise be fine, to ensure the only conflict is logical
(assert (= email_unsat "bob@x.c"))

(check-sat)


; [GENERATION STATUS: SUCCESS]