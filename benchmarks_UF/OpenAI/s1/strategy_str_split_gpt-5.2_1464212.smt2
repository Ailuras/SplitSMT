(set-logic ALL)

; Email Validation scenario using str_split with '@' and '.' delimiters

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sld String)

; Auxiliary variables to preserve/extend seed structure
(declare-const x String)
(declare-const y String)

; Preserve seed core structure but relate it to local part
(assert (= x local))
(assert (str.in_re (str.++ y x) (re.* (str.to_re "ccbbaa"))))

; Basic email must contain exactly one '@' -> two segments
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part constraints: non-empty, no '@', no spaces
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))

; Domain constraints: contains at least one '.', and is split into at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= sld (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Domain labels non-empty and basic character restrictions
(assert (> (str.len sld) 0))
(assert (> (str.len tld) 1))
(assert (not (str.contains sld "@")))
(assert (not (str.contains tld "@")))
(assert (not (str.contains domain " ")))

; TLD must be alphabetic only (2-6 chars)
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.++ (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z"))) (re.* (str.to_re "")))))

; Unsat branch: require domain to have at least 3 labels but also exactly 2 labels
(declare-const require_strict_subdomain Bool)
(assert require_strict_subdomain)
(assert (>= (num_splits domain ".") 3))
(assert (= (num_splits domain ".") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]