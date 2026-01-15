; Scenario: Email Validation using str_split-style operations
(set-logic ALL)

; Uninterpreted interface operations for splitting

; Seed-like booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; Input email and derived parts
(declare-fun var_0xINPUT_113237 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)
(declare-const first_char_local String)
(declare-const last_char_local String)
(declare-const at_symbol String)
(declare-const dot_symbol String)

; Delimiter constants
(assert (= at_symbol "@"))
(assert (= dot_symbol "."))

; Mutate the original seed: no longer equals "-" and must look like an email
(assert (= T_1 (not (= "-" var_0xINPUT_113237))))
(assert T_1)

; Basic split around '@'
(assert (>= (str.num_splits var_0xINPUT_113237 at_symbol) 2))
(assert (= local_part (str.split_at var_0xINPUT_113237 at_symbol 0)))
(assert (= domain_part (str.split_at var_0xINPUT_113237 at_symbol 1)))

; Exactly one '@' by requiring only two segments
(assert (= (str.num_splits var_0xINPUT_113237 at_symbol) 2))

; Local-part sanity: non-empty, no dots at ends, no '@' inside
(assert (> (str.len local_part) 0))
(assert (= first_char_local (str.at local_part 0)))
(assert (= last_char_local (str.at local_part (- (str.len local_part) 1))))
(assert (not (= first_char_local dot_symbol)))
(assert (not (= last_char_local dot_symbol)))
(assert (not (str.contains local_part at_symbol)))

; Domain must contain at least one dot, and must not start/end with dot
(assert (>= (str.num_splits domain_part dot_symbol) 2))
(assert (not (= (str.at domain_part 0) dot_symbol)))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) dot_symbol)))

; Extract domain labels and TLD
(assert (= domain_label0 (str.split_at domain_part dot_symbol 0)))
(assert (= domain_label1 (str.split_at domain_part dot_symbol 1)))
(assert (= tld (str.split_at domain_part dot_symbol (- (str.num_splits domain_part dot_symbol) 1))))

; Domain labels must be non-empty and cannot contain '@'
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (not (str.contains domain_label0 at_symbol)))
(assert (not (str.contains domain_label1 at_symbol)))

; TLD constraints: length between 2 and 6, and must be alphabetic-like via regex
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Reconstruct email from parts (consistency check)
(assert (= reconstructed (str.++ local_part at_symbol domain_part)))
(assert (= reconstructed var_0xINPUT_113237))

; Extra consistency using split_rest: domain_part is rest after first split
(assert (= domain_part (str.split_rest var_0xINPUT_113237 at_symbol 1)))

; SAT/UNSAT toggle constraints: here we include both styles, but keep overall SAT by not enforcing T_2
; UNSAT example (not asserted): local_part cannot contain '@' but this would force it
(assert (= T_2 (= local_part "a@b")))
; Do not assert T_2 to keep the instance SAT

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
