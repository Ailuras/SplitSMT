(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "aohobygi/zwiw") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "+The+password+is:\u{a}")))))
(assert (not (str.in_re X (re.++ (re.opt (str.to_re "1")) (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " "))) (re.opt (re.union (re.++ (str.to_re "(") ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (str.to_re ")")) (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " ")))) (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " ")))))) ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " "))) ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "-") (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2"))) (str.to_re "-") (re.union (re.++ (str.to_re "3") (re.range "0" "1")) (re.++ (re.range "0" "2") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9"))) (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (re.union (re.++ (str.to_re "2") (re.range "0" "3")) (re.++ (re.range "0" "1") (re.range "0" "9"))) (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (str.to_re "\u{a}20") ((_ re.loop 2 2) (re.range "0" "9")))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delim String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delim " "))
(assert (= segment0 (split_at X delim 0)))
(assert (= segment1 (split_at X delim 1)))
(assert (= total_segments (num_splits X delim)))
(assert (>= total_segments 2))
(assert (str.contains segment0 "password"))
(assert (str.contains segment1 "20"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
