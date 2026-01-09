(set-logic ALL)

; Uninterpreted split interface

; Seed booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Inputs / derived segments
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const domain_left String)

; Core seed-like sanity constraints (mutated from original)
(assert (= T_1 (= "-" email)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" email)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email split at '@'
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= T_5 (= (str.num_splits email "@") 2)))
(assert T_5)

; Basic local-part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))

; Domain constraints and '.' structure
(assert (> (str.len domain) 0))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain " ")))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Split domain by '.' and require at least one dot (>=2 segments)
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_left (str.split_at domain "." 0)))
(assert (= subdomain (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Segment-level constraints
(assert (> (str.len domain_left) 0))
(assert (not (str.contains domain_left ".")))
(assert (> (str.len tld) 1))
(assert (< (str.len tld) 25))

; Some allowed-structure constraints via regex (avoid digits-only TLD)
(assert (str.in_re tld (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))))) )

; Ensure domain has no consecutive dots by forbidding ".." substring
(assert (not (str.contains domain "..")))

; Additional derived predicate: domain must have at least 3 total segments OR local contains '+'
(assert (= T_6 (or (>= (str.num_splits domain ".") 3) (str.contains local "+"))))
(assert T_6)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
