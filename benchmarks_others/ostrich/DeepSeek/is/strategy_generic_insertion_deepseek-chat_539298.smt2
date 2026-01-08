(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.union (re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (str.to_re ".") (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.+ (re.union (str.to_re ".") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 1 2) (re.range "0" "9")) (re.* (re.union (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (str.to_re " ") ((_ re.loop 0 4) (re.range "0" "9")) (re.* (re.union (str.to_re "-") (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 3 9) (re.union (re.range "A" "Z") (re.range "a" "z"))) (re.* (re.union (str.to_re "-") (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 1 2) (re.range "0" "9")) (re.* (re.union (str.to_re "-") (str.to_re ",") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 0 8) (re.union (re.range "A" "Z") (re.range "a" "z")))) (re.++ (str.to_re " \u{a}") ((_ re.loop 1 4) (re.range "0" "9")) (re.union (str.to_re "/") (str.to_re ".") (str.to_re "-")) ((_ re.loop 1 4) (re.range "0" "9")) (re.union (str.to_re "/") (str.to_re ".") (str.to_re "-")) ((_ re.loop 1 4) (re.range "0" "9")))))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ","))
(assert (= segment0 (split_at X delimiter 0)))
(assert (= segment1 (split_at X delimiter 1)))
(assert (= total_segments (num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (str.contains (split_rest X delimiter 2) "example"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
