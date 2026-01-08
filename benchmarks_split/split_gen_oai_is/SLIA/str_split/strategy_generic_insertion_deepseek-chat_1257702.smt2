(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (str.to_re "0") (str.to_re "+33")) (re.range "1" "9") ((_ re.loop 4 4) (re.++ (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " "))) ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const area String)
(declare-const subscriber String)

; Parse phone-like input by spaces: "<area> <subscriber>"
(assert (>= (num_splits X " ") 2))
(assert (= area (split_at X " " 0)))
(assert (= subscriber (split_rest X " " 1)))

; Constrain area code to be either "0" or "+33" and subscriber to be 9 digits
(assert (or (= area "0") (= area "+33")))
(assert (= (str.len subscriber) 9))
(assert (str.in_re subscriber (re.++ ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "\u{a}"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]