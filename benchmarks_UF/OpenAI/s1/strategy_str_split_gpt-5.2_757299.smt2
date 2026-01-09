(set-logic ALL)

; CSV Processing: split into comma-separated fields, check counts, detect empty fields

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const X String)            ; the CSV row
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)

; delimiter is comma
(assert (= delim ","))

; core structure preserved: keep a negated regex membership constraint, adapted to CSV
; forbid newline in the entire CSV row
(assert (not (str.in_re X (re.++ re.allchar (str.to_re "\n") re.allchar))))

; relate split fields
(assert (= f0 (split_at X delim 0)))
(assert (= f1 (split_at X delim 1)))
(assert (= f2 (split_at X delim 2)))
(assert (= f3 (split_at X delim 3)))
(assert (= rest2 (split_rest X delim 2)))

; index constraints (natural)
(assert (>= (num_splits X delim) 1))

; --- SAT-side constraints: exactly 4 fields and at least one empty field among first four ---
(assert (= (num_splits X delim) 4))

; detect empty fields
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; ensure at least one non-empty field too
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; constrain field characters: no commas inside fields (approximation)
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f1 delim)))
(assert (not (str.contains f2 delim)))
(assert (not (str.contains f3 delim)))

; a simple reconstruction constraint using split_rest: the suffix from field2 equals f2 + "," + f3
(assert (= rest2 (str.++ f2 (str.++ delim f3))))

; --- Additional UNSAT core (conflicting constraints) ---
; claim no empty fields, contradicting the empty-field detector above
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]