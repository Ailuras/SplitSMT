(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (re.++ (re.opt (str.to_re "0")) (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re "/") (re.union (re.++ (re.opt (str.to_re "0")) (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (str.to_re "3") (re.range "0" "1"))) (str.to_re "/") (re.opt (re.union (str.to_re "19") (str.to_re "20"))) (re.range "0" "9") (re.range "0" "9") (re.opt (re.++ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (re.union (re.++ (re.union (re.++ (re.opt (str.to_re "0")) (re.range "0" "9")) (re.++ (str.to_re "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3"))) (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (re.opt (re.++ (str.to_re ":") (re.range "0" "5") (re.range "0" "9")))) (re.++ (re.union (re.++ (re.opt (str.to_re "0")) (re.range "0" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (re.opt (re.++ (str.to_re ":") (re.range "0" "5") (re.range "0" "9"))) (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (re.union (str.to_re "AM") (str.to_re "PM")))))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---

(declare-const day String)
(declare-const month String)
(declare-const year_and_time String)
(declare-const year String)

; Enforce a DD/MM/YYYY-like split shape (without constraining the exact regex already present)
(assert (>= (num_splits X "/") 3))
(assert (= month (split_at X "/" 0)))
(assert (= day (split_at X "/" 1)))
(assert (= year_and_time (split_rest X "/" 2)))

; If year_and_time contains a space, take the portion before the first space as the year
(assert (>= (num_splits year_and_time " ") 1))
(assert (= year (split_at year_and_time " " 0)))

; Basic sanity: day/month should be non-empty, year should have at least 2 chars
(assert (> (str.len month) 0))
(assert (> (str.len day) 0))
(assert (>= (str.len year) 2))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
