(set-logic ALL)

; Email Validation via str_split: structure, counts, and domain constraints

; --- Uninterpreted interface operations for string split ---

; --- Common variables ---
(declare-const email String)
(declare-const at_delim String)
(declare-const dot_delim String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_labels Int)
(declare-const tld String)
(declare-const second_level String)
(declare-const first_label String)
(declare-const rest_labels String)

; --- A separate contradictory instance to ensure UNSAT diversity ---
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_labels Int)

; Delimiters
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; ------------------------------
; SAT-oriented constraints: plausible complex email format
; ------------------------------

; Email contains exactly one '@' so splitting yields two segments
(assert (>= (str.len email) 6))
(assert (>= (str.num_splits email at_delim) 2))
(assert (= (str.num_splits email at_delim) 2))
(assert (= local_part (str.split_at email at_delim 0)))
(assert (= domain_part (str.split_at email at_delim 1)))

; Local-part requirements: non-empty, no spaces, no '@'
(assert (>= (str.len local_part) 1))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part at_delim)))

; For diversity: require local_part has a dot-separated structure like "first.last" (at least 2 labels)
(assert (>= (str.num_splits local_part dot_delim) 2))
(assert (>= (str.len (str.split_at local_part dot_delim 0)) 1))
(assert (>= (str.len (str.split_at local_part dot_delim 1)) 1))

; Domain requirements: at least one dot (e.g., example.com), no spaces, not starting/ending with '.'
(assert (not (str.contains domain_part " ")))
(assert (>= (str.len domain_part) 3))
(assert (>= (str.num_splits domain_part dot_delim) 2))

; Extract domain labels
(assert (= domain_labels (str.num_splits domain_part dot_delim)))
(assert (>= domain_labels 2))
(assert (= first_label (str.split_at domain_part dot_delim 0)))
(assert (= second_level (str.split_at domain_part dot_delim (- domain_labels 2))))
(assert (= tld (str.split_at domain_part dot_delim (- domain_labels 1))))
(assert (= rest_labels (str.split_rest domain_part dot_delim 1)))

; Labels must be non-empty: enforce on a few positions and on derived pieces
(assert (>= (str.len first_label) 1))
(assert (>= (str.len second_level) 1))
(assert (>= (str.len tld) 2))

; Domain must not contain '@'
(assert (not (str.contains domain_part at_delim)))

; TLD restricted to alphabetic-only and length 2..6
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                   (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z"))
                         (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                         (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z"))))))

; Ensure second_level and first_label are alphanumeric/hyphen and do not start or end with '-'
(declare-const label_re RegLan)
(assert (= label_re (re.++
  (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
            (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")
            (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))
  (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")
                (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9") (str.to_re "-")))
  (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
            (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")
            (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")))))

(assert (str.in_re first_label label_re))
(assert (str.in_re second_level label_re))

; Ensure domain does not contain consecutive dots by requiring each extracted label is non-empty for first two
(assert (not (= (str.split_at domain_part dot_delim 0) "")))
(assert (not (= (str.split_at domain_part dot_delim 1) "")))

; ------------------------------
; UNSAT-oriented constraints: contradictory email requirements
; ------------------------------

(assert (= bad_email bad_email))
(assert (= bad_local (str.split_at bad_email at_delim 0)))
(assert (= bad_domain (str.split_at bad_email at_delim 1)))

; Contradiction: exactly one '@' but also local contains '@'
(assert (= (str.num_splits bad_email at_delim) 2))
(assert (str.contains bad_local at_delim))
(assert (not (str.contains bad_local at_delim)))

; Additional contradiction on domain dot structure for diversity
(assert (= bad_labels (str.num_splits bad_domain dot_delim)))
(assert (>= bad_labels 2))
(assert (< bad_labels 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
