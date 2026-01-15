(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed structure (mutated/extended) with meaningful variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_130984 String)

; Email-specific variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const firstLabel String)
(declare-const secondLabel String)
(declare-const restLabels String)
(declare-const atCount Int)
(declare-const dotCount Int)

; Preserve core structure: T_1, T_2, and a final assertion that drives satisfiability
(assert (= T_1 (not (= "file:" var_0xINPUT_130984))))
(assert (= T_2 (not T_1)))

; Connect input to email scenario
(assert (= email var_0xINPUT_130984))

; Email must have exactly one '@' (2 segments after split)
(assert (= atCount (num_splits email "@")))
(assert (= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part basic sanity (non-empty, no spaces, no extra '@')
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (= (num_splits local "@") 1))

; Domain must contain at least one '.' and have at least two labels
(assert (= dotCount (num_splits domain ".")))
(assert (>= dotCount 2))

; Extract labels and suffix structure
(assert (= firstLabel (split_at domain "." 0)))
(assert (= secondLabel (split_at domain "." 1)))
(assert (= restLabels (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- dotCount 1))))
(assert (= subdomain (split_rest domain "." 0)))

; Label constraints: non-empty, no spaces
(assert (> (str.len firstLabel) 0))
(assert (> (str.len secondLabel) 0))
(assert (not (str.contains domain " ")))

; TLD constraints: length between 2 and 24, cannot contain '.'
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))
(assert (= (num_splits tld ".") 1))

; Forbid obvious malformed cases
(assert (not (str.contains email "..")))
(assert (not (str.contains email "@@")))
(assert (not (str.contains email "@.")))
(assert (not (str.contains email ".@")))

; Create a deliberate contradiction tied to the domain segmentation:
; If domain has >=2 labels then split_rest from 1 must contain a '.', but simultaneously force it to have no '.'
(assert (str.contains restLabels "."))
(assert (= (num_splits restLabels ".") 1))

; Drive UNSAT through preserved seed gate: T_2 is (not T_1)
; This forces email == "file:" but that violates the email structure above (atCount must be 2)
(assert T_2)

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
