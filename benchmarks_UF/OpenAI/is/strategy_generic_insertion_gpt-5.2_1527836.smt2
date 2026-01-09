(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.union (re.range "0" "9") (re.++ (re.range "0" "2") (re.range "0" "9")) (re.++ (str.to_re "3") (re.range "0" "1"))) (str.to_re "/") (re.union (re.range "1" "9") (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re "/") (re.union (re.++ (re.range "0" "9") (re.range "0" "9")) (re.++ (re.range "1" "2") (re.union (str.to_re "0") (str.to_re ",") (str.to_re "9")) (re.range "0" "9") (re.range "0" "9"))) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const month String)
(declare-const day String)
(declare-const year String)

(assert (>= (num_splits X "/") 3))
(assert (= month (split_at X "/" 0)))
(assert (= day (split_at X "/" 1)))
(assert (= year (split_at X "/" 2)))

(assert (= (split_rest X "/" 2) year))

(assert (and (<= 1 (str.len month)) (<= (str.len month) 2)))
(assert (and (<= 1 (str.len day)) (<= (str.len day) 2)))
(assert (= (str.len year) 5))
(assert (= (str.at year 4) "\n"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]