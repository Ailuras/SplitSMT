(set-logic ALL)

; Email Validation via str_split: local-part@domain with dot-separated domain labels


(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

(declare-fun var_0xINPUT_35394 () String)
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

; Preserve core structure: a boolean equated to a string property, then asserted
(assert (= T_1 (= "-" var_0xINPUT_35394)))
(assert T_1)

; Tie the seed input to the email under validation
(assert (= email var_0xINPUT_35394))

; Basic delimiter split around '@'
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Require exactly one '@' -> two segments
(assert (= (str.num_splits email "@") 2))

; Local-part constraints: non-empty and no additional '@'
(assert (> (str.len local_part) 0))
(assert (= (str.num_splits local_part "@") 1))

; Domain must contain at least one '.' -> at least two labels
(assert (>= (str.num_splits domain ".") 2))

; Extract first two labels and the rest
(assert (= domain_label0 (str.split_at domain "." 0)))
(assert (= domain_label1 (str.split_at domain "." 1)))
(assert (= tld (str.split_rest domain "." 1)))

; Domain label constraints
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 0))

; TLD must be at least 2 characters
(assert (>= (str.len (str.split_at domain "." (- (str.num_splits domain ".") 1))) 2))

; SAT-oriented constraints on domain shape
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Add an intentional contradiction to create UNSAT instance while preserving structure
(assert (= T_2 (= (str.num_splits domain ".") 1)))
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
