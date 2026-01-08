(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) (- (str.len (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1))) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1))) 0) 1 0) 0)))) (not (= (ite (= (str.at (str.substr value2 1 (- (str.len value2) 1)) 0) "\u{9}") 1 0) 0))) (not (not (= (ite (= (str.at (str.substr value2 1 (- (str.len value2) 1)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr value2 1 (- (str.len value2) 1))) 0) 1 0) 0)))) (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const split_count Int)
(declare-const first_segment String)
(declare-const rest_segments String)
; Assert constraints using str_split operations
(assert (= split_count (num_splits value2 ",")))
(assert (>= split_count 1))
(assert (= first_segment (split_at value2 "," 0)))
(assert (= rest_segments (split_rest value2 "," 1)))
; Additional constraint: ensure the split is valid and relates to existing variables
(assert (str.contains value2 ","))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
