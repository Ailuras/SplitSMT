(set-logic ALL)

; Email Validation scenario using str_split interface

; Seed-style booleans/ints kept, but repurposed toward email structure checks
(declare-fun T_6 () Bool)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_SELECT_2 () Bool)
(declare-fun I0_14 () Int)
(declare-fun I0_6 () Int)
(declare-fun I1_14 () Int)
(declare-fun I2_14 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun T_a () Int)
(declare-fun T0_6 () String)
(declare-fun T1_6 () String)
(declare-fun T2_6 () String)
(declare-fun T3_6 () String)
(declare-fun T4_6 () String)
(declare-fun T5_6 () String)
(declare-fun var_0xINPUT_14469 () String)

; New email-specific variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)
(declare-const subdomain String)

; Preserve core concatenation structure from seed, but reinterpret as building an email
(assert (= email var_0xINPUT_14469))
(assert (= var_0xINPUT_14469 (str.++ T0_6 T1_6)))
(assert (= T1_6 (str.++ T2_6 T3_6)))
(assert (= T2_6 (str.++ T4_6 T5_6)))

; Force overall structure: local@domain
(assert (= T0_6 local))
(assert (= T4_6 (str.++ local "@")))
(assert (= T5_6 domain))

; Basic email delimiter constraints with str_split
(assert (>= (str.num_splits email "@") 2))
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Domain must have at least one dot: host.tld, and exactly one dot for this instance
(assert (= (str.num_splits domain ".") 2))
(assert (= host (str.split_at domain "." 0)))
(assert (= tld (str.split_at domain "." 1)))

; Additional structure: host may be split by '-' into subdomain-rest (not necessarily present)
(assert (>= (str.num_splits host "-") 1))
(assert (= subdomain (str.split_at host "-" 0)))

; Length constraints inspired by seed integer plumbing
(assert (= I0_6 (str.len local)))
(assert (>= I0_6 1))
(assert (<= I0_6 64))
(assert (= I1_14 (str.len domain)))
(assert (>= I1_14 3))
(assert (<= I1_14 255))

; Local part must not start with '.' and must not contain spaces
(assert (not (= (str.at local 0) ".")))
(assert (not (str.contains local " ")))

; Domain must not contain spaces and host/tld must be non-empty
(assert (not (str.contains domain " ")))
(assert (>= (str.len host) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; TLD alphabetic lowercase constraint via regex (simple)
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Keep seed-like predicate structure but adapted to bounds checking
(assert (= PCTEMP_LHS_1 (+ I0_6 0)))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert T_SELECT_1)

(assert (= T_a (+ PCTEMP_LHS_1 7)))
(assert (>= T_a 0))
(assert (= I0_14 (- PCTEMP_LHS_2 T_a)))
(assert (<= PCTEMP_LHS_2 I1_14))
(assert (= I2_14 I1_14))
(assert (>= PCTEMP_LHS_2 T_a))

(assert (= T_SELECT_2 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (= T_8 (< PCTEMP_LHS_2 0)))
(assert (= T_9 (not T_8)))
(assert T_9)

; Make it SAT: pick consistent PCTEMP_LHS_2 and enforce T_6 similarly
(assert (= PCTEMP_LHS_2 (+ T_a 1)))
(assert (= T_6 (< (- 1) PCTEMP_LHS_1)))
(assert T_6)

; Extra email validity: no consecutive dots in local or domain
(assert (not (str.contains local "..")))
(assert (not (str.contains domain "..")))

; Prevent empty segments around '@' and '.'
(assert (>= (str.len (str.split_at email "@" 0)) 1))
(assert (>= (str.len (str.split_at email "@" 1)) 3))
(assert (>= (str.len (str.split_at domain "." 0)) 1))
(assert (>= (str.len (str.split_at domain "." 1)) 2))

; Provide a concrete satisfying pattern while still allowing variation
(assert (str.in_re local (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (str.to_re "_")))) (re.* (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "."))))))))
(assert (str.in_re host (re.++ (re.+ (re.union (re.range "a" "z") (re.range "0" "9"))) (re.* (re.union (re.union (re.range "a" "z") (re.range "0" "9")) (str.to_re "-"))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
