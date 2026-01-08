(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "<img ") (re.* (re.++ (re.union (str.to_re "src") (str.to_re "height") (str.to_re "width") (str.to_re "border")) (str.to_re "=:q:W") (re.* (str.to_re "h")))) (str.to_re "/>\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "//{#") (re.+ (re.union (str.to_re "/") (str.to_re "{") (str.to_re "}"))) (str.to_re "}") (re.opt (str.to_re ".action")) (re.opt (str.to_re "/")) (str.to_re "/miU\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 42 42) (re.union (re.range "0" "9") (re.range "A" "F"))) (str.to_re "/Um\u{a}")))))

; --- START CONSTRAINT ---

(declare-const img_prefix String)
(declare-const img_body String)

(assert (>= (num_splits X "<img ") 2))
(assert (= img_prefix (split_at X "<img " 0)))
(assert (= img_body (split_rest X "<img " 1)))
(assert (= img_prefix ""))

(assert (>= (num_splits img_body "/>\n") 2))
(assert (= (split_at img_body "/>\n" 1) ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
