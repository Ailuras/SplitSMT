(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; --- Uninterpreted interface for str_split ---

; --- Seed-preserved literals and regex structure (mutated/extended) ---
(declare-const literal_4 String)
(assert (= literal_4 "\u{74}\u{61}\u{6b}\u{65}\u{6e}\u{3a}"))
; Keep the overall pattern: anything then a specific marker then anything
(assert (str.in_re literal_4
  (re.++ (re.* re.allchar)
    (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- Scenario: Email Validation using '@' and '.' delimiters ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)
(declare-const firstLabel String)
(declare-const secondLabel String)

; Basic split at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_at email "@" 2)))
(assert (= 2 (num_splits email "@")))

; Local part non-empty, domain non-empty
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; No nested '@' inside local or domain
(assert (= 1 (num_splits local "@")))
(assert (= 1 (num_splits domain "@")))

; Domain split by '.' must have at least 2 labels: host + tld
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (> (str.len host) 0))
(assert (> (str.len tld) 0))

; Ensure tld itself has no '.' (i.e., exactly one segment when split)
(assert (= 1 (num_splits tld ".")))

; Constrain domain to have at most 3 labels (e.g., a.b.c is allowed, a.b.c.d not)
(assert (<= (num_splits domain ".") 3))

; If 3 labels, expose them; otherwise secondLabel may be empty
(assert (= firstLabel (split_at domain "." 0)))
(assert (= secondLabel (split_at domain "." 1)))
(assert (> (str.len firstLabel) 0))
(assert (> (str.len secondLabel) 0))

; Character-level approximations via regex: forbid spaces in email
(assert (not (str.contains email " ")))

; SAT vs UNSAT diversity block: force an UNSAT condition when a flag is true
(declare-const force_unsat Bool)

; When forcing UNSAT, require both exactly one '.' in domain AND at least three labels simultaneously
(assert (=> force_unsat (and (= 2 (num_splits domain ".")) (>= (num_splits domain ".") 3))))

; Provide a satisfiable instantiation when not forcing UNSAT
(assert (=> (not force_unsat)
  (and
    (= email "alice.smith@example.com")
    (= local "alice.smith")
    (= domain "example.com")
    (= host "example")
    (= tld "com"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
