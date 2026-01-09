(set-logic ALL)

; Uninterpreted interface for str_split

; -------------------------------
; Scenario: Email Validation
; We model a few email-like strings and validate them using splits on '@' and '.'
; We include both SAT and UNSAT constraint sets in one file by using a selector.
; -------------------------------

(declare-const choose_sat Bool)

; Common delimiters
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; SAT candidate email
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const subdomain_ok String)
(declare-const tld_ok String)

; UNSAT candidate email
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const subdomain_bad String)
(declare-const tld_bad String)

; Regex helpers
(declare-const re_local (RegLan))
(declare-const re_domain_label (RegLan))
(declare-const re_tld (RegLan))
(declare-const re_email_simplified (RegLan))

; Define simplified character classes (approximation)
; local: letters/digits/._+- (at least 1)
(assert (= re_local
  (re.++
    (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
              (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
              (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
              (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
              (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
              (str.to_re "z")
              (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
              (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
              (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
    (re.*
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z")
                (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-") )))))

; domain label: letters/digits/hyphen (at least 1)
(assert (= re_domain_label
  (re.++
    (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
              (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
              (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
              (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
              (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
              (str.to_re "z")
              (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
              (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
              (str.to_re "-") )
    (re.*
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z")
                (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                (str.to_re "-") )))))

; tld: letters only, length 2..6 (approx by enumerating a few lengths)
(assert (= re_tld
  (re.union
    (re.++
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z"))
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z")))
    (re.++
      (re.++
        (re.++
          (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z"))
          (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z")))
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")))
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z")))
    (re.++
      (re.++
        (re.++
          (re.++
            (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                      (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                      (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                      (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                      (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                      (str.to_re "z"))
            (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                      (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                      (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                      (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                      (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                      (str.to_re "z")))
          (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z")))
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")))
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z")))
    (re.++
      (re.++
        (re.++
          (re.++
            (re.++
              (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                        (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                        (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                        (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                        (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                        (str.to_re "z"))
              (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                        (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                        (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                        (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                        (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                        (str.to_re "z")))
            (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                      (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                      (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                      (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                      (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                      (str.to_re "z")))
          (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z")))
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")))
      (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                (str.to_re "z"))))))

; Simplified overall email regex: local "@" domain_label "." tld
(assert (= re_email_simplified
  (re.++ re_local (re.++ (str.to_re "@") (re.++ re_domain_label (re.++ (str.to_re ".") re_tld))))) )

; -------------------------------
; SAT instance constraints
; -------------------------------
(assert (= local_ok (str.split_at email_ok at_delim 0)))
(assert (= domain_ok (str.split_at email_ok at_delim 1)))
(assert (>= (str.num_splits email_ok at_delim) 2))
(assert (= (str.num_splits email_ok at_delim) 2))
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok " ")))
(assert (str.in_re local_ok re_local))

(assert (= subdomain_ok (str.split_at domain_ok dot_delim 0)))
(assert (= tld_ok (str.split_at domain_ok dot_delim 1)))
(assert (= (str.num_splits domain_ok dot_delim) 2))
(assert (>= (str.len subdomain_ok) 1))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 6))
(assert (str.in_re subdomain_ok re_domain_label))
(assert (str.in_re tld_ok re_tld))
(assert (str.in_re email_ok re_email_simplified))

; Pin a concrete satisfiable example (still consistent with constraints)
(assert (= email_ok "alice.smith+tag@company.com"))

; -------------------------------
; UNSAT instance constraints
; We require domain to have exactly one dot and a non-empty tld,
; but we also force a dot-free domain.
; -------------------------------
(assert (= local_bad (str.split_at email_bad at_delim 0)))
(assert (= domain_bad (str.split_at email_bad at_delim 1)))
(assert (= (str.num_splits email_bad at_delim) 2))
(assert (>= (str.len local_bad) 1))
(assert (not (str.contains local_bad " ")))

(assert (= subdomain_bad (str.split_at domain_bad dot_delim 0)))
(assert (= tld_bad (str.split_at domain_bad dot_delim 1)))
(assert (= (str.num_splits domain_bad dot_delim) 2))
(assert (>= (str.len subdomain_bad) 1))
(assert (>= (str.len tld_bad) 2))

; Contradiction: a domain with exactly 2 segments by '.' must contain a dot
; but we also forbid any dot in the domain.
(assert (not (str.contains domain_bad dot_delim)))

; Fix a plausible "bad" email to make the conflict explicit
(assert (= email_bad "bob@nodotdomain"))

; -------------------------------
; Choose SAT or UNSAT branch
; -------------------------------
(assert (or
  (and choose_sat)
  (and (not choose_sat) false)))

; If choose_sat then ignore the bad instance; if not choose_sat then enforce it.
(assert (=> choose_sat true))
(assert (=> (not choose_sat) (and (= email_bad "bob@nodotdomain") (not (str.contains domain_bad dot_delim)) (= (str.num_splits domain_bad dot_delim) 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
