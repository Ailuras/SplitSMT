(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "{") ((_ re.loop 8 8) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 12 12) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "}\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for UUID parsing
(declare-const uuid_parts String)
(declare-const part1 String)
(declare-const part2 String)
(declare-const part3 String)
(declare-const part4 String)
(declare-const part5 String)
; Assert constraints using str_split operations
(assert (= uuid_parts (str.substr X 1 (- (str.len X) 2))))
(assert (= part1 (split_at uuid_parts "-" 0)))
(assert (= part2 (split_at uuid_parts "-" 1)))
(assert (= part3 (split_at uuid_parts "-" 2)))
(assert (= part4 (split_at uuid_parts "-" 3)))
(assert (= part5 (split_at uuid_parts "-" 4)))
(assert (= (num_splits uuid_parts "-") 5))
(assert (= (str.len part1) 8))
(assert (= (str.len part2) 4))
(assert (= (str.len part3) 4))
(assert (= (str.len part4) 4))
(assert (= (str.len part5) 12))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
