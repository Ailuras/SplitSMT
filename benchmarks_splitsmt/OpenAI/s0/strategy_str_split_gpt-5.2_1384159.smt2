(set-logic ALL)

; Uninterpreted interface for str_split

; Primary email variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)

; Additional variables for mixed constraints
(declare-const email2 String)
(declare-const local2 String)
(declare-const domain2 String)
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)

; -------------------------
; SAT instance: plausible complex email validation constraints
; -------------------------

; email should have exactly one '@' meaning two segments when split
(assert (= (str.num_splits email "@") 2))
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain_part (str.split_at email "@" 1)))

; local part: non-empty, no spaces, no additional '@'
(assert (>= (str.len local_part) 1))
(assert (not (str.contains local_part " ")))
(assert (= (str.num_splits local_part "@") 1))

; local part: must not start or end with '.' (simple sanity)
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; domain part must contain at least one '.' => at least two labels
(assert (>= (str.num_splits domain_part ".") 2))

; first two labels and TLD via split_at
(assert (= domain_label0 (str.split_at domain_part "." 0)))
(assert (= domain_label1 (str.split_at domain_part "." 1)))
(assert (= tld (str.split_at domain_part "." (- (str.num_splits domain_part ".") 1))))

; domain labels: non-empty
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len domain_label1) 1))
(assert (>= (str.len tld) 2))

; domain labels should not contain '@' or spaces
(assert (= (str.num_splits domain_part "@") 1))
(assert (not (str.contains domain_part " ")))

; reconstructed email equals local@domain
(assert (= reconstructed (str.++ local_part "@" domain_part)))
(assert (= reconstructed email))

; additional: constrain email to match a permissive regex for sanity
; local: letters/digits and ._%+- at least 1
; domain: labels of letters/digits/hyphen with dots, TLD letters length >=2 (approximated)
(assert (str.in_re email
  (re.++
    (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z")
                    (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                    (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                    (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                    (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                    (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                    (str.to_re "Z")
                    (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                    (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                    (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-") ))
    (str.to_re "@")
    (re.++
      (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                      (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                      (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                      (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                      (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                      (str.to_re "z")
                      (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                      (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                      (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                      (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                      (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                      (str.to_re "Z")
                      (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                      (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                      (str.to_re "-") ))
      (re.* (re.++ (str.to_re ".")
                   (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                                   (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                                   (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                                   (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                                   (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                                   (str.to_re "z")
                                   (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                                   (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                                   (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                                   (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                                   (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                                   (str.to_re "Z")
                                   (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                                   (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                                   (str.to_re "-") ))))
      (str.to_re ".")
      (re.++
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")
                  (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                  (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                  (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                  (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                  (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                  (str.to_re "Z"))
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")
                  (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                  (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                  (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                  (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                  (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                  (str.to_re "Z"))
        (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                        (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                        (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                        (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                        (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                        (str.to_re "z")
                        (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                        (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                        (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                        (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                        (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                        (str.to_re "Z"))))))))

; Ensure email has at least one '.' after '@' by relating to split_rest
(assert (= (str.split_rest email "@" 1) domain_part))
(assert (str.contains domain_part "."))

; -------------------------
; Second SAT instance: another email with stricter domain label count
; -------------------------
(assert (= (str.num_splits email2 "@") 2))
(assert (= local2 (str.split_at email2 "@" 0)))
(assert (= domain2 (str.split_at email2 "@" 1)))
(assert (>= (str.len local2) 3))
(assert (>= (str.num_splits domain2 ".") 3))
(assert (>= (str.len (str.split_at domain2 "." 0)) 1))
(assert (>= (str.len (str.split_at domain2 "." 1)) 1))
(assert (>= (str.len (str.split_at domain2 "." 2)) 2))
(assert (not (str.contains email2 " ")))

; -------------------------
; UNSAT instance: contradictory constraints for a "bad" email
; -------------------------
(assert (= (str.num_splits bad_email "@") 2))
(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))

; Force no dots in domain but also require at least two dot-splits -> contradiction
(assert (= (str.num_splits bad_domain ".") 1))
(assert (>= (str.num_splits bad_domain ".") 2))

; Additional contradiction: local part non-empty but equal to empty
(assert (>= (str.len bad_local) 1))
(assert (= bad_local ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
