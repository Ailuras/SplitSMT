(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union ((_ re.loop 1 1) (re.range "0" "9")) (re.++ ((_ re.loop 1 1) (re.range "0" "9")) ((_ re.loop 1 1) (re.range "0" "9"))) (re.++ ((_ re.loop 1 1) (re.range "1" "3")) ((_ re.loop 1 1) (re.range "0" "6")) ((_ re.loop 1 1) (re.range "0" "5")))) (str.to_re "d") (re.union ((_ re.loop 1 1) (re.range "0" "9")) (re.++ (str.to_re "1") ((_ re.loop 1 1) (re.range "0" "9"))) (re.++ ((_ re.loop 1 1) (re.range "1" "2")) ((_ re.loop 1 1) (re.range "0" "3")))) (str.to_re "h") (re.union ((_ re.loop 1 1) (re.range "0" "9")) (re.++ ((_ re.loop 1 1) (re.range "1" "5")) ((_ re.loop 1 1) (re.range "0" "9")))) (str.to_re "m\u{a}")))))
(assert (str.in_re X (re.union (re.+ (re.range "0" "9")) (re.++ (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.union (str.to_re " ") (str.to_re ",") (str.to_re ".")) (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.union (str.to_re " ") (str.to_re ",") (str.to_re ".")))) ((_ re.loop 3 3) (re.range "0" "9"))) ((_ re.loop 1 3) (re.range "0" "9"))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const x_head String)
(declare-const x_tail String)
(declare-const x_prefix String)

(assert (>= (str.len X) 1))

; Split X on newline (\u{a}) into head and rest
(assert (= x_head (split_at X "\u{a}" 0)))
(assert (= x_tail (split_rest X "\u{a}" 1)))
(assert (>= (num_splits X "\u{a}") 1))

; If there is a newline, then X = head + "\u{a}" + tail; otherwise tail is empty
(assert (=> (>= (num_splits X "\u{a}") 2)
            (= X (str.++ x_head "\u{a}" x_tail))))
(assert (=> (= (num_splits X "\u{a}") 1)
            (= x_tail "")))

; Also split on comma to relate segments
(assert (= x_prefix (split_at X "," 0)))
(assert (>= (num_splits X ",") 1))

; Basic segment well-formedness (indices natural and within bounds)
(assert (>= (str.len x_head) 0))
(assert (>= (str.len x_tail) 0))
(assert (<= (str.len x_head) (str.len X)))
(assert (<= (str.len x_tail) (str.len X)))
(assert (<= (str.len x_prefix) (str.len X)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
