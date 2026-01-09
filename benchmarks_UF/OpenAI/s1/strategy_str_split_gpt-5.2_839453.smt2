(set-logic ALL)

; Uninterpreted interface functions for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Email validation scenario variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const domain_rest String)

; Keep a trace of the seed's idea of regex-membership, but mutate to an email-related anchor
(declare-const seed_trace String)
(assert (= seed_trace "DaysLOGHost:Host:}{OS:Host:\u{a}"))
(assert (not (str.in_re email (str.to_re seed_trace))))

; Core email split around '@'
(assert (>= (str.len email) 3))
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part constraints: non-empty, no spaces, no '@'
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (= (num_splits local "@") 1))

; Domain constraints: must contain at least one '.' and have at least two labels
(assert (>= (str.len domain) 3))
(assert (>= (num_splits domain ".") 2))
(assert (= subdomain (split_at domain "." 0)))
(assert (= domain_rest (split_rest domain "." 1)))
(assert (>= (str.len subdomain) 1))
(assert (not (str.contains subdomain " ")))

; TLD is last segment after splitting domain by '.'
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))

; Simple structural reconstruction constraints (relaxation-style):
; email = local + "@" + domain
(assert (= email (str.++ local "@" domain)))

; SAT/UNSAT diversity: enforce a contradiction on forbidden '.' count in local part
; Local part must NOT have '.', but also require it to have at least one '.', making instance UNSAT.
(assert (= (num_splits local ".") 1))
(assert (>= (num_splits local ".") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]