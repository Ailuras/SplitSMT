(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:") (re.* re.allchar) (str.to_re "c=MicrosoftStartupStarLoggerServerX-Mailer:\u{13}\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const host_field String)
(declare-const after_host String)

(assert (>= (num_splits X "Host:") 2))
(assert (= host_field (split_at X "Host:" 1)))
(assert (= after_host (split_rest X "Host:" 1)))

(assert (>= (num_splits host_field "\u{13}\u{a}") 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]