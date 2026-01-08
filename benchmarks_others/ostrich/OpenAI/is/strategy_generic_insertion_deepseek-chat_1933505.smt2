(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.* (re.range "0" "9")) (re.range "0" "9") (re.opt (re.union (re.++ re.allchar (re.* (re.range "0" "9")) (re.range "0" "9")) (re.++ (str.to_re ",") (re.* (re.range "0" "9")) (re.range "0" "9")))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const delim String)
(declare-const firstSeg String)
(declare-const restAfterFirst String)

(assert (= delim ","))
(assert (>= (str.len X) 0))
(assert (>= (num_splits X delim) 1))
(assert (= firstSeg (split_at X delim 0)))
(assert (= restAfterFirst (split_rest X delim 1)))
(assert (=> (>= (num_splits X delim) 2) (= X (str.++ firstSeg delim restAfterFirst))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
