(set-logic ALL)

; --- Uninterpreted split interface (str_split) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Primary email instance (intended SAT) ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)
(declare-const suffix String)
(declare-const hostLabel0 String)
(declare-const hostLabel1 String)

(declare-const k0 Int)
(declare-const k1 Int)

; Basic email shape: local@domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_at email "@" 2)))
(assert (= 2 (num_splits email "@")))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; local-part sanity: no '@' and no spaces
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))

; Domain must have at least one '.' and end with a non-empty TLD segment
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))
(assert (>= (str.len host) 1))
(assert (>= (str.len tld) 2))

; Domain should not contain '@' and no empty labels at boundaries for the chosen split
(assert (not (str.contains domain "@")))
(assert (not (str.contains host "@")))
(assert (not (str.contains tld "@")))
(assert (not (= host "")))
(assert (not (= tld "")))

; Ensure there is no trailing '.' in domain by forcing the "rest" after first '.' to be non-empty
(assert (= suffix (split_rest domain "." 1)))
(assert (>= (str.len suffix) 2))

; Add diversity via constrained index variables (natural, in-range style)
(assert (= k0 0))
(assert (= k1 1))
(assert (>= k0 0))
(assert (>= k1 0))
(assert (< k0 (num_splits email "@")))
(assert (< k1 (num_splits email "@")))

; A slightly more structured host: at least 2 labels when splitting host by '-'
(assert (>= (num_splits host "-") 1))
(assert (= hostLabel0 (split_at host "-" 0)))
(assert (>= (str.len hostLabel0) 1))
(assert (= hostLabel1 (split_at host "-" 1)))
(assert (or (= hostLabel1 "") (>= (str.len hostLabel1) 1)))

; Concrete witness to ensure satisfiable under uninterpreted split functions
(assert (= email "alice.smith@sub-domain.example"))

(check-sat)

; --- Secondary email instance (intended UNSAT): contradictory segment counts ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= email_bad "bob@example.com"))

; Contradiction: claims there are 2 segments but also 3 segments for the same split
(assert (= 2 (num_splits email_bad "@")))
(assert (= 3 (num_splits email_bad "@")))

(check-sat)


; [GENERATION STATUS: SUCCESS]