; Email Validation scenario: split-based structural constraints + mutated regex core
(set-logic ALL)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Primary input email
(declare-const var0 String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)

; Helper booleans to create both SAT and UNSAT branches
(declare-const force_unsat Bool)

; Core structure: exactly one '@'
(assert (>= (num_splits var0 "@") 2))
(assert (= 2 (num_splits var0 "@")))
(assert (= local (split_at var0 "@" 0)))
(assert (= domain (split_at var0 "@" 1)))
(assert (= domain (split_rest var0 "@" 1)))

; Local-part constraints: non-empty, no '.' at ends, contains no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= dom_label0 (split_at domain "." 0)))
(assert (= dom_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len dom_label0) 0))
(assert (> (str.len tld) 1))

; Domain must not contain '@' and cannot start/end with '.'
(assert (not (str.contains domain "@")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Mutated/extended seed-like regex core, adapted for email-ish alphabet.
; We define a restricted alphabet and require local and domain pieces to be in it.
(assert (str.in_re local
  (re.++
    (re.union (re.+ (str.to_re "a")) (re.+ (str.to_re "b")))
    (re.* (re.union (str.to_re "0") (str.to_re "1"))))))

(assert (str.in_re domain
  (re.++
    (re.+ (re.union (str.to_re "a") (str.to_re "b")))
    (re.++ (str.to_re ".")
           (re.++ (re.+ (re.union (str.to_re "a") (str.to_re "b")))
                  (re.* (re.union (str.to_re ".") (re.union (str.to_re "a") (str.to_re "b")))))))))

; Ensure the email is exactly local@domain
(assert (= var0 (str.++ local (str.++ "@" domain))))

; Add a mixed SAT/UNSAT feature: if force_unsat then contradict domain splitting
; This preserves overall structure but allows generating UNSAT by setting force_unsat = true.
(assert (=> force_unsat (and (= 1 (num_splits var0 "@")) (= 0 (str.len local)))))

; Also constrain TLD to be alphabetic-like per our reduced alphabet
(assert (str.in_re tld (re.++ (re.+ (str.to_re "a")) (re.* (str.to_re "b")))))

; Make one concrete satisfiable example possible when force_unsat is false
(assert (or force_unsat (= var0 "ab1@ab.ab")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
