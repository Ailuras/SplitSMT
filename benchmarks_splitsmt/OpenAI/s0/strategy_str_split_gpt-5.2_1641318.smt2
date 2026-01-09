(set-logic ALL)

; Uninterpreted string-split interface for CSV-like processing

; === Shared delimiter ===
(declare-const comma String)
(assert (= comma ","))

; ----------------------------------------------------------------------
; SAT instance: well-formed CSV record with exactly 4 fields, no empties
; ----------------------------------------------------------------------
(declare-const csv_ok String)
(declare-const ok_f0 String)
(declare-const ok_f1 String)
(declare-const ok_f2 String)
(declare-const ok_f3 String)

(assert (= (str.num_splits csv_ok comma) 4))
(assert (= ok_f0 (str.split_at csv_ok comma 0)))
(assert (= ok_f1 (str.split_at csv_ok comma 1)))
(assert (= ok_f2 (str.split_at csv_ok comma 2)))
(assert (= ok_f3 (str.split_at csv_ok comma 3)))

; No empty fields
(assert (> (str.len ok_f0) 0))
(assert (> (str.len ok_f1) 0))
(assert (> (str.len ok_f2) 0))
(assert (> (str.len ok_f3) 0))

; Basic content constraints (avoid commas inside fields; allow simple patterns)
(assert (not (str.contains ok_f0 comma)))
(assert (not (str.contains ok_f1 comma)))
(assert (not (str.contains ok_f2 comma)))
(assert (not (str.contains ok_f3 comma)))

; Enforce a plausible shape: first field starts with a letter, last field is numeric-like
(assert (>= (str.len ok_f0) 1))
(assert (str.in_re (str.at ok_f0 0) (re.union (re.range "A" "Z") (re.range "a" "z"))))
(assert (str.in_re ok_f3 (re.++ (re.+ (re.range "0" "9")) (re.* (str.to_re "")))))

; Rest-of-record reconstruction usage
(declare-const ok_rest1 String)
(declare-const ok_rest2 String)
(assert (= ok_rest1 (str.split_rest csv_ok comma 1)))
(assert (= ok_rest2 (str.split_rest csv_ok comma 2)))
(assert (> (str.len ok_rest1) (str.len ok_rest2)))

; Witness example to keep SAT concrete
(assert (= csv_ok "alice,blue,NY,12345"))

; ----------------------------------------------------------------------
; UNSAT instance: claims 3 fields but also demands an empty field while forbidding empties
; ----------------------------------------------------------------------
(declare-const csv_bad String)
(declare-const bad_f0 String)
(declare-const bad_f1 String)
(declare-const bad_f2 String)

(assert (= (str.num_splits csv_bad comma) 3))
(assert (= bad_f0 (str.split_at csv_bad comma 0)))
(assert (= bad_f1 (str.split_at csv_bad comma 1)))
(assert (= bad_f2 (str.split_at csv_bad comma 2)))

; Require detection of an empty middle field
(assert (= bad_f1 ""))

; But simultaneously assert policy that no field may be empty (contradiction)
(assert (> (str.len bad_f0) 0))
(assert (> (str.len bad_f1) 0))
(assert (> (str.len bad_f2) 0))

; Also constrain that the record contains two commas (consistent with 3 fields, but irrelevant due to contradiction)
(assert (str.contains csv_bad comma))
(assert (str.contains (str.split_rest csv_bad comma 1) comma))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
