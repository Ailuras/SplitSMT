(set-logic ALL)

; Uninterpreted split interface (str_split)

; Seed-shaped declarations retained (mutated semantics)
(declare-fun sigmaStar_0 () String)
(declare-fun literal_1 () String)
(declare-fun x_2 () String)
(declare-fun literal_3 () String)
(declare-fun x_4 () String)

; CSV-specific variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const tail12 String)
(declare-const emptyField String)

; Mutate seed literals to CSV framing
(assert (= literal_1 "id,name,age"))
(assert (= literal_3 "\n"))
(assert (= x_2 (str.++ literal_1 sigmaStar_0)))
(assert (= x_4 (str.++ x_2 literal_3)))

; csv_line is the content without the trailing newline
(assert (= csv_line x_2))
(assert (= delim ","))

; Enforce 3 fields (i.e., 2 commas => num_splits = 3)
(assert (= (str.num_splits csv_line delim) 3))
(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= tail12 (str.split_rest csv_line delim 1)))

; Detect empty fields: allow empties in general, but demand a witness emptyField
(assert (= emptyField ""))
(assert (or (= field0 emptyField) (= field1 emptyField) (= field2 emptyField)))

; Simple sanity: delimiter should not appear inside any extracted field
(assert (not (str.contains field0 delim)))
(assert (not (str.contains field1 delim)))
(assert (not (str.contains field2 delim)))

; Core structure preserved: regex membership constraint remains (adapted to CSV injection-like token)
(assert (str.in_re x_4 (re.++ (re.* re.allchar)
                              (re.++ (str.to_re "<SCRIPT") (re.* re.allchar)))))

; Additional CSV checks: newline must be exactly the last character of x_4
(assert (> (str.len x_4) 0))
(assert (= (str.at x_4 (- (str.len x_4) 1)) "\n"))

; UNSAT side condition: contradict the required empty-field witness
(assert (and (not (= field0 "")) (not (= field1 "")) (not (= field2 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
