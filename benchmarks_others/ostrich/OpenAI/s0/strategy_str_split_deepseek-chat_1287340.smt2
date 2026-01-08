(set-logic ALL)

; --- Uninterpreted interface: str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Helpers (uninterpreted, non-primitive) ---
(declare-fun isLowerAlphaNum (String) Bool)
(declare-fun isLabelChar (String) Bool)

; =====================
; SAT instance: complex-ish email validation
; =====================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const second_level_ok String)
(declare-const subdomain_ok String)

; Split at '@' must yield at least 2 segments, and we validate first two explicitly
(assert (>= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local part constraints: non-empty, no '@', and made of allowed characters (abstracted)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (isLowerAlphaNum local_ok))

; Domain must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))

; Constrain a 3-label domain: subdomain.secondlevel.tld
(assert (= subdomain_ok (split_at domain_ok "." 0)))
(assert (= second_level_ok (split_at domain_ok "." 1)))
(assert (= tld_ok (split_at domain_ok "." 2)))
(assert (>= (num_splits domain_ok ".") 3))

; No empty labels
(assert (> (str.len subdomain_ok) 0))
(assert (> (str.len second_level_ok) 0))
(assert (> (str.len tld_ok) 0))

; Basic label structure: no spaces and abstracted allowed characters
(assert (not (str.contains domain_ok " ")))
(assert (isLabelChar subdomain_ok))
(assert (isLabelChar second_level_ok))
(assert (isLabelChar tld_ok))

; TLD length constraint typical for validation
(assert (and (>= (str.len tld_ok) 2) (<= (str.len tld_ok) 24)))

; Enforce reconstructability via split_rest to connect structure
(assert (= (split_rest domain_ok "." 1) (str.++ second_level_ok "." tld_ok)))

; Concrete witness to ensure satisfiable
(assert (= email_ok "alice123@mx.example.com"))

; =====================
; UNSAT instance: contradictory email requirements
; =====================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(assert (= email_bad "bob@site.com"))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain split: for "site.com", the TLD is "com" (length 3)
(assert (= tld_bad (split_at domain_bad "." 1)))
(assert (>= (num_splits domain_bad ".") 2))

; Contradiction: demand TLD length 2 and also equal to "com"
(assert (= tld_bad "com"))
(assert (= (str.len tld_bad) 2))

; Additional contradiction: claim there are at least 3 labels in "site.com"
(assert (>= (num_splits domain_bad ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
