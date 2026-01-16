(set-logic ALL)
(declare-const x String)
(declare-const y String)
(declare-const m String)
(declare-const n String)
(assert (= (str.++ y x) (str.++ n m)))
(assert (str.in_re n (re.* (str.to_re ""))))
(assert (> (str.to_int x) (str.len m)))

; --- START CONSTRAINT ---

(declare-const d String)
(declare-const k Int)

(assert (= d ""))
(assert (>= k 0))
(assert (< k (str.num_splits y d)))
(assert (= (str.split_at y d k) ""))
(assert (= (str.split_rest y d (str.num_splits y d)) ""))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
