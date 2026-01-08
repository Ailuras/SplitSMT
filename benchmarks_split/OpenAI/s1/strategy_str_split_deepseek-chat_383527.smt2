(set-logic ALL)

; --- Uninterpreted interface operations for str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables (mutated/extended from seed) ---
(declare-const T1_3 String)
(declare-const T2_3 String)
(declare-const T_1 String)
(declare-const T_2 Bool)
(declare-const var_0xINPUT_96358 String)

; Email-related helpers
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const domain_has_dot Bool)
(declare-const email_has_at Bool)

; --- Core seed structure retained but repurposed to email pipeline ---
(assert (= T_1 (str.++ T1_3 T2_3)))
(assert (= T2_3 var_0xINPUT_96358))
(assert (= T1_3 ""))

; Tie the seed input to an email string
(assert (= email T_1))

; --- Email validation constraints using '@' and '.' delimiters ---
; Must have exactly one '@' -> num_splits(email,"@") = 2 segments
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part constraints (non-empty, no spaces)
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))

; Domain constraints: must contain at least one '.' => at least 2 segments after split
(assert (= domain_has_dot (>= (num_splits domain ".") 2)))
(assert domain_has_dot)

; Extract some domain labels and tld
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Labels and tld non-empty, no spaces
(assert (> (str.len domain_label0) 0))
(assert (> (str.len tld) 0))
(assert (not (str.contains domain " ")))

; Ban empty labels by forbidding consecutive dots and leading/trailing dot patterns (sound but not complete)
(assert (not (str.contains domain "..")))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Some sanity about overall email
(assert (= email_has_at (str.contains email "@")))
(assert email_has_at)
(assert (not (str.contains email "@@")))

; --- Force an UNSAT instance by requiring local part to contain '@' while having exactly one '@' total ---
; If local contains '@', then email must contain at least two '@' (one inside local plus the delimiter), contradicting num_splits=email has exactly one '@'.
(assert (str.contains local "@"))

; Keep boolean wrapper from seed (now asserting a property about the email)
(assert (= T_2 (= "-" email)))
(assert (not T_2))

(check-sat)


; [GENERATION STATUS: SUCCESS]