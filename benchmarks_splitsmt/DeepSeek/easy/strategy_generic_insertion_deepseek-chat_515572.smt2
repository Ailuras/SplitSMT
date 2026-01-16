(set-logic ALL)
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (str.contains value2 "C") 1 0) 0)))) (not (not (= (ite (str.contains value2 "B") 1 0) 0)))) (not (not (= (ite (str.contains value2 "A") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-fun split_segment0 () String)
(declare-fun split_segment1 () String)
(declare-fun total_splits () Int)
; Assert constraints using str_split operations
(assert (= split_segment0 (str.split_at value2 "," 0)))
(assert (= split_segment1 (str.split_at value2 "," 1)))
(assert (= total_splits (str.num_splits value2 ",")))
(assert (>= total_splits 2))
(assert (str.contains split_segment0 "A"))
(assert (str.contains split_segment1 "B"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
