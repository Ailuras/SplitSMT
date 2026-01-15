(set-logic ALL)
(declare-fun in1 () String)
(declare-fun in0 () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (str.contains in1 ".") 1 0) 0)))) (not (not (= (ite (str.contains in1 "+") 1 0) 0)))) (not (not (= (ite (= (str.len in1) 0) 1 0) 0)))) (not (not (= (ite (str.contains in1 "@") 1 0) 0)))) (not (not (= (ite (= (str.len in1) 0) 1 0) 0)))) (not (not (= (ite (str.contains (str.substr (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) 0 (- (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 0)) ".") 1 0) 0)))) (not (= (ite (= (str.len (str.substr (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) (+ (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 1) (- (str.len (str.substr in0 0 (- (str.indexof in0 "@" 0) 0))) (+ (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 1)))) 0) 1 0) 0))) (not (= (ite (str.contains (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+") 1 0) 0))) (not (not (= (ite (= (str.len (str.substr in0 0 (- (str.indexof in0 "@" 0) 0))) 0) 1 0) 0)))) (not (not (= (ite (str.contains (str.substr in0 (+ (str.indexof in0 "@" 0) 1) (- (str.len in0) (+ (str.indexof in0 "@" 0) 1))) "@") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr in0 (+ (str.indexof in0 "@" 0) 1) (- (str.len in0) (+ (str.indexof in0 "@" 0) 1)))) 0) 1 0) 0)))) (not (= (ite (str.contains in0 "@") 1 0) 0))) (not (not (= (ite (= (str.len in0) 0) 1 0) 0)))) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= (+ (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 1) 0)) (>= (- (str.len (str.substr in0 0 (- (str.indexof in0 "@" 0) 0))) (+ (str.indexof (str.substr in0 0 (- (str.indexof in0 "@" 0) 0)) "+" 0) 1)) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof in0 "@" 0) 0) 0)) (>= (+ (str.indexof in0 "@" 0) 1) 0)) (>= (- (str.len in0) (+ (str.indexof in0 "@" 0) 1)) 0)) (>= (+ (str.indexof in0 "@" 0) 1) 0)) (>= (- (str.len in0) (+ (str.indexof in0 "@" 0) 1)) 0)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const local_part String)
(declare-const domain_part String)
(declare-const username String)
(declare-const hostname String)
; Assert constraints using str_split operations
(assert (= local_part (str.split_at in0 "@" 0)))
(assert (= domain_part (str.split_at in0 "@" 1)))
(assert (>= (str.num_splits in0 "@") 2))
(assert (= username (str.split_at local_part "+" 0)))
(assert (>= (str.num_splits local_part "+") 1))
(assert (= hostname (str.split_at domain_part "." 0)))
(assert (>= (str.num_splits domain_part ".") 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
