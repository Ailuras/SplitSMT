(set-logic ALL)

; Uninterpreted string split interface for CSV processing
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; CSV input and extracted fields
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)
(declare-const tail2 String)

; Keep a mutated fragment of the seed's "core structure" idea: contradictory regex + empty string
(declare-const x String)
(assert (str.in_re x (re.++ (str.to_re "bb") (re.+ (str.to_re "1'' ''")))))
(assert (str.in_re x (re.++ (re.+ (re.* (str.to_re "7"))) (re.++ (str.to_re "'' ''L'' ''") (str.to_re "a")))))
(assert (= 0 (str.len x)))

; CSV structure constraints
(assert (= f0 (split_at csv "," 0)))
(assert (= f1 (split_at csv "," 1)))
(assert (= f2 (split_at csv "," 2)))
(assert (= tail1 (split_rest csv "," 1)))
(assert (= tail2 (split_rest csv "," 2)))

; Expect exactly 3 fields (i.e., 2 commas) and enforce valid indices
(assert (= (num_splits csv ",") 3))
(assert (and (<= 0 0) (< 0 (num_splits csv ","))))
(assert (and (<= 0 1) (< 1 (num_splits csv ","))))
(assert (and (<= 0 2) (< 2 (num_splits csv ","))))

; Empty-field detection: require middle field empty, others non-empty
(assert (= f1 ""))
(assert (> (str.len f0) 0))
(assert (> (str.len f2) 0))

; Basic sanitation: no field contains a comma
(assert (not (str.contains f0 ",")))
(assert (not (str.contains f1 ",")))
(assert (not (str.contains f2 ",")))

; Tail consistency (semantic constraints without defining split behavior)
(assert (>= (str.len tail1) (str.len f1)))
(assert (>= (str.len tail2) (str.len f2)))

; Additional contradictory constraint to make this instance UNSAT
(assert (not (= f1 "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]