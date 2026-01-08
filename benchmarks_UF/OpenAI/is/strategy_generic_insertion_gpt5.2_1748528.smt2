(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun key1 () String)
(declare-fun value2 () String)
(declare-fun key2 () String)
(declare-fun value1 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.len (str.substr value1 (+ (str.indexof value1 "=" 0) 1) (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)))) 0) 1 0) 0)))) (not (= (ite (str.contains value1 "=") 1 0) 0))) (not (not (= (ite (= (str.len value1) 0) 1 0) 0)))) (not (= (ite (not (= (str.indexof value1 "=" 0) (- 1))) 1 0) 0))) (not (not (= (ite (str.contains value1 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value1) 0) 1 0) 0)))) (not (= (ite (= key1 "cache-control") 1 0) 0))) (not (= (ite (= key1 "cache-control") 1 0) 0))) (not (not (= (ite (str.contains value2 "Z") 1 0) 0)))) (not (not (= (ite (str.contains value2 "Y") 1 0) 0)))) (not (not (= (ite (str.contains value2 "X") 1 0) 0)))) (not (not (= (ite (str.contains value2 "W") 1 0) 0)))) (not (not (= (ite (str.contains value2 "V") 1 0) 0)))) (not (not (= (ite (str.contains value2 "U") 1 0) 0)))) (not (not (= (ite (str.contains value2 "T") 1 0) 0)))) (not (not (= (ite (str.contains value2 "S") 1 0) 0)))) (not (not (= (ite (str.contains value2 "R") 1 0) 0)))) (not (not (= (ite (str.contains value2 "Q") 1 0) 0)))) (not (not (= (ite (str.contains value2 "P") 1 0) 0)))) (not (not (= (ite (str.contains value2 "O") 1 0) 0)))) (not (not (= (ite (str.contains value2 "N") 1 0) 0)))) (not (not (= (ite (str.contains value2 "M") 1 0) 0)))) (not (not (= (ite (str.contains value2 "L") 1 0) 0)))) (not (not (= (ite (str.contains value2 "K") 1 0) 0)))) (not (not (= (ite (str.contains value2 "J") 1 0) 0)))) (not (not (= (ite (str.contains value2 "I") 1 0) 0)))) (not (not (= (ite (str.contains value2 "H") 1 0) 0)))) (not (not (= (ite (str.contains value2 "G") 1 0) 0)))) (not (not (= (ite (str.contains value2 "F") 1 0) 0)))) (not (not (= (ite (str.contains value2 "E") 1 0) 0)))) (not (not (= (ite (str.contains value2 "D") 1 0) 0)))) (not (not (= (ite (str.contains value2 "C") 1 0) 0)))) (not (not (= (ite (str.contains value2 "B") 1 0) 0)))) (not (not (= (ite (str.contains value2 "A") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= (+ (str.indexof value1 "=" 0) 1) 0)) (>= (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)) 0)))

; --- START CONSTRAINT ---

(declare-fun v1_key () String)
(declare-fun v1_val () String)
(declare-fun v2_key () String)
(declare-fun v2_val () String)

(assert (>= (num_splits value1 "=") 2))
(assert (= v1_key (split_at value1 "=" 0)))
(assert (= v1_val (split_rest value1 "=" 1)))

(assert (>= (num_splits value2 "=") 2))
(assert (= v2_key (split_at value2 "=" 0)))
(assert (= v2_val (split_rest value2 "=" 1)))

(assert (and (not (= v1_key "")) (not (= v1_val ""))))
(assert (and (not (= v2_key "")) (not (= v2_val ""))))

(assert (= v1_key key1))
(assert (= v2_key key2))

(assert (>= (num_splits value1 ",") 2))
(assert (= (split_at value1 "," 0) (split_at value1 "," 0)))
(assert (= (split_rest value1 "," 1) (split_rest value1 "," 1)))

(assert (>= (num_splits value2 ",") 2))
(assert (= (split_at value2 "," 0) (split_at value2 "," 0)))
(assert (= (split_rest value2 "," 1) (split_rest value2 "," 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
