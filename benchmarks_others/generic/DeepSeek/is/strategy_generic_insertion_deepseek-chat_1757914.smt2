(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "S") (re.++ (str.to_re "t") (re.++ (str.to_re "r") (re.++ (str.to_re "i") (re.++ (str.to_re "n") (re.++ (str.to_re "g") (re.++ (str.to_re " ") (re.++ (str.to_re "p") (re.++ (str.to_re "a") (re.++ (str.to_re "t") (re.++ (str.to_re "t") (re.++ (str.to_re "e") (re.++ (str.to_re "r") (re.++ (str.to_re "n") (re.++ (str.to_re " ") (re.++ (str.to_re "=") (re.++ (str.to_re " ") (re.++ (str.to_re "\u{22}") (re.++ ((_ re.loop 3 3) (re.union (re.union (re.++ (re.opt (re.union (str.to_re "0") (str.to_re "1"))) (re.++ (str.to_re "\\") ((_ re.loop 1 2) (str.to_re "d")))) (re.++ (str.to_re "2") (re.++ (re.range "0" "4") (re.++ (str.to_re "\\") (str.to_re "d"))))) (re.++ (str.to_re "25") (re.++ (re.range "0" "5") (re.++ (str.to_re "\\") (re.diff re.allchar (str.to_re "\n"))))))) (re.++ (re.union (re.union (re.++ (re.opt (re.union (str.to_re "0") (str.to_re "1"))) (re.++ (str.to_re "\\") ((_ re.loop 1 2) (str.to_re "d")))) (re.++ (str.to_re "2") (re.++ (re.range "0" "4") (re.++ (str.to_re "\\") (str.to_re "d"))))) (re.++ (str.to_re "25") (re.range "0" "5"))) (re.++ (str.to_re "\u{22}") (str.to_re ";"))))))))))))))))))))))))
(assert (not (str.in_re X (re.++ re.all (re.union (str.to_re "\u{3c}") (str.to_re "\u{3e}") (str.to_re "\u{27}") (str.to_re "\u{22}") (str.to_re "\u{26}")) re.all))))
(assert (< 20 (str.len X)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const total_segments Int)
(declare-const rest_string String)
; Assert constraints using str_split operations
(assert (= delimiter " "))
(assert (= first_segment (split_at X delimiter 0)))
(assert (= total_segments (num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (= rest_string (split_rest X delimiter 1)))
(assert (>= (str.len first_segment) 5))
(assert (str.contains rest_string "pattern"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
