(set-logic ALL)

; Scenario: Email Validation using str_split interface

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Email and derived parts
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const tld String)

; Extra variables retained/mutated from seed to preserve structure diversity
(declare-const key1 String)
(declare-const key2 String)
(declare-const value1 String)
(declare-const value2 String)

; Core email split constraints: one '@', domain has at least one '.'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= 2 (num_splits email "@")))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Domain structure with '.' delimiter
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_rest1 (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Basic segment validity
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; No empty labels: forbid consecutive dots and leading/trailing dot
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Local-part restrictions: no spaces, no consecutive dots, cannot start/end with dot
(assert (not (str.contains local " ")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Ensure '@' not present in either part (reinforces split correctness)
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; TLD character policy (approx): must be lowercase alpha only using regex
(assert (str.in_re tld (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))

; Mutated seed-like noise constraints (kept but aligned with email flavor)
(assert (and
  (not (= (ite (= key1 "cache-control") 1 0) 0))
  (not (= (ite (= key2 "cache-control") 1 0) 0))
  (not (not (= (ite (str.contains value1 "=") 1 0) 0)))
  (not (= (ite (= (str.indexof value1 "=" 0) (- 1)) 1 0) 0))
  (>= (+ (str.indexof value1 "=" 0) 1) 0)
  (>= (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)) 0)
  (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))
  (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))
  (not (str.contains value2 "@"))
))

; UNSAT twist: require exactly 2 labels in domain but also require a third label exists
(assert (= (num_splits domain ".") 2))
(assert (>= (num_splits domain ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]