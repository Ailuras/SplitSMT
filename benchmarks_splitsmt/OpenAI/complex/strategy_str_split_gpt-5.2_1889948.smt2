(set-logic ALL)

; Email Validation scenario: validate structure using '@' and '.' as delimiters,
; while preserving seed-style negative regex constraints.

(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const dom0 String)
(declare-const dom1 String)
(declare-const dom2 String)
(declare-const recomposed String)

; str_split interface

; Preserve core structure: keep the seed's negative regex constraints (mutated minimally)
(assert (not (str.in_re X (re.++ (str.to_re "<b>") (re.+ (re.union (str.to_re "<") (str.to_re ">"))) (str.to_re "</b>\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "community") (re.+ (re.range "0" "9")) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "\u{5c}s\u{5c}") ((_ re.loop 2 2) (str.to_re "d")) (str.to_re "-\u{5c}") ((_ re.loop 3 3) (str.to_re "w")) (str.to_re "-\u{5c}") ((_ re.loop 4 4) (str.to_re "d")) (str.to_re "\u{a}")))))

; Core email split constraints
(assert (>= (str.len X) 3))
(assert (>= (str.num_splits X "@") 2))
(assert (= (str.num_splits X "@") 2))
(assert (= local (str.split_at X "@" 0)))
(assert (= domain (str.split_at X "@" 1)))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; No spaces or control chars in the email
(assert (not (str.contains X " ")))
(assert (not (str.contains X "\u{9}")))
(assert (not (str.contains X "\u{a}")))
(assert (not (str.contains X "\u{d}")))

; Local part constraints: must not start or end with '.' and must not contain ".."
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; Domain must have at least one dot; constrain segment structure via '.' split
(assert (>= (str.num_splits domain ".") 2))
(assert (= dom0 (str.split_at domain "." 0)))
(assert (= dom1 (str.split_at domain "." 1)))
(assert (= dom2 (str.split_at domain "." 2)))

; First two domain labels non-empty and must not contain '@'
(assert (>= (str.len dom0) 1))
(assert (>= (str.len dom1) 1))
(assert (not (str.contains dom0 "@")))
(assert (not (str.contains dom1 "@")))

; Basic label sanity: no empty label due to consecutive dots at the beginning
(assert (not (= (str.at domain 0) ".")))
(assert (not (str.contains domain "..")))

; Top-level domain rules (two alternatives):
; - If exactly 2 labels: dom1 is TLD length 2..6
; - If 3+ labels: dom2 is TLD length 2..6 and split_rest from 2 equals dom2 (forces exactly 3 labels)
(assert (or (and (= (str.num_splits domain ".") 2)
                 (>= (str.len dom1) 2)
                 (<= (str.len dom1) 6))
            (and (= (str.num_splits domain ".") 3)
                 (= (str.split_rest domain "." 2) dom2)
                 (>= (str.len dom2) 2)
                 (<= (str.len dom2) 6))))

; Recompose and force equality to ensure split functions are consistent for this instance
(assert (= recomposed (str.++ local "@" domain)))
(assert (= X recomposed))

; Make it concrete enough to be satisfiable: enforce a common domain prefix
(assert (or (str.contains domain "example") (str.contains domain "mail")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
