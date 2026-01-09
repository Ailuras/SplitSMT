(set-logic ALL)

; Scenario: CSV Processing
; Goal: process comma-separated data fields, ensure correct field counts, and detect empty fields.

; Non-primitive interface operations (string split)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables retained
(declare-const A String)
(declare-const B String)
(declare-const C String)

; Additional CSV-related variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const rest2 String)

; Delimiter is comma
(assert (= delim ","))

; Preserve core structure from seed but adapt it: relate A,B,C through concatenation
(assert (= (str.++ A B "aaaa") (str.++ C B)))

; Build a CSV string from fields; include B as a field to preserve linkage
(assert (= csv (str.++ f0 delim f1 delim B delim f3)))

; Enforce expected field count: 4 fields => 4 segments
(assert (= (num_splits csv delim) 4))

; Connect split interface to fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= B  (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))

; Rest from index 2 should be field2,comma,field3
(assert (= rest2 (split_rest csv delim 2)))
(assert (= rest2 (str.++ B delim f3)))

; Detect empty fields: require field1 to be empty
(assert (= f1 ""))

; Additional sanity: f0 must be non-empty and cannot contain the delimiter
(assert (> (str.len f0) 0))
(assert (not (str.contains f0 delim)))

; Tie A and C to some CSV fields to keep structure intertwined
(assert (= A f0))
(assert (= C (str.++ f0 "aaaa")))

; This makes the overall instance UNSAT:
; From seed constraint: A+B+"aaaa" = C+B implies A+"aaaa" = C.
; But we also assert C = f0+"aaaa" and A = f0, which is consistent.
; Now force a contradiction by making C different from that.
(assert (not (= C (str.++ A "aaaa"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]