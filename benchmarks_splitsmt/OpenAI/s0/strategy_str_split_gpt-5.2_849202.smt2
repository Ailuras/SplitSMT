(set-logic ALL)

; Uninterpreted interface for string splitting by delimiter

; Scenario: CSV Processing
; We model two CSV lines: one intended to be well-formed (SAT) and one intended to violate constraints (UNSAT).

; ---------- SAT instance: well-formed CSV with an allowed empty field ----------
(declare-const csv_line_sat String)
(declare-const sat_field0 String)
(declare-const sat_field1 String)
(declare-const sat_field2 String)
(declare-const sat_field3 String)
(declare-const sat_rest2 String)
(declare-const sat_num_fields Int)

; Delimiter is a single comma
(define-fun comma () String ",")

; Exactly 4 fields
(assert (= sat_num_fields (str.num_splits csv_line_sat comma)))
(assert (= sat_num_fields 4))

; Extract fields
(assert (= sat_field0 (str.split_at csv_line_sat comma 0)))
(assert (= sat_field1 (str.split_at csv_line_sat comma 1)))
(assert (= sat_field2 (str.split_at csv_line_sat comma 2)))
(assert (= sat_field3 (str.split_at csv_line_sat comma 3)))

; Rest from index 2 should be field2,field3 in CSV sense
(assert (= sat_rest2 (str.split_rest csv_line_sat comma 2)))
(assert (= sat_rest2 (str.++ sat_field2 comma sat_field3)))

; Constrain content: no commas inside fields (basic CSV without quoting)
(assert (not (str.contains sat_field0 comma)))
(assert (not (str.contains sat_field1 comma)))
(assert (not (str.contains sat_field2 comma)))
(assert (not (str.contains sat_field3 comma)))

; Require fields 0 and 1 to be non-empty, allow field2 to be empty, field3 non-empty
(assert (> (str.len sat_field0) 0))
(assert (> (str.len sat_field1) 0))
(assert (= (str.len sat_field2) 0))
(assert (> (str.len sat_field3) 0))

; Force an example-like shape: first field is an integer string, second is alphabetic-ish, fourth looks like a code
(declare-const digit String)
(declare-const letters String)
(declare-const code String)

; Constrain sat_field0 to be digits only, non-empty
(assert (str.in_re sat_field0 (re.+ (re.range "0" "9"))))

; Constrain sat_field1 to be lower-case letters only, non-empty
(assert (str.in_re sat_field1 (re.+ (re.range "a" "z"))))

; Constrain sat_field3 to be pattern: [A-Z][A-Z][0-9][0-9]
(assert (str.in_re sat_field3 (re.++ (re.range "A" "Z") (re.range "A" "Z") (re.range "0" "9") (re.range "0" "9"))))

; Ensure the overall line has exactly 3 commas when 4 fields
(assert (= csv_line_sat (str.++ sat_field0 comma sat_field1 comma sat_field2 comma sat_field3)))


; ---------- UNSAT instance: detect forbidden empty fields + contradictory counts ----------
(declare-const csv_line_unsat String)
(declare-const uns_field0 String)
(declare-const uns_field1 String)
(declare-const uns_field2 String)
(declare-const uns_num_fields Int)

; Stated as having 3 fields
(assert (= uns_num_fields (str.num_splits csv_line_unsat comma)))
(assert (= uns_num_fields 3))

; Extract fields
(assert (= uns_field0 (str.split_at csv_line_unsat comma 0)))
(assert (= uns_field1 (str.split_at csv_line_unsat comma 1)))
(assert (= uns_field2 (str.split_at csv_line_unsat comma 2)))

; Basic CSV reconstruction
(assert (= csv_line_unsat (str.++ uns_field0 comma uns_field1 comma uns_field2)))

; Policy: In this dataset, empty fields are NOT allowed
(assert (> (str.len uns_field0) 0))
(assert (> (str.len uns_field1) 0))
(assert (> (str.len uns_field2) 0))

; But also assert there exists an empty middle field by forcing consecutive commas in the line
; This implies uns_field1 = "" under the reconstruction above, contradicting (> (str.len uns_field1) 0)
(assert (str.contains csv_line_unsat ",,"))

; Additional contradiction: if ",," occurs in a 3-field line with no commas inside fields,
; then some field must be empty, but we also forbid commas inside fields.
(assert (not (str.contains uns_field0 comma)))
(assert (not (str.contains uns_field1 comma)))
(assert (not (str.contains uns_field2 comma)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
