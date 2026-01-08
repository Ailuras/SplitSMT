(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "www.fast-finder.com") (re.* (re.union (str.to_re "\u{a}") (str.to_re "\u{d}"))) (str.to_re "/bar_pl/chk.fcgi") (re.+ (re.range "0" "9")) (str.to_re "Toolbar\u{a}")))))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for splitting X by delimiter "/"
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= segment0 (split_at X "/" 0)))
(assert (= segment1 (split_at X "/" 1)))
(assert (= total_segments (num_splits X "/")))
(assert (>= total_segments 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
