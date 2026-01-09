(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.* (re.++ (re.* (str.to_re "]")) (str.to_re "")))))
(assert (= (str.len x) 0))
(assert (not (= x "]]1' 'zz")))
(assert (not (= x "GhGGhG3a'\t'")))
(assert (not (= x "]'\r'*")))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter ":"))
(assert (>= (num_splits x delimiter) 1))
(assert (= (split_at x delimiter 0) "example"))
(assert (str.contains (split_rest x delimiter 1) "data"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]