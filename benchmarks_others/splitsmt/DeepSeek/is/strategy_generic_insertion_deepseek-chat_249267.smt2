(set-logic ALL)
(declare-fun x () String)
(declare-fun y () String)
(assert (not (= (str.replace x (str.replace y y "") x) (str.++ x x))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delim String)
(declare-const seg0 String)
(declare-const seg1 String)
(declare-const total_segs Int)
; Assert constraints using str_split operations
(assert (= delim ":"))
(assert (= seg0 (str.split_at x delim 0)))
(assert (= seg1 (str.split_at x delim 1)))
(assert (= total_segs (str.num_splits x delim)))
(assert (>= total_segs 2))
(assert (not (= (str.++ seg0 seg1) (str.split_rest x delim 2))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
