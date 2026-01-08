(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (str.to_re "R")))
(assert (> 0 (str.len x)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const d String)
(assert (= d ":"))
(assert (>= (num_splits x d) 1))
(assert (= (split_at x d 0) "R"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)