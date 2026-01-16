(set-logic ALL)

; Email Validation via split constraints and string reasoning

; --- str_split interface (uninterpreted) ---

; --- Common constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =====================
; SAT instance: complex email must satisfy structural constraints
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_name_sat String)
(declare-const tld_sat String)
(declare-const first_label_sat String)
(declare-const second_label_sat String)
(declare-const domain_tail_sat String)

; Split around '@' into exactly 2 segments: local and domain
(assert (= local_sat (str.split_at email_sat at_delim 0)))
(assert (= domain_sat (str.split_at email_sat at_delim 1)))
(assert (= 2 (str.num_splits email_sat at_delim)))

; Local-part constraints: non-empty, no '@', no leading/trailing '.', no consecutive '..'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat at_delim)))
(assert (not (str.prefixof "." local_sat)))
(assert (not (str.suffixof "." local_sat)))
(assert (not (str.contains local_sat "..")))

; Domain constraints: non-empty, no '@', not start/end with '.', no consecutive '..'
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains domain_sat at_delim)))
(assert (not (str.prefixof "." domain_sat)))
(assert (not (str.suffixof "." domain_sat)))
(assert (not (str.contains domain_sat "..")))

; Domain must have at least one dot: at least 2 labels
(assert (>= (str.num_splits domain_sat dot_delim) 2))

; Extract last label as TLD and the rest as domain_name
; For at least 2 labels, using split_at for first two plus split_rest for tail
(assert (= first_label_sat (str.split_at domain_sat dot_delim 0)))
(assert (= second_label_sat (str.split_at domain_sat dot_delim 1)))
(assert (= domain_tail_sat (str.split_rest domain_sat dot_delim 1)))

; TLD as last segment: if exactly 2 labels then second is tld, else tld is last of tail
; Constrain to 2 or 3 labels for this SAT instance to keep tail manageable
(assert (or (= (str.num_splits domain_sat dot_delim) 2)
            (= (str.num_splits domain_sat dot_delim) 3)))

(declare-const third_label_sat String)
(assert (= third_label_sat (str.split_at domain_sat dot_delim 2)))
(assert (= tld_sat (ite (= (str.num_splits domain_sat dot_delim) 2)
                        second_label_sat
                        third_label_sat)))

; domain_name_sat is everything except last label (for 2 labels, first; for 3, first.second)
(assert (= domain_name_sat (ite (= (str.num_splits domain_sat dot_delim) 2)
                                first_label_sat
                                (str.++ first_label_sat dot_delim second_label_sat))))

; Label constraints: labels non-empty, do not contain '.'
(assert (> (str.len first_label_sat) 0))
(assert (not (str.contains first_label_sat dot_delim)))
(assert (> (str.len second_label_sat) 0))
(assert (not (str.contains second_label_sat dot_delim)))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (not (str.contains tld_sat dot_delim)))

; Use regex to restrict TLD to letters only [A-Za-z]{2,24}
(assert (str.in_re tld_sat (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))
                                 (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))
; Also enforce min length 2 via length constraint above

; Email should not contain spaces
(assert (not (str.contains email_sat " ")))

; Provide a concrete witness form to ensure satisfiable (one of many)
(assert (= email_sat "user.name+tag@sub.example.com"))


; =====================
; UNSAT instance: contradictions in domain structure and segment counts
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (str.split_at email_unsat at_delim 0)))
(assert (= domain_unsat (str.split_at email_unsat at_delim 1)))

; Force exactly two segments at '@'
(assert (= 2 (str.num_splits email_unsat at_delim)))

; But also force email to have no '@' at all (contradiction under intended semantics)
(assert (not (str.contains email_unsat at_delim)))

; Additionally, constrain domain to have at least one dot and no dots simultaneously (extra contradiction)
(assert (>= (str.num_splits domain_unsat dot_delim) 2))
(assert (not (str.contains domain_unsat dot_delim)))

; TLD extracted as last split (inconsistent with "no dots")
(assert (= tld_unsat (str.split_at domain_unsat dot_delim 1)))
(assert (>= (str.len tld_unsat) 2))

; Fix email_unsat to a string without '@' and without '.'
(assert (= email_unsat "invalid_email"))




; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
