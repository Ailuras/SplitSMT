(set-logic ALL)

; Uninterpreted interface for string split constraints

; ------------ SAT instance: complex but plausible email validation ------------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_labels String)
(declare-const tld String)
(declare-const second_level String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const domain_len Int)
(declare-const local_len Int)
(declare-const tld_len Int)
(declare-const dot_count Int)

; Split email into local@domain
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (<= (str.num_splits email "@") 2))

; Basic non-emptiness / length checks
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 3))

; Disallow whitespace and additional '@'
(assert (not (str.contains email " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Local-part constraints: no leading/trailing dot, no consecutive dots
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))
(assert (not (str.contains local "..")))

; Domain constraints: must contain at least one dot, no leading/trailing dot, no consecutive dots
(assert (str.contains domain "."))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "..")))

; Use split on '.' to enforce domain label structure
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))

; Extract first label, second label, and top-level domain (last label)
(assert (= first_label (str.split_at domain "." 0)))
(assert (= second_level (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." (- dot_count 1))))
(assert (= rest_labels (str.split_rest domain "." 1)))

; Labels must be non-empty and contain no dots
(assert (> (str.len first_label) 0))
(assert (> (str.len second_level) 0))
(assert (> (str.len tld) 0))
(assert (not (str.contains first_label ".")))
(assert (not (str.contains second_level ".")))
(assert (not (str.contains tld ".")))

; TLD length restrictions (common email validation heuristic)
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))
(assert (<= tld_len 24))

; A mild heuristic: domain should not contain underscores
(assert (not (str.contains domain "_")))

; Ensure domain reconstruction matches prefix + rest (helps tie split_rest semantics)
(assert (= domain_labels (str.++ first_label "." rest_labels)))
(assert (= domain domain_labels))

; Provide a concrete satisfying witness to guarantee SAT
(assert (= email "john.doe+tag@sub.example.co.uk"))

; ------------ UNSAT instance: contradictory requirements for an email-like string ------------
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)
(declare-const bad_dot_count Int)

(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))
(assert (>= (str.num_splits bad_email "@") 2))
(assert (<= (str.num_splits bad_email "@") 2))

; Require a dot in domain and attempt to extract TLD
(assert (= bad_dot_count (str.num_splits bad_domain ".")))
(assert (>= bad_dot_count 2))
(assert (= bad_tld (str.split_at bad_domain "." (- bad_dot_count 1))))

; Contradiction: domain must contain a dot but is constrained to be exactly "example"
(assert (= bad_domain "example"))
(assert (str.contains bad_domain "."))

; Also pin a full email form to reinforce the contradiction
(assert (= bad_email "a@example"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
