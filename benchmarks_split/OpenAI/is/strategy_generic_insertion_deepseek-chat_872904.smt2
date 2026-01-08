(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.union (str.to_re "**[[::ee") (re.union (str.to_re "112233") (str.to_re "!!))"))))))
(assert (= 10 (str.len x)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const d String)
(declare-const s0 String)
(declare-const s1 String)
(declare-const rest1 String)

(assert (= d "!!))"))
(assert (>= (num_splits x d) 2))
(assert (= s0 (split_at x d 0)))
(assert (= s1 (split_at x d 1)))
(assert (= rest1 (split_rest x d 1)))
(assert (= (str.++ s0 d rest1) x))
(assert (>= (str.len s0) 1))
(assert (>= (str.len s1) 1))
(assert (str.contains x d))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]