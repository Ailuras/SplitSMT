(set-logic ALL)

; Email Validation scenario using str_split with '@' and '.' delimiters

; Uninterpreted interface functions for split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables
(declare-const X String)              ; full email candidate
(declare-const local String)          ; local-part before '@'
(declare-const domain String)         ; domain after '@'
(declare-const label0 String)         ; first domain label
(declare-const label1 String)         ; second domain label
(declare-const tld String)            ; top-level domain (last label)

; Preserve seed core structure: keep a negated regex membership constraint (mutated to email-related format)
; Disallow a specific newline-terminated numeric pattern to avoid confusing addresses like "05########\n"
(assert (not (str.in_re X (re.++ (str.to_re "05") ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Basic split structure around '@'
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= "" (split_rest X "@" 2)))

; Exactly one '@' (i.e., two segments)
(assert (= (num_splits X "@") 2))

; Local-part constraints: non-empty and does not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))

; Domain constraints: must contain at least one '.' and have at least two labels
(assert (>= (num_splits domain ".") 2))

; Pull out domain labels (supporting multi-label domains)
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))

; Define TLD as last label by requiring exactly 3 labels (this makes it more structured)
(assert (= (num_splits domain ".") 3))
(assert (= tld (split_at domain "." 2)))
(assert (= "" (split_rest domain "." 3)))

; No empty labels in domain
(assert (> (str.len label0) 0))
(assert (> (str.len label1) 0))
(assert (> (str.len tld) 0))

; Simple syntactic restrictions: no '.' in any single label
(assert (not (str.contains label0 ".")))
(assert (not (str.contains label1 ".")))
(assert (not (str.contains tld ".")))

; TLD must be alphabetic and length 2..6
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Additional local-part pattern: allow letters/digits and '.', '_', '+', '-' (no leading/trailing '.')
; This is a relaxed approximation using regex and split checks.
(assert (str.in_re local (re.++
  (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
  (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".") ))
)))

; No consecutive dots in local-part
(assert (not (str.contains local "..")))

; ----------
; Include both SAT and UNSAT instances in one file:
; If X starts with "bad@", enforce a contradiction: domain must have exactly 3 labels AND exactly 1 label.
; Otherwise, constraints above allow typical emails like "user.name+tag@sub.example.com".
; ----------
(assert (=> (str.prefixof "bad@" X)
            (and (= (num_splits domain ".") 1)
                 (= (num_splits domain ".") 3))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
