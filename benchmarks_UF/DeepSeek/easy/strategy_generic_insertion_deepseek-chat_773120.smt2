(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun x () String)
(assert (let ((_let_0 (re.* re.allchar ))) (let ((_let_1 (str.++ "B" (str.++ "B" "B")))) (and (not (= (str.in_re x (re.++ _let_0 re.allchar  _let_0 (str.to_re "B") _let_0 (str.to_re (str.++ "A" (str.++ "C" "B"))) _let_0)) (str.in_re x (re.++ _let_0 re.allchar  _let_0 re.allchar  _let_0 (str.to_re (str.++ "C" (str.++ "C" (str.++ "B" "C")))) _let_0)))) (not (= (str.in_re x (re.++ _let_0 re.allchar  _let_0 re.allchar  _let_0 (re.++ (str.to_re _let_1) re.allchar ) _let_0)) (str.in_re x (re.++ _let_0 re.allchar  _let_0 re.allchar  _let_0 (str.to_re (str.++ "B" _let_1)) _let_0))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delim String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delim "B"))
(assert (= segment0 (split_at x delim 0)))
(assert (= segment1 (split_at x delim 1)))
(assert (= total_segments (num_splits x delim)))
(assert (>= total_segments 2))
(assert (str.contains (split_rest x delim 2) "A"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
