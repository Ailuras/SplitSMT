(set-logic ALL)

; Uninterpreted functions for string split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------------------------
; Scenario A (intended SAT): CSV line with 5 fields, including an empty field
; Example shape: "Alice,42,,NY,10001"
; -------------------------
(declare-const csvA String)
(declare-const a_f0 String)
(declare-const a_f1 String)
(declare-const a_f2 String)
(declare-const a_f3 String)
(declare-const a_f4 String)

(assert (= a_f0 (split_at csvA "," 0)))
(assert (= a_f1 (split_at csvA "," 1)))
(assert (= a_f2 (split_at csvA "," 2)))
(assert (= a_f3 (split_at csvA "," 3)))
(assert (= a_f4 (split_at csvA "," 4)))

; Field count constraints
(assert (= (num_splits csvA ",") 5))

; Non-empty requirements for selected fields
(assert (not (= a_f0 "")))
(assert (not (= a_f1 "")))
(assert (not (= a_f3 "")))
(assert (not (= a_f4 "")))

; Detect an empty field at index 2
(assert (= a_f2 ""))

; Simple format checks (integers as strings)
(assert (str.in_re a_f1 (re.+ (re.range "0" "9"))))
(assert (str.in_re a_f4 (re.+ (re.range "0" "9"))))

; Ensure no commas inside extracted fields (basic CSV without quoting)
(assert (not (str.contains a_f0 ",")))
(assert (not (str.contains a_f1 ",")))
(assert (not (str.contains a_f2 ",")))
(assert (not (str.contains a_f3 ",")))
(assert (not (str.contains a_f4 ",")))

; Rest-of-line sanity: from field 3 onward should be field3 + "," + field4
(assert (= (split_rest csvA "," 3) (str.++ a_f3 "," a_f4)))

; Concrete witness to make SAT easy while still exercising constraints
(assert (= csvA "Alice,42,,NY,10001"))

(check-sat)

; -------------------------
; Scenario B (intended UNSAT): contradictory empty-field detection
; Requires a field to be simultaneously empty and non-empty.
; -------------------------
(push 1)
(declare-const csvB String)
(declare-const b_f0 String)
(declare-const b_f1 String)
(declare-const b_f2 String)

(assert (= b_f0 (split_at csvB "," 0)))
(assert (= b_f1 (split_at csvB "," 1)))
(assert (= b_f2 (split_at csvB "," 2)))

(assert (= (num_splits csvB ",") 3))

; Contradiction: field 1 both empty and non-empty
(assert (= b_f1 ""))
(assert (not (= b_f1 "")))

; Additional realistic constraints
(assert (not (str.contains b_f0 ",")))
(assert (not (str.contains b_f1 ",")))
(assert (not (str.contains b_f2 ",")))

(check-sat)
(pop 1)

; -------------------------
; Scenario C (intended UNSAT): field-count mismatch against explicit structure
; Imposes 4 fields but also forces a string with 5 comma-separated fields.
; -------------------------
(push 1)
(declare-const csvC String)
(declare-const c_f0 String)
(declare-const c_f1 String)
(declare-const c_f2 String)
(declare-const c_f3 String)

(assert (= c_f0 (split_at csvC "," 0)))
(assert (= c_f1 (split_at csvC "," 1)))
(assert (= c_f2 (split_at csvC "," 2)))
(assert (= c_f3 (split_at csvC "," 3)))

(assert (= (num_splits csvC ",") 4))

; Force a concrete CSV with 5 fields (4 commas)
(assert (= csvC "A,B,C,D,E"))

; Also constrain the rest from index 2 onward to match 2 fields only
(assert (= (split_rest csvC "," 2) (str.++ c_f2 "," c_f3)))

(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)