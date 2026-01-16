(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(assert (str.in_re x (str.to_re "c\\|8")))

; --- START CONSTRAINT ---

(declare-const d String)
(declare-const k Int)
(declare-const seg0 String)
(declare-const rest0 String)

(assert (= d "\\|"))
(assert (= k 0))
(assert (= seg0 (split_at x d k)))
(assert (= rest0 (split_rest x d k)))
(assert (>= (num_splits x d) 1))
(assert (= rest0 x))
(assert (= seg0 x))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
