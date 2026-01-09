(set-logic ALL)

; Uninterpreted string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core variables (mutated/extended from seed)
(declare-fun x1 () String)
(declare-fun x2 () String)
(declare-fun z1 () String)
(declare-fun z2 () String)
(declare-fun t1 () String)
(declare-fun t2 () String)
(declare-fun t3 () String)

; Email validation scenario variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)

; Seed core structure preserved (slightly extended to include email in concatenation)
(assert
  (= (str.++ (str.++ (str.++ x1 "dcb") x2)
             (str.++ (str.++ z2 (str.++ "abf" z1)) (str.++ t1 t2)))
     (str.++ (str.++ (str.++ x2 "bcd") x1)
             (str.++ (str.++ z1 (str.++ "fba" z2)) (str.++ t3 "")))))

; Tie the seed variables into an email-like construction
(assert (= t3 (str.++ local "@")))
(assert (= email (str.++ t3 domain)))

; Split around '@' must yield exactly 2 segments: local and domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (num_splits email "@") 2))

; Basic non-emptiness requirements
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Domain structure: must contain at least one '.' producing >= 2 parts
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len host) 0))
(assert (> (str.len tld) 1))

; Forbid consecutive dots in domain and forbid dot in local ends (simple structural checks)
(assert (not (str.contains domain "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Link some seed fragments to email pieces to preserve interaction/diversity
(assert (str.contains local x1))
(assert (str.contains domain z1))
(assert (= x2 ""))
(assert (str.contains host "dcb"))

; Make this instance UNSAT via contradictory requirements on '@' splitting
(assert (= (num_splits email "@") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]