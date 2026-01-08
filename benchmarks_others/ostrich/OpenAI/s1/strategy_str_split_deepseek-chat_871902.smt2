(set-logic ALL)

; Email Validation scenario using str_split with '@' and '.' delimiters

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_rest String)
(declare-const tld String)

(declare-const atCount Int)
(declare-const dotCountDomain Int)

; Core: exactly one '@' => two segments
(assert (= atCount (num_splits email "@")))
(assert (= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part must be non-empty and not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))

; Local-part regex: [A-Za-z0-9._%+-]+ (no spaces)
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-") ))))

; Domain must be non-empty, contain at least one '.' and not contain '@'
(assert (> (str.len domain) 0))
(assert (not (str.contains domain "@")))
(assert (= dotCountDomain (num_splits domain ".")))
(assert (>= dotCountDomain 2))

; Constrain first domain label and rest via split operations
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= domain_rest (split_rest domain "." 1)))
(assert (> (str.len domain_first_label) 0))
(assert (> (str.len domain_rest) 0))

; Domain label allowed chars (simplified): [A-Za-z0-9-]+ and must not start or end with '-'
(assert (str.in_re domain_first_label (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") ))))
(assert (not (= (str.at domain_first_label 0) "-")))
(assert (not (= (str.at domain_first_label (- (str.len domain_first_label) 1)) "-")))

; TLD is last label after splitting domain by '.'
(assert (= tld (split_at domain "." (- dotCountDomain 1))))

; TLD must be only letters, length 2..6
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; SAT-leaning example constraint: email must contain a '+' tag or be in a specific domain
(assert (or (str.contains local "+") (= tld "com")))

; UNSAT-inducing constraint removed: ensure consistency (do not force contradictions)

(check-sat)


; [GENERATION STATUS: SUCCESS]
