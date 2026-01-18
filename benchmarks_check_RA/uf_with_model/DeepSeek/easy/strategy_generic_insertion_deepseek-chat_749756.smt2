(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun var_4 () String)
(declare-fun var_5 () String)
(assert (str.in_re (str.++ var_4 "z" var_5 ) (re.* (re.union (str.to_re "b") (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "z")) (str.to_re "b")))))))
(assert (str.in_re var_5 (re.* (re.range "a" "u"))))
(assert (str.in_re var_5 (re.* (str.to_re "b"))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))
(assert (str.in_re var_4 (re.* (str.to_re "a"))))
(assert (not (str.in_re "" re.none)))
(assert (<= 0  (str.len var_5)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (split_at var_4 delimiter 0)))
(assert (= segment1 (split_at var_4 delimiter 1)))
(assert (= total_segments (num_splits var_4 delimiter)))
(assert (>= total_segments 2))
(assert (str.contains (split_rest var_5 delimiter 0) "b"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
