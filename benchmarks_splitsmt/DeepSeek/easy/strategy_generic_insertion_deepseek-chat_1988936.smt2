(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.union (re.++ (re.union (str.to_re "0") (str.to_re "7")) (re.range "1" "7")) (re.++ (str.to_re "1") (re.range "0" "6")) (re.++ (str.to_re "2") (re.range "0" "7")) (re.++ (re.union (str.to_re "3") (str.to_re "5")) (re.range "0" "9")) (re.++ (re.union (str.to_re "4") (str.to_re "6") (str.to_re "8")) (re.range "0" "8")) (re.++ (str.to_re "9") (re.union (re.range "0" "5") (str.to_re "8") (str.to_re "9")))) (re.opt (str.to_re "-")) ((_ re.loop 7 7) (re.range "0" "9")) (str.to_re "\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "\u{a}on") (re.union (str.to_re "blur") (re.++ (str.to_re "c") (re.union (str.to_re "hange") (str.to_re "lick"))) (str.to_re "dblclick") (str.to_re "focus") (str.to_re "keypress") (re.++ (re.union (str.to_re "key") (str.to_re "mouse")) (re.union (str.to_re "down") (str.to_re "up"))) (re.++ (re.opt (str.to_re "un")) (str.to_re "load")) (re.++ (str.to_re "mouse") (re.union (str.to_re "move") (re.++ (str.to_re "o") (re.union (str.to_re "ut") (str.to_re "ver"))))) (str.to_re "reset") (re.++ (str.to_re "s") (re.union (str.to_re "elect") (str.to_re "ubmit"))))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter "-"))
(assert (= segment0 (str.split_at X delimiter 0)))
(assert (= segment1 (str.split_at X delimiter 1)))
(assert (= total_segments (str.num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (>= (str.len segment0) 2))
(assert (>= (str.len segment1) 7))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
