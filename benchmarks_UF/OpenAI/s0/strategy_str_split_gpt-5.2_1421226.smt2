(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; Scenario: CSV Processing
; -------------------------

; Instance A (intended SAT): 4 comma-separated fields, with an empty field in the middle
(declare-const csvA String)
(declare-const a0 String)
(declare-const a1 String)
(declare-const a2 String)
(declare-const a3 String)
(declare-const aTail2 String)

(assert (= csvA "alpha,,gamma,delta"))
(assert (= a0 (split_at csvA "," 0)))
(assert (= a1 (split_at csvA "," 1)))
(assert (= a2 (split_at csvA "," 2)))
(assert (= a3 (split_at csvA "," 3)))
(assert (= aTail2 (split_rest csvA "," 2)))

(assert (= (num_splits csvA ",") 4))
(assert (= a0 "alpha"))
(assert (= a1 ""))
(assert (= a2 "gamma"))
(assert (= a3 "delta"))
(assert (= aTail2 "gamma,delta"))

; Indices are natural
(assert (and (<= 0 0) (<= 0 1) (<= 0 2) (<= 0 3)))

; Detect empty field: at least one field is empty
(assert (or (= a0 "") (= a1 "") (= a2 "") (= a3 "")))

; -------------------------
; Instance B (intended UNSAT): contradictory requirements about empty fields
(declare-const csvB String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= csvB "x,,z"))
(assert (= (num_splits csvB ",") 3))
(assert (= b0 (split_at csvB "," 0)))
(assert (= b1 (split_at csvB "," 1)))
(assert (= b2 (split_at csvB "," 2)))

; Force the middle field empty via explicit equality
(assert (= b1 ""))

; Contradictory: also require that no fields are empty
(assert (and (not (= b0 "")) (not (= b1 "")) (not (= b2 ""))))

; -------------------------
; Instance C (intended SAT): constrain counts and simple validation for non-empty edge fields
(declare-const csvC String)
(declare-const c0 String)
(declare-const c1 String)
(declare-const c2 String)
(declare-const cRest1 String)

; Choose a concrete CSV line with an empty last field to test trailing empties
(assert (= csvC "p,q,"))
(assert (= (num_splits csvC ",") 3))
(assert (= c0 (split_at csvC "," 0)))
(assert (= c1 (split_at csvC "," 1)))
(assert (= c2 (split_at csvC "," 2)))
(assert (= cRest1 (split_rest csvC "," 1)))

; Basic constraints: first two fields non-empty, last field empty
(assert (and (not (= c0 "")) (not (= c1 "")) (= c2 "")))

; Tail from index 1 should preserve comma and empty last field
(assert (= cRest1 "q,"))

(check-sat)


; [GENERATION STATUS: SUCCESS]