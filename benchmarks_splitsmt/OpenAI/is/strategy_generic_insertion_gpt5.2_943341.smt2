(set-logic ALL)
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) (- (str.len (str.substr value2 0 (- (- (str.len value2) 1) 0))) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) (- (str.len (str.substr value2 0 (- (- (str.len value2) 1) 0))) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) (- (str.len (str.substr value2 0 (- (- (str.len value2) 1) 0))) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value2 0 (- (- (str.len value2) 1) 0)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr value2 0 (- (- (str.len value2) 1) 0))) 0) 1 0) 0)))) (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{d}") 1 0) 0))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)) (>= 0 0)) (>= (- (- (str.len value2) 1) 0) 0)))

; --- START CONSTRAINT ---

(declare-fun cc_directive0 () String)
(declare-fun cc_directive1 () String)
(declare-fun cc_rest_from2 () String)

(assert (= cc_directive0 (str.split_at value2 "," 0)))
(assert (= cc_directive1 (str.split_at value2 "," 1)))
(assert (= cc_rest_from2 (str.split_rest value2 "," 2)))

(assert (>= (str.num_splits value2 ",") 2))
(assert (not (= (str.len cc_directive0) 0)))
(assert (not (= (str.len cc_directive1) 0)))
(assert (or (= (str.len cc_rest_from2) 0) (>= (str.num_splits value2 ",") 3)))

(assert (not (= (str.indexof cc_directive0 "=" 0) (- 1))))
(assert (not (= (str.indexof cc_directive1 "=" 0) (- 1))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
