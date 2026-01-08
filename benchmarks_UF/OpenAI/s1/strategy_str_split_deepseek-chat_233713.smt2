(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted interface ops for string split constraints

; CSV Processing scenario: comma-separated fields with constraints about counts and empty fields
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const rest2 String)
(declare-const nfields Int)

; Preserve seed core structure but adapt to CSV: keep a literal and a regex membership assertion
(declare-fun literal_5 () String)
(assert (= literal_5 "name,,age,city"))

; Regex: ensure the line contains ",," to detect an empty field
(assert (str.in_re literal_5 (re.++ (re.* re.allchar) (re.++ (str.to_re ",,") (re.* re.allchar)))))

; Connect the literal to the CSV line under analysis
(assert (= csv_line literal_5))
(assert (= delim ","))

; Split constraints
(assert (= nfields (num_splits csv_line delim)))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Field count expectations for a 4-column CSV
(assert (= nfields 4))

; Empty-field detection: second field is empty due to ",,"
(assert (= field1 ""))

; Additional sanity checks: first field not empty, and third field not empty
(assert (not (= field0 "")))
(assert (not (= field2 "")))

; Concrete expectations consistent with the chosen literal
(assert (= field0 "name"))
(assert (= field2 "age"))
(assert (= field3 "city"))

; Relationship to rest: from index 2 onward should be "age,city"
(assert (= rest2 "age,city"))

; UNSAT branch: require the CSV to have no empty fields (contradicts field1 = "")
(assert (forall ((k Int))
  (=> (and (<= 0 k) (< k nfields))
      (not (= (split_at csv_line delim k) "")))) )

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
