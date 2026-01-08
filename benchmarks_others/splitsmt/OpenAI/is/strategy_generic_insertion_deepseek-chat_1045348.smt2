(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "EFError") (re.* re.allchar) (str.to_re "Host:") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "www.malware-stopper.com\u{a}")))))

; --- START CONSTRAINT ---

(declare-const hostLine String)
(declare-const afterHost String)

(assert (>= (str.num_splits X "Host:") 2))
(assert (= afterHost (str.split_at X "Host:" 1)))
(assert (= hostLine (str.split_at afterHost "\n" 0)))
(assert (str.contains hostLine "www.malware-stopper.com"))

(assert (>= (str.num_splits X "EFError") 2))
(assert (str.contains (str.split_rest X "EFError" 1) "Host:"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
