(set-logic ALL)
(declare-const x String)
(declare-const y String)
(declare-const m String)
(declare-const n String)
(assert (= (str.++ y x) (str.++ n m)))
(assert (str.in_re n (re.* (str.to_re ""))))
(assert (> (str.to_int x) (str.len m)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const d String)
(declare-const k Int)

(assert (= d ""))
(assert (>= k 0))
(assert (< k (num_splits y d)))
(assert (= (split_at y d k) ""))
(assert (= (split_rest y d (num_splits y d)) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]