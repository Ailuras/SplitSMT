(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/Libs/Starter") (re.union (str.to_re "CmdExec") (str.to_re "NetUtils") (str.to_re "Rec") (str.to_re "ScreenShots") (str.to_re "Settings")) (str.to_re ".py/\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/nsrmm") (re.* (re.comp (str.to_re "\u{0}"))) (re.union (str.to_re "$(") (str.to_re ";") (str.to_re "|") (str.to_re "&") (str.to_re "`")) (str.to_re "/\u{a}")))))

; --- START CONSTRAINT ---

(declare-const x_prefix String)
(declare-const x_suffix String)

(assert (= x_prefix (split_at X "/" 0)))
(assert (= x_suffix (split_rest X "/" 1)))
(assert (>= (num_splits X "/") 1))
(assert (>= (num_splits X "/") 2))
(assert (= x_prefix ""))
(assert (not (str.contains x_suffix "$(")))
(assert (not (str.contains x_suffix ";")))
(assert (not (str.contains x_suffix "|")))
(assert (not (str.contains x_suffix "&")))
(assert (not (str.contains x_suffix "`")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
