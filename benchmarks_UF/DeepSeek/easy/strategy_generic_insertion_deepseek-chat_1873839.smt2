(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/\u{ff}\u{fe}?\u{10}\u{0}\u{0}") ((_ re.loop 14 14) re.allchar) ((_ re.loop 20 20) (re.union (str.to_re "+") (str.to_re "x") (str.to_re "/") (re.range "a" "z") (re.range "0" "9"))) (str.to_re "/smi\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "Spy") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "toolbar_domain_redirect\u{a}")))))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split
; Declare new variables for splitting operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter "/"))
(assert (= segment0 (split_at X delimiter 0)))
(assert (= segment1 (split_at X delimiter 1)))
(assert (= total_segments (num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (str.contains (split_rest X delimiter 2) "smi"))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
