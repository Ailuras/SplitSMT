(set-logic ALL)

; Uninterpreted interface for string splitting (CSV-like)

; ---------- Shared declarations ----------
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)
(declare-const rest3 String)
(declare-const n Int)

; Delimiter is a comma
(assert (= delim ","))

; Bind fields via split_at
(assert (= f0 (str.split_at csv_line delim 0)))
(assert (= f1 (str.split_at csv_line delim 1)))
(assert (= f2 (str.split_at csv_line delim 2)))
(assert (= f3 (str.split_at csv_line delim 3)))

; Bind rests via split_rest
(assert (= rest2 (str.split_rest csv_line delim 2)))
(assert (= rest3 (str.split_rest csv_line delim 3)))

; Number of fields
(assert (= n (str.num_splits csv_line delim)))

; Index constraints (natural)
(assert (>= n 1))

; ---------- SAT instance: well-formed 4-field CSV, no empty fields ----------
(push 1)
  ; At least 4 fields
  (assert (>= n 4))

  ; No empty fields among first 4
  (assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

  ; Header-like constraint: first field equals "id"
  (assert (= f0 "id"))

  ; Second field looks like an integer (digits+) using regex
  (declare-const digit_re RegLan)
  (assert (= digit_re (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9"))))))))))))
  (assert (str.in_re f1 (re.++ digit_re (re.* digit_re))))

  ; Third field contains a dash (e.g., date fragment or code)
  (assert (str.contains f2 "-"))

  ; Ensure rest2 is non-empty if there are >=3 fields
  (assert (=> (>= n 3) (not (= rest2 ""))))

  (check-sat)
(pop 1)

; ---------- UNSAT instance: detect empty field vs constraint requiring no empties ----------
(push 1)
  ; Exactly 3 fields
  (assert (= n 3))

  ; Require no empty fields
  (assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 ""))))

  ; But also require the second field is empty (conflict)
  (assert (= f1 ""))

  (check-sat)
(pop 1)

; ---------- SAT instance: detect presence of an empty middle field ----------
(push 1)
  ; At least 3 fields
  (assert (>= n 3))

  ; Middle field empty
  (assert (= f1 ""))

  ; First and third fields non-empty
  (assert (and (not (= f0 "")) (not (= f2 ""))))

  ; If a field is empty, the original line must contain two consecutive commas somewhere
  (assert (=> (= f1 "") (str.contains csv_line ",,")))

  ; Ensure rest3 corresponds to fields from index 3 onward; if only 3 fields, rest3 may be empty
  (assert (=> (= n 3) (= rest3 "")))

  (check-sat)
(pop 1)

; ---------- UNSAT instance: inconsistent field count constraints ----------
(push 1)
  (assert (= n 2))
  (assert (>= n 4))
  (check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
