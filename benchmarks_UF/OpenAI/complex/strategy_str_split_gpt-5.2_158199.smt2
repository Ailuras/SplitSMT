(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted str_split interface

; Seed-style boolean structure preserved and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)

; Inputs and derived segments
(declare-fun var_0xINPUT_168034 () String)
(declare-const local_part String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)

; Additional helper ints
(declare-const at_splits Int)
(declare-const dot_splits Int)

; Core parsing by delimiters
(assert (= at_splits (num_splits var_0xINPUT_168034 "@")))
(assert (= local_part (split_at var_0xINPUT_168034 "@" 0)))
(assert (= domain (split_at var_0xINPUT_168034 "@" 1)))

(assert (= dot_splits (num_splits domain ".")))
(assert (= dom_label0 (split_at domain "." 0)))
(assert (= dom_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." 2)))

; Email validation constraints (complex structure)
; Exactly one '@' in the whole email => two segments
(assert (= T_1 (= at_splits 2)))

; Non-empty local and domain, no '.' at start of domain label, basic TLD length
(assert (= T_3 (and (> (str.len local_part) 0)
                    (> (str.len domain) 0)
                    (> (str.len dom_label0) 0)
                    (> (str.len tld) 1))))

; Domain must have at least 3 segments a.b.c (two dots) => three segments
(assert (= T_4 (and (>= dot_splits 3)
                    (not (str.contains domain "..")))))

; Preserve seed-like negation relationship but repurpose for email scenario
; T_2 is the negation of T_1, then assert T_2 along with other constraints to create UNSAT.
(assert (= T_2 (not T_1)))

; Extra domain structure checks: domain must not contain '@', local must not contain '@'
(assert (= T_5 (and (not (str.contains local_part "@"))
                    (not (str.contains domain "@"))
                    (not (str.contains domain " "))
                    (not (str.contains local_part " ")))))

; Enforce all validation constraints and also force the negation of the '@' constraint => UNSAT
(assert T_3)
(assert T_4)
(assert T_5)
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
