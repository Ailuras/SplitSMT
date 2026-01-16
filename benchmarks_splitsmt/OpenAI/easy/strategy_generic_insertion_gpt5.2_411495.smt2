(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/Libs/Starter") (re.union (str.to_re "CmdExec") (str.to_re "NetUtils") (str.to_re "Rec") (str.to_re "ScreenShots") (str.to_re "Settings")) (str.to_re ".py/\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/nsrmm") (re.* (re.comp (str.to_re "\u{0}"))) (re.union (str.to_re "$(") (str.to_re ";") (str.to_re "|") (str.to_re "&") (str.to_re "`")) (str.to_re "/\u{a}")))))

; --- START CONSTRAINT ---

(declare-const x_prefix String)
(declare-const x_suffix String)

(assert (= x_prefix (str.split_at X "/" 0)))
(assert (= x_suffix (str.split_rest X "/" 1)))
(assert (>= (str.num_splits X "/") 1))
(assert (>= (str.num_splits X "/") 2))
(assert (= x_prefix ""))
(assert (not (str.contains x_suffix "$(")))
(assert (not (str.contains x_suffix ";")))
(assert (not (str.contains x_suffix "|")))
(assert (not (str.contains x_suffix "&")))
(assert (not (str.contains x_suffix "`")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
