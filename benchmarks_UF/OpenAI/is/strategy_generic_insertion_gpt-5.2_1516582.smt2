(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "//f/1") ((_ re.loop 9 9) (re.range "0" "9")) (str.to_re "/") ((_ re.loop 9 10) (re.range "0" "9")) (re.+ (re.++ (str.to_re "/") (re.range "0" "9"))) (str.to_re "/U\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const seg2 String)

(assert (>= (num_splits X "/") 2))
(assert (= seg0 (split_at X "/" 0)))
(assert (= seg1 (split_at X "/" 1)))
(assert (= seg2 (split_at X "/" 2)))
(assert (= (split_rest X "/" 1) (str.++ seg1 "/" (split_rest X "/" 2))))
(assert (not (= seg0 "")))
(assert (not (= seg1 "f")))
(assert (not (and (= seg0 "") (= seg1 "") (= seg2 "f"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]