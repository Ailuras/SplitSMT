(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.union (str.to_re "**[[::ee") (re.union (str.to_re "112233") (str.to_re "!!))"))))))
(assert (= 10 (str.len x)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const d String)
(declare-const p0 String)
(declare-const rest1 String)

(assert (= d "11"))
(assert (>= (num_splits x d) 1))
(assert (>= (num_splits x d) 2))
(assert (= p0 (split_at x d 0)))
(assert (= rest1 (split_rest x d 1)))
(assert (= x (str.++ p0 d rest1)))
(assert (>= (str.len p0) 0))
(assert (>= (str.len rest1) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
