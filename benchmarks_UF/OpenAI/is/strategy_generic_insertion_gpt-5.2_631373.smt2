(set-logic ALL)
(declare-fun key2 () String)
(declare-fun value2 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (= (str.at (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr (str.substr value2 1 (- (str.len value2) 1)) 1 (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1))) 0) 1 0) 0)))) (not (= (ite (= (str.at (str.substr value2 1 (- (str.len value2) 1)) 0) "\u{9}") 1 0) 0))) (not (not (= (ite (= (str.at (str.substr value2 1 (- (str.len value2) 1)) 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr value2 1 (- (str.len value2) 1))) 0) 1 0) 0)))) (not (= (ite (= (str.at value2 0) "\u{b}") 1 0) 0))) (not (not (= (ite (= (str.at value2 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value2 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))) (not (not (= (ite (not (= (str.indexof value2 "=" 0) (- 1))) 1 0) 0)))) (not (not (= (ite (str.contains value2 ",") 1 0) 0)))) (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (not (= (ite (= key2 "cache-control") 1 0) 0))) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len (str.substr value2 1 (- (str.len value2) 1))) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)) (>= 1 0)) (>= (- (str.len value2) 1) 0)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun cc_directive0 () String)
(declare-fun cc_directive1 () String)
(declare-fun cc_k0 () String)
(declare-fun cc_v0 () String)

(assert (= cc_directive0 (split_at value2 "," 0)))
(assert (>= (num_splits value2 ",") 1))

(assert (= cc_directive1 (split_at value2 "," 1)))
(assert (>= (num_splits value2 ",") 2))

; parse first directive as k=v using '='
(assert (>= (num_splits cc_directive0 "=") 2))
(assert (= cc_k0 (split_at cc_directive0 "=" 0)))
(assert (= cc_v0 (split_rest cc_directive0 "=" 1)))

; key should be non-empty and value should be non-empty
(assert (> (str.len cc_k0) 0))
(assert (> (str.len cc_v0) 0))

; ensure the split_rest corresponds to concatenation of remaining parts (at least two segments after '=')
(assert (= cc_v0 (str.++ (split_at cc_directive0 "=" 1) (split_rest cc_directive0 "=" 2))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]