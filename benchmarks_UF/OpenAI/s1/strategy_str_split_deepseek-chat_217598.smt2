(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface

; Email validation scenario
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)

; Preserve and adapt core regex-based structure from seed (mutated)
; Local-part: only lowercase letters a..u, non-empty
(assert (str.in_re local (re.+ (re.range "a" "u"))))

; Additional structured local constraint: must contain an 'a', and then only a/b afterwards
(assert (str.in_re local (re.++ (re.* (re.union (str.to_re "b") (re.range "c" "u"))) (re.++ (str.to_re "a") (re.* (re.union (str.to_re "a") (str.to_re "b")))))))

; Domain: lowercase letters and dots, must include at least one dot
(assert (str.in_re domain (re.++ (re.+ (re.range "a" "z")) (re.++ (str.to_re ".") (re.+ (re.range "a" "z"))))))

; Whole email must have exactly one '@' (two segments when split)
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Domain must split into exactly two labels by '.' (host.tld)
(assert (= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Host label constraints
(assert (str.in_re host (re.+ (re.range "a" "z"))))
(assert (>= (str.len host) 2))

; TLD constraints: 2 to 6 lowercase letters
(assert (str.in_re tld (re.++ (re.range "a" "z") (re.+ (re.range "a" "z")))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Link email string structurally
(assert (= email (str.++ local (str.++ "@" domain))))

; Keep a seed-like sanity assertion
(assert (not (str.in_re "" re.none)))

; UNSAT tweak: require an impossible split count for the same domain
(assert (= (num_splits domain ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
