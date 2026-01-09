(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/.mp4") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}")))))

; --- START CONSTRAINT ---
; str_split interface function signatures
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Ensure a basic structural decomposition of X around the substring "/.mp4"
(assert (>= (num_splits X "/.mp4") 2))
(assert (= X (str.++ (split_at X "/.mp4" 0) "/.mp4" (split_rest X "/.mp4" 1))))

; Constrain the suffix after "/.mp4" not to start with one of the disallowed single-character prefixes
(assert (not (= (str.at (split_rest X "/.mp4" 1) 0) "?")))
(assert (not (= (str.at (split_rest X "/.mp4" 1) 0) "\\")))
(assert (not (= (str.at (split_rest X "/.mp4" 1) 0) "/")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
