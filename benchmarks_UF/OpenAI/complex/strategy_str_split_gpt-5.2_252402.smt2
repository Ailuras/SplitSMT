(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation scenario using str_split-style constraints and regex


(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)

; Preserve mutated core structure from seed: keep a negated regex membership check
(assert (not (str.in_re email (re.++ (str.to_re "Apofis") (re.* re.allchar) (str.to_re "Port.") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "/NFO,Registered\u{a}")))))

; Basic split around '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (num_splits email "@") 2))

; Local and domain must be non-empty
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Domain must not contain '@'
(assert (= (num_splits domain "@") 1))

; Domain structure: at least one '.'
(assert (>= (num_splits domain ".") 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len first_label) 0))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Local-part should not contain spaces and should not start with '.'
(assert (= (num_splits local " ") 1))
(assert (not (= (str.at local 0) ".")))

; Restrict TLD to letters only (simple validation)
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; SAT instance: provide a concrete email satisfying constraints
(assert (= email "alice.smith+tag@sub.example.COM"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
