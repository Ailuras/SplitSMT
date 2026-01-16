(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation via str_split (uninterpreted split operations)


; -----------------------------
; SAT instance: plausible complex email structure
; -----------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const dot_count_sat Int)
(declare-const tld_sat String)
(declare-const subdomain_first_sat String)
(declare-const domain_rest_sat String)
(declare-const first_label_len_sat Int)

(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (< (num_splits email_sat "@") 3))

; local part constraints
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat "..")))
(assert (not (str.prefixof "." local_sat)))
(assert (not (str.suffixof "." local_sat)))

; domain constraints
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat "..")))
(assert (not (str.prefixof "." domain_sat)))
(assert (not (str.suffixof "." domain_sat)))

; ensure domain has at least one dot => at least 2 labels
(assert (>= (num_splits domain_sat ".") 2))
(assert (= dot_count_sat (num_splits domain_sat ".")))

; extract first subdomain label and the rest
(assert (= subdomain_first_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_sat (split_rest domain_sat "." 1)))
(assert (> (str.len subdomain_first_sat) 0))

; last label as TLD (use index dot_count-1)
(assert (>= dot_count_sat 2))
(assert (= tld_sat (split_at domain_sat "." (- dot_count_sat 1))))

; TLD constraints (typical: 2..24, alphabetic-ish via regex)
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (str.in_re tld_sat (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                               (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))))

; overall email shape constraints (weak, but useful)
(assert (not (str.contains email_sat " ")))
(assert (not (str.contains email_sat "@@")))
(assert (not (str.prefixof "@" email_sat)))
(assert (not (str.suffixof "@" email_sat)))
(assert (str.contains email_sat "@"))

; tie a concrete satisfying witness while still exercising split constraints
(assert (= email_sat "john.doe+tag@sub.mail.example.COM"))
(assert (= first_label_len_sat (str.len subdomain_first_sat)))
(assert (> first_label_len_sat 0))

(check-sat)
(exit)
