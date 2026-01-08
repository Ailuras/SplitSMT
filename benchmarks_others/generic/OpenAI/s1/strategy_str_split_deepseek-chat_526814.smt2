(set-logic ALL)

; Email Validation scenario using '@' and '.' delimiters with str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom_first String)

; Preserve core structure: X is constrained by a couple of complex regexes, but now aligned with email-like content
; Require exactly one '@' => splitting on '@' yields 2 segments
(assert (= (num_splits X "@") 2))
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))

; Domain constraints: contains at least one '.', no spaces, does not start or end with '.'
(assert (>= (num_splits domain ".") 2))
(assert (not (str.contains domain " ")))
(assert (not (= (split_at domain "." 0) "")))
(assert (not (= (split_at domain "." (- (num_splits domain ".") 1)) "")))
(assert (= dom_first (split_at domain "." 0)))
(assert (> (str.len dom_first) 0))

; Extract TLD as last segment; require length 2..6 and letters only
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Ensure no empty label in the middle (i.e., forbid ".." in domain)
(assert (not (str.contains domain "..")))

; Mutated/repurposed regex structure: enforce overall email-like shape with allowed characters
; local: [A-Za-z0-9_+.-]+ but must not begin with '.' and must not end with '.'
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
  )))

; domain: labels [A-Za-z0-9-]+ separated by '.' and ending with alpha TLD
(assert (str.in_re domain
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.+ (re.++ (str.to_re ".") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))
  )))

; Negative constraints similar to seed style, but now banning clearly non-email artifacts
(assert (not (str.in_re X (re.++ (str.to_re "<title>") (re.* re.allchar) (str.to_re "</title>")))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.* re.allchar)))))
(assert (not (str.contains X "\u{a}")))
(assert (not (str.contains X "\u{d}")))

; SAT instance anchor: enforce a concrete-looking structure without fixing entire X
(assert (str.in_re X
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".")))
    (str.to_re "@")
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (str.to_re ".")
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))
  )))

(check-sat)


; [GENERATION STATUS: SUCCESS]
