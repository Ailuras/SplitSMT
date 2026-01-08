(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, and detect empty fields.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Variables ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const empty_field Bool)

; Delimiter is comma
(assert (= delim ","))

; Core structure: retain multiple regex membership constraints on the main string (mutated for CSV)
; csv_line ends with newline
(assert (str.in_re csv_line (re.++ (re.* re.allchar) (str.to_re "\u{a}"))))

; csv_line contains a CSV-looking prefix: "id," then arbitrary then ",host" then arbitrary then "Host:" and newline
(assert (str.in_re csv_line
  (re.++
    (str.to_re "id,")
    (re.* re.allchar)
    (str.to_re ",host")
    (re.* re.allchar)
    (str.to_re "Host:")
    (re.* re.allchar)
    (str.to_re "\u{a}"))))

; Also require that the line begins with digits (id field start)
(assert (str.in_re csv_line (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar) (str.to_re "\u{a}"))))

; --- Split-based CSV constraints ---
; Extract first fields
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Indices and count constraints
(assert (>= (num_splits csv_line delim) 3))
(assert (<= (num_splits csv_line delim) 6))

; Field 0 is a non-empty integer id
(assert (> (str.len f0) 0))
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))

; Field 1 should be a short tag, no commas/newlines, non-empty
(assert (> (str.len f1) 0))
(assert (not (str.contains f1 ",")))
(assert (not (str.contains f1 "\u{a}")))
(assert (<= (str.len f1) 12))

; Field 2 is "host" literal (after split)
(assert (= f2 "host"))

; rest2 should still contain "Host:" somewhere after the 2nd comma
(assert (str.contains rest2 "Host:"))

; Detect empty field: either f1 empty or some later segment empty
(assert (= empty_field (or (= f1 "") (= (split_at csv_line delim 3) ""))))

; Force detection of an empty field to be possible in this instance
(assert empty_field)

; Ensure there is at least a 4th segment if we refer to index 3
(assert (>= (num_splits csv_line delim) 4))

; Additional constraint: after the id, the first comma appears (consistent with CSV)
(assert (str.contains csv_line ","))

(check-sat)


; [GENERATION STATUS: SUCCESS]
