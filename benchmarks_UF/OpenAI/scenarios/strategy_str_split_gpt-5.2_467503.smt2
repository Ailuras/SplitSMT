(set-logic ALL)

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Inputs / derived fields
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const user String)
(declare-const plus_tag String)
(declare-const first_label String)
(declare-const second_label String)
(declare-const tld String)
(declare-const subdomain_rest String)
(declare-const domain_dot_count Int)
(declare-const at_count Int)

; Basic split-derived structure
(assert (= at_count (num_splits email "@")))
(assert (>= at_count 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Require at least one '.' in the domain (so at least 2 dot-separated segments)
(assert (= domain_dot_count (num_splits domain ".")))
(assert (>= domain_dot_count 2))

; Local-part rules: allow optional plus-tagging, require non-empty user
(assert (= user (split_at local_part "+" 0)))
(assert (= plus_tag (split_at local_part "+" 1)))
(assert (>= (str.len user) 1))

; Disallow empty local part and domain
(assert (>= (str.len local_part) 1))
(assert (>= (str.len domain) 1))

; Domain structure: label.label.tld (at least)
(assert (= first_label (split_at domain "." 0)))
(assert (= second_label (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- domain_dot_count 1))))
(assert (= subdomain_rest (split_rest domain "." 1)))

; Basic non-emptiness of required labels
(assert (>= (str.len first_label) 1))
(assert (>= (str.len second_label) 1))
(assert (>= (str.len tld) 2))

; No spaces or extra '@' in local or domain parts
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain "@")))

; Basic shape: must contain '@' and at least one '.' after it
(assert (str.contains email "@"))
(assert (str.contains domain "."))

; Provide a SAT instance via an explicit example that satisfies the above constraints
(assert (= email "alice+tag@sub.example.com"))

; Additional constraints on the chosen example to exercise split operations
(assert (= local_part "alice+tag"))
(assert (= domain "sub.example.com"))
(assert (= first_label "sub"))
(assert (= tld "com"))

; Create an UNSAT instance alongside (separate email) to ensure diversity
(declare-const bad_email String)
(declare-const bad_at_count Int)
(declare-const bad_domain String)
(declare-const bad_domain_dot_count Int)
(declare-const bad_tld String)

; Define a concrete invalid email: missing '.' in domain but demanded by constraints
(assert (= bad_email "bob@localhost"))
(assert (= bad_at_count (num_splits bad_email "@")))
(assert (>= bad_at_count 2))
(assert (= bad_domain (split_at bad_email "@" 1)))
(assert (= bad_domain_dot_count (num_splits bad_domain ".")))

; UNSAT trigger: require at least one '.' in domain but bad_domain has none
(assert (>= bad_domain_dot_count 2))
(assert (= bad_tld (split_at bad_domain "." (- bad_domain_dot_count 1))))
(assert (>= (str.len bad_tld) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
