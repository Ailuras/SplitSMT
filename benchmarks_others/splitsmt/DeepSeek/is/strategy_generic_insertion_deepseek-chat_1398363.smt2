(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.++ (re.++ (re.++ (re.++ (str.to_re "D") (re.++ (str.to_re "i") (re.++ (str.to_re "m") (re.++ (str.to_re " ") (re.++ (str.to_re "P") (re.++ (str.to_re "a") (re.++ (str.to_re "t") (re.++ (str.to_re "t") (re.++ (str.to_re "e") (re.++ (str.to_re "r") (re.++ (str.to_re "n") (re.++ (str.to_re " ") (re.++ (str.to_re "A") (re.++ (str.to_re "s") (re.++ (str.to_re " ") (re.++ (str.to_re "S") (re.++ (str.to_re "t") (re.++ (str.to_re "r") (re.++ (str.to_re "i") (re.++ (str.to_re "n") (re.++ (str.to_re "g") (str.to_re "=")))))))))))))))))))))) (re.++ (str.to_re "") (str.to_re "\u{22}"))) (re.++ (str.to_re "") (re.++ (re.union (re.++ (str.to_re "h") (re.++ (str.to_re "t") (re.++ (str.to_re "t") (re.++ (str.to_re "p") (re.++ (str.to_re "s") (re.++ (str.to_re ":") (re.++ (str.to_re "/") (re.++ (str.to_re "/") (re.++ (str.to_re "t") (re.++ (str.to_re ".") (re.++ (str.to_re "m") (re.++ (str.to_re "e") (str.to_re "/"))))))))))))) (re.++ (str.to_re "h") (re.++ (str.to_re "t") (re.++ (str.to_re "t") (re.++ (str.to_re "p") (re.++ (str.to_re "s") (re.++ (str.to_re ":") (re.++ (str.to_re "/") (re.++ (str.to_re "/") (re.++ (str.to_re "t") (re.++ (str.to_re "e") (re.++ (str.to_re "l") (re.++ (str.to_re "e") (re.++ (str.to_re "g") (re.++ (str.to_re "r") (re.++ (str.to_re "a") (re.++ (str.to_re "m") (re.++ (str.to_re ".") (re.++ (str.to_re "m") (re.++ (str.to_re "e") (str.to_re "/"))))))))))))))))))))) (re.++ ((_ re.loop 3 15) (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "_"))))) (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9"))))))) (re.++ (str.to_re "") (str.to_re "\u{22}"))) (str.to_re ""))))
(assert (not (str.in_re X (re.++ re.all (re.union (str.to_re "\u{3c}") (str.to_re "\u{3e}") (str.to_re "\u{27}") (str.to_re "\u{22}") (str.to_re "\u{26}")) re.all))))
(assert (< 20 (str.len X)))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const second_segment String)
(declare-const rest_string String)
; Assert constraints using str_split operations
(assert (= delimiter " "))
(assert (= first_segment (str.split_at X delimiter 0)))
(assert (= second_segment (str.split_at X delimiter 1)))
(assert (= rest_string (str.split_rest X delimiter 2)))
(assert (>= (str.num_splits X delimiter) 3))
(assert (>= (str.len first_segment) 5))
(assert (>= (str.len second_segment) 5))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
