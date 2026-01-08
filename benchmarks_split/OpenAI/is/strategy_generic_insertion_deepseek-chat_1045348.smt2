(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "EFError") (re.* re.allchar) (str.to_re "Host:") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "www.malware-stopper.com\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const hostLine String)
(declare-const afterHost String)

(assert (>= (num_splits X "Host:") 2))
(assert (= afterHost (split_at X "Host:" 1)))
(assert (= hostLine (split_at afterHost "\n" 0)))
(assert (str.contains hostLine "www.malware-stopper.com"))

(assert (>= (num_splits X "EFError") 2))
(assert (str.contains (split_rest X "EFError" 1) "Host:"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]