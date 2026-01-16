(set-logic ALL)
(declare-fun key () String)
(declare-fun value () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) (- (str.len (str.substr value 1 (- (str.len value) 1))) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at (str.substr value 1 (- (str.len value) 1)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr value 1 (- (str.len value) 1))) 0) 1 0) 0)))) (not (= (ite (= (str.at value 0) " ") 1 0) 0))) (not (not (= (ite (= (str.len value) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value ",") 1 0) 0)))) (not (not (= (ite (= (str.len value) 0) 1 0) 0)))) (not (= (ite (= key "cache-control") 1 0) 0))) (not (= (ite (= key "cache-control") 1 0) 0))) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)) (>= 1 0)) (>= (- (str.len value) 1) 0)))

; --- START CONSTRAINT ---

(declare-fun first_directive () String)
(declare-fun rest_directives () String)

(assert (= (str.num_splits value ",") 2))
(assert (= first_directive (str.split_at value "," 0)))
(assert (= rest_directives (str.split_rest value "," 1)))
(assert (not (= first_directive "")))
(assert (not (= rest_directives "")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
