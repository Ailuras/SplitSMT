(set-logic ALL)

; Uninterpreted split interface for CSV processing
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed-derived literal retained but repurposed as an auxiliary string
(declare-fun literal_5 () String)
(assert (= literal_5 "\u{3c}\u{6f}\u{70}\u{74}\u{69}\u{6f}\u{6e}\u{20}\u{76}\u{61}\u{6c}\u{75}\u{65}\u{3d}\u{22}\u{23}\u{23}\u{75}\u{73}\u{65}\u{72}\u{23}\u{23}\u{22}\u{3e}\u{23}\u{23}\u{75}\u{73}\u{65}\u{72}\u{23}\u{23}\u{3c}\u{2f}\u{6f}\u{70}\u{74}\u{69}\u{6f}\u{6e}\u{3e}"))

; Core CSV scenario variables
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest1 String)
(declare-const rest2 String)
(declare-const nfields Int)

(assert (= delim ","))

; Ensure a non-empty CSV line and constrain its length
(assert (>= (str.len csv_line) 1))

; Split semantics via interface functions
(assert (= nfields (num_splits csv_line delim)))
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= rest1 (split_rest csv_line delim 1)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Expected at least 3 fields (i.e., at least two commas)
(assert (>= nfields 3))

; Detect empty fields: require that one of the first three fields is empty
(assert (or (= field0 "") (= field1 "") (= field2 "")))

; Also require at least one of the first three fields to be non-empty (avoid all-empty degenerate case)
(assert (or (> (str.len field0) 0) (> (str.len field1) 0) (> (str.len field2) 0)))

; Basic CSV hygiene constraints
(assert (not (str.contains field0 ",")))
(assert (not (str.contains field1 ",")))
(assert (not (str.contains field2 ",")))

; Require that the remainder after the first field still contains at least one delimiter
(assert (str.contains rest1 delim))

; Mutated seed regex: ensure the auxiliary literal does not contain the substring "\\<SCRIPT"
(assert (not (str.in_re literal_5 (re.++ (re.* re.allchar) (re.++ (str.to_re "\\<SCRIPT") (re.* re.allchar))))))

; Relate CSV to the literal in a lightweight way: csv_line must not contain '<' or '>'
(assert (not (str.contains csv_line "<")))
(assert (not (str.contains csv_line ">")))

; Introduce a conflicting constraint to create an UNSAT instance: if nfields >= 3, rest2 must be empty,
; but also require a third field to exist and be non-empty length condition on csv_line implies more content.
(assert (=> (>= nfields 3) (= rest2 "")))
(assert (>= (str.len field2) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]