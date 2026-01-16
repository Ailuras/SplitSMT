(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun value2 () String)
(declare-fun key2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "connection") 1 0) 0))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-fun delimiter () String)
(declare-fun segment0 () String)
(declare-fun segment1 () String)
(declare-fun total_segments () Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (split_at value2 delimiter 0)))
(assert (= segment1 (split_at value2 delimiter 1)))
(assert (= total_segments (num_splits value2 delimiter)))
(assert (>= total_segments 2))
(assert (not (str.contains segment0 " ")))
(assert (not (str.contains segment1 " ")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
