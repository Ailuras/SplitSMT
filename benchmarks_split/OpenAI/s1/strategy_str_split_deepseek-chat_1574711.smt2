(set-logic ALL)
; Scenario: CSV Processing
; Goal: reason about comma-separated fields, field counts, and empty fields.

; --- Uninterpreted interface operations (str_split) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed artifact retained/mutated ---
(declare-fun literal_5 () String)
(assert (= literal_5 "\u{3c}\u{74}\u{64}\u{3e}\u{61}\u{63}\u{74}\u{69}\u{76}\u{69}\u{74}\u{79}\u{72}\u{65}\u{70}\u{6f}\u{72}\u{74}\u{3a}\u{20}\u{3c}\u{2f}\u{74}\u{64}\u{3e}"))
; Ensure it does NOT contain a literal "\<SCRIPT" substring pattern (changed from the seed)
(assert (not (str.in_re literal_5 (re.++ (re.* re.allchar) (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar))))))

; --- CSV inputs and derived fields ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)

(assert (= delim ","))

; Basic CSV split structure
(assert (= f0 (split_at csv_line delim 0)))
(assert (= f1 (split_at csv_line delim 1)))
(assert (= f2 (split_at csv_line delim 2)))
(assert (= rest2 (split_rest csv_line delim 2)))

; Require at least 3 fields total
(assert (>= (num_splits csv_line delim) 3))

; Disallow newline chars in the full CSV line (simple hygiene)
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Detect empty fields: require the second field to be empty
(assert (= f1 ""))

; Non-empty constraints for other fields
(assert (> (str.len f0) 0))
(assert (> (str.len f2) 0))

; Ensure the 3rd field is exactly "age" to model a header-like row
(assert (= f2 "age"))

; Enforce that the rest-from-2 begins with f2 and then either ends or has more commas
(assert (str.contains rest2 "age"))

; --- SAT sub-structure: allow a simple concrete witness pattern ---
; Example model: "name,,age" has an empty middle field and 3 segments.
(assert (str.in_re csv_line (str.to_re "name,,age")))

; --- UNSAT add-on to create mixed instances within one file ---
; Contradiction: if csv_line is exactly "name,,age", then the number of segments is 3.
; Force it to be 4 as well -> UNSAT.
(assert (= (num_splits csv_line delim) 4))

(check-sat)


; [GENERATION STATUS: SUCCESS]