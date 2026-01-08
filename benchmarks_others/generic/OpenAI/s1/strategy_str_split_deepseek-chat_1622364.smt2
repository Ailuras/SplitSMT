(set-logic ALL)

; Scenario: CSV Processing (comma-separated fields)
; Using str_split interface as uninterpreted functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables (kept core structure but repurposed to CSV-like context)
(declare-const L String)
(declare-const F String)
(declare-const E String)
(declare-const J String)

; Additional variables for CSV processing
(declare-const csv String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest1 String)

; Delimiter is comma
(assert (= delim ","))

; Mutated core structure: keep a similar concatenation equality but make it CSV-shaped
; Left side is a CSV record assembled from fields, right side is another assembly referencing seed vars
(assert (= (str.++ "ieafb" E "af" "," "beb" L "eg" "," J "," "id" "," "fafg")
           (str.++ "iea" F "," J "," "id" "," "fafg")))

; Define csv in terms of seed vars to connect everything
(assert (= csv (str.++ "iea" F "," J "," "id" "," "fafg")))

; CSV split constraints: must have exactly 4 fields
(assert (= (num_splits csv delim) 4))

; Extract fields
(assert (= field0 (split_at csv delim 0)))
(assert (= field1 (split_at csv delim 1)))
(assert (= field2 (split_at csv delim 2)))
(assert (= rest1 (split_rest csv delim 1)))

; Field expectations: first field begins with prefix and is non-empty
(assert (>= (str.len field0) 4))
(assert (str.contains field0 "iea"))

; Detect empty fields: enforce that field1 is empty (models empty field detection)
(assert (= field1 ""))

; Connect field2 to a known token
(assert (= field2 "id"))

; Ensure rest from index 1 starts with a delimiter if field1 is empty and there are remaining fields
(assert (str.contains rest1 ",id,"))

; Additional sanity: J must be empty to create the empty field at position 1
(assert (= J ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
