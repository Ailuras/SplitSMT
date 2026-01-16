(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation scenario using '@' and '.' delimiters via str_split interface


(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const firstLabel String)
(declare-const tld String)
(declare-const domainRest String)
(declare-const dotCount Int)
(declare-const atCount Int)

; Core split structure
(assert (= atCount (num_splits email "@")))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= dotCount (num_splits domain ".")))
(assert (= firstLabel (split_at domain "." 0)))
(assert (= domainRest (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- dotCount 1))))

; Segment count constraints: exactly one '@', and at least one '.' in domain
(assert (= atCount 2))
(assert (>= dotCount 2))

; Basic non-emptiness and length bounds
(assert (> (str.len email) 5))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))
(assert (>= (str.len firstLabel) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len local) 64))
(assert (<= (str.len domain) 255))

; Local-part allowed pattern: [A-Za-z0-9._%+-]+ (no spaces)
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))

; Local-part should not start or end with '.' and must not contain ".."
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; Domain labels pattern: label is alnum/hyphen, no leading/trailing hyphen
(assert (str.in_re firstLabel (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (= (str.at firstLabel 0) "-")))
(assert (not (= (str.at firstLabel (- (str.len firstLabel) 1)) "-")))

; domainRest comprises remaining labels joined by '.', disallow empty label via "." adjacency
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; TLD letters only, length 2..24
(assert (str.in_re tld (re.++ ((_ re.loop 2 24) (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.* (str.to_re "")))))

; Ensure email has no spaces and no additional '@' in domain
(assert (not (str.contains email " ")))
(assert (not (str.contains domain "@")))

; UNSAT twist: require both that domain contains a dot (already) and that it contains no dot
(assert (not (str.contains domain ".")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
