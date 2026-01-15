(set-logic ALL)

; Uninterpreted interface operations for string splitting

; Seed-style boolean structure retained and extended
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)

(declare-fun var_0xINPUT_151642 () String)

; Email-related segments
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

; Preserve core seed constraints: input not "-" and not empty
(assert (= T_1 (= "-" var_0xINPUT_151642)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_151642)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Basic email split around '@'
(assert (= local_part (str.split_at var_0xINPUT_151642 "@" 0)))
(assert (= domain_part (str.split_at var_0xINPUT_151642 "@" 1)))

; Must have exactly one '@' -> two segments
(assert (= T_5 (= (str.num_splits var_0xINPUT_151642 "@") 2)))
(assert T_5)

; Local and domain parts must be non-empty
(assert (= T_6 (and (> (str.len local_part) 0) (> (str.len domain_part) 0))))
(assert T_6)

; Local part should not start or end with '.' and should not contain ".."
(assert (= T_7 (and (not (= (str.at local_part 0) "."))
                    (not (= (str.at local_part (- (str.len local_part) 1)) "."))
                    (not (str.contains local_part "..")))))
(assert T_7)

; Domain structure: at least two labels separated by '.'
(assert (>= (str.num_splits domain_part ".") 2))
(assert (= domain_label0 (str.split_at domain_part "." 0)))
(assert (= domain_label1 (str.split_at domain_part "." 1)))
(assert (= tld (str.split_at domain_part "." (- (str.num_splits domain_part ".") 1))))

; Each domain label should be non-empty
(assert (and (> (str.len domain_label0) 0)
             (> (str.len domain_label1) 0)
             (> (str.len tld) 1)))

; Domain should not contain consecutive dots, and should not start/end with '.'
(assert (= T_8 (and (not (str.contains domain_part ".."))
                    (not (= (str.at domain_part 0) "."))
                    (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))))
(assert T_8)

; SAT email example witness constraint (keeps instance satisfiable)
(assert (= T_9 (= var_0xINPUT_151642 "user.name+tag@example.co")))
(assert T_9)

; Additional UNSAT sub-instance under a guard (kept inactive to preserve SAT):
; if activated, it would require an impossible domain with exactly one label and >=2 labels simultaneously.
(declare-const unsat_guard Bool)
(assert (not unsat_guard))
(assert (=> unsat_guard (and (= (str.num_splits domain_part ".") 1)
                             (>= (str.num_splits domain_part ".") 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
