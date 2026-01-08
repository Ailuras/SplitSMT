(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface for string split constraints

; ----------------------------
; SAT instance: plausible complex email validation
; ----------------------------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const domain_label1 String)
(declare-const domain_rest2 String)
(declare-const tld String)

; Basic structure: local@domain
(assert (>= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_rest email "@" 2)))

; local-part constraints: non-empty, no spaces, no '@', contains a '.' (complexity)
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (str.contains local "."))

; domain constraints: non-empty, no spaces, contains at least one dot
(assert (> (str.len domain) 0))
(assert (not (str.contains domain " ")))
(assert (str.contains domain "."))

; Domain split by '.' => at least 2 labels; constrain first three labels for structure
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_rest1 (split_rest domain "." 1)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= domain_rest2 (split_rest domain "." 2)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Label constraints: non-empty and no illegal separators
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 1))
(assert (not (str.contains domain_label0 "@")))
(assert (not (str.contains domain_label0 ".")))
(assert (not (str.contains domain_label1 "@")))
(assert (not (str.contains domain_label1 ".")))
(assert (not (str.contains tld "@")))
(assert (not (str.contains tld ".")))

; Ensure there is no trailing dot and no empty last segment
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Force a concrete satisfying example (keeps this instance SAT)
(assert (= email "first.last@sub.example.co"))

; ----------------------------
; UNSAT instance: contradictory domain structure
; ----------------------------
(declare-const email_bad String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)
(declare-const bad_label0 String)

(assert (>= (num_splits email_bad "@") 2))
(assert (= bad_local (split_at email_bad "@" 0)))
(assert (= bad_domain (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))

; Require a dot in the domain, but also assert domain has exactly one segment when split by '.' (contradiction)
(assert (str.contains bad_domain "."))
(assert (= (num_splits bad_domain ".") 1))

; Additional constraints (consistent by themselves)
(assert (> (str.len bad_local) 0))
(assert (not (str.contains bad_local " ")))
(assert (= bad_label0 (split_at bad_domain "." 0)))
(assert (= bad_tld (split_at bad_domain "." (- (num_splits bad_domain ".") 1))))
(assert (> (str.len bad_tld) 1))

; Anchor to a concrete email that still cannot satisfy the contradictory split constraints
(assert (= email_bad "a@b.c"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
