(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, and detect empty fields.

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const csv String)
(declare-const header String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const tail2 String)
(declare-const tail3 String)
(declare-const hasEmptyField Bool)
(declare-const allNonEmpty Bool)

; Preserve core structure: keep the seed's exact-string regex membership, but repurpose X as the CSV content.
(assert (str.in_re csv (str.to_re "hirmvtg/ggqh.kqh\u{1b}Surveillance\u{13}Host:\u{a}")))

; Interpret the CSV as 4 comma-separated fields.
(assert (= (num_splits csv ",") 4))
(assert (= field0 (split_at csv "," 0)))
(assert (= field1 (split_at csv "," 1)))
(assert (= field2 (split_at csv "," 2)))
(assert (= field3 (split_at csv "," 3)))

; Rest segments consistency (from index k onwards)
(assert (= tail2 (split_rest csv "," 2)))
(assert (= tail3 (split_rest csv "," 3)))
(assert (= tail3 field3))

; Header field should contain a recognizable token.
(assert (= header field0))
(assert (str.contains header "Host:"))

; Empty-field detection: at least one field is empty.
(assert (= hasEmptyField (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Also define allNonEmpty for cross-checking.
(assert (= allNonEmpty (and (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 "")))))

; UNSAT branch: require both an empty field and all fields non-empty simultaneously.
(assert hasEmptyField)
(assert allNonEmpty)

; Additional sanity constraints about indices/natural usage (non-negative indices used above).
(assert (>= (num_splits csv ",") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]