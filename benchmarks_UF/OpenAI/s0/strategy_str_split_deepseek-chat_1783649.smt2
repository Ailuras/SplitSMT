(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted functions for str_split interface

; =========
; Scenario: Email Validation
; =========

; --- Primary variables (intended SAT)
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_rest String)
(declare-const tld String)
(declare-const atCount Int)
(declare-const dotCount Int)
(declare-const domainDotCount Int)

; Basic split constraints around '@'
(assert (= atCount (num_splits email "@")))
(assert (>= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 2) ""))

; Non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Email should not start or end with '@'
(assert (not (str.prefixof "@" email)))
(assert (not (str.suffixof "@" email)))

; Some structural constraints on local part (no spaces, no '@')
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Require a dot somewhere in the domain and at least two labels
(assert (= domainDotCount (num_splits domain ".")))
(assert (>= domainDotCount 2))
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- domainDotCount 1))))
(assert (> (str.len domain_first_label) 0))
(assert (> (str.len tld) 1))

; Domain must not start/end with '.' and must not contain '@'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "@")))

; Additional domain structure: allow multiple labels; capture rest beyond first label
(assert (= domain_rest (split_rest domain "." 1)))
(assert (> (str.len domain_rest) 0))

; Constrain TLD to be alphabetic-ish via regex (at least 2 letters)
(assert (str.in_re tld (re.++ (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                                       (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))
                     (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                               (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))))

; Global dot count on entire email (at least one dot somewhere overall)
(assert (= dotCount (num_splits email ".")))
(assert (>= dotCount 2))

; Ensure the domain contains at least one '.' explicitly
(assert (str.contains domain "."))

; --- Provide a concrete witness for SAT instance
(assert (= email "alice.smith@example.co"))

; =========
; Additional instance: UNSAT constraints (separate email variable)
; =========

(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const atCount_bad Int)
(declare-const domainDotCount_bad Int)
(declare-const tld_bad String)

(assert (= email_bad "bob@@example"))

; Try to enforce "exactly one @" and domain has a dot + valid TLD, which should conflict with the concrete bad email
(assert (= atCount_bad (num_splits email_bad "@")))
(assert (= atCount_bad 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (split_rest email_bad "@" 2) ""))

(assert (= domainDotCount_bad (num_splits domain_bad ".")))
(assert (>= domainDotCount_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- domainDotCount_bad 1))))
(assert (> (str.len tld_bad) 1))
(assert (str.contains domain_bad "."))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
