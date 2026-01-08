(set-logic ALL)

; Uninterpreted interface for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Email validation scenario
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sub1 String)
(declare-const sub2 String)
(declare-const atCount Int)
(declare-const dotCount Int)
(declare-const localLen Int)
(declare-const domainLen Int)

; Preserve the seed's "not-in-regex" core structure by constraining email not to match the given path-like pattern
(assert (not (str.in_re email
  (re.++ (str.to_re "//f/1")
        ((_ re.loop 9 9) (re.range "0" "9"))
        (str.to_re "/")
        ((_ re.loop 9 10) (re.range "0" "9"))
        (re.+ (re.++ (str.to_re "/") (re.range "0" "9")))
        (str.to_re "/U\u{a}")))) )

; Split around '@'
(assert (= atCount (num_splits email "@")))
(assert (= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Basic local-part constraints
(assert (= localLen (str.len local)))
(assert (>= localLen 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (not (= (str.at local 0) ".")))

; Domain must contain at least one '.' and no spaces
(assert (= domainLen (str.len domain)))
(assert (>= domainLen 3))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))

; Split domain around '.'
(assert (= dotCount (num_splits domain ".")))
(assert (>= dotCount 2))
(assert (= sub1 (split_at domain "." 0)))
(assert (= sub2 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- dotCount 1))))

; Non-empty domain labels (at least first two and tld)
(assert (>= (str.len sub1) 1))
(assert (>= (str.len sub2) 1))
(assert (>= (str.len tld) 2))

; TLD letters only (simple approximation)
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Domain must not start or end with '.' and must not contain '..'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))
(assert (not (str.contains domain "..")))

; SAT/UNSAT diversity: force UNSAT by contradicting the required dot structure
; dotCount >= 2 above, but here dotCount = 1
(assert (= dotCount 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
