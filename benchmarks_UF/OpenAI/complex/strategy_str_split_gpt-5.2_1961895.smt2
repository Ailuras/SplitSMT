; Email Validation scenario: mutated/extended from seed while preserving core structure
(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted split interface

; Core variable (from seed)
(declare-const X String)

; Additional email-related variables
(declare-const local String)
(declare-const domain String)
(declare-const label0 String)
(declare-const label1 String)
(declare-const tld String)

; Preserve seed-style constraints but repurpose X as an email-like string
; Disallow obvious URL marker
(assert (not (str.in_re X (re.++ (str.to_re "//") (re.+ (re.union (re.range "0" "9") (re.range "a" "f"))) (str.to_re "/iU\u{a}")))))

; Require a structured email ending with newline (\u{a})
; local: [A-Za-z0-9._%+-]+, '@', domain labels with '.', TLD 2..6 letters, then newline
(assert (str.in_re X
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))
    (str.to_re "@")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
    (re.++
      (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
      (re.++ (str.to_re ".") ((_ re.loop 2 6) (re.union (re.range "a" "z") (re.range "A" "Z"))))
    )
    (str.to_re "\u{a}")
  )
))

; Preserve seed's specific exclusion pattern (kept as a negative constraint)
(assert (not (str.in_re X (str.to_re "Host:hirmvtg/ggqh.kqh\u{1b}verA-Spy\u{a}"))))

; Email split constraints using '@' and '.' delimiters
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= (num_splits X "@") 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Domain must have at least 3 labels: e.g., a.b.cc
(assert (>= (num_splits domain ".") 3))
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Label constraints: non-empty and no leading/trailing hyphen
(assert (>= (str.len label0) 1))
(assert (>= (str.len label1) 1))
(assert (not (= (str.at label0 0) "-")))
(assert (not (= (str.at label1 0) "-")))
(assert (not (= (str.at label0 (- (str.len label0) 1)) "-")))
(assert (not (= (str.at label1 (- (str.len label1) 1)) "-")))

; Local-part constraints: no starting dot, no consecutive dots
(assert (not (= (str.at local 0) ".")))
(assert (not (str.contains local "..")))

; TLD constraints: 2..6 letters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Ensure X has exactly one '@' and does not contain spaces
(assert (not (str.contains X " ")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
