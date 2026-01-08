(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:") (re.* re.allchar) (str.to_re "c=MicrosoftStartupStarLoggerServerX-Mailer:\u{13}\u{a}")))))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split operations
; Declare new variables for split analysis
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (str.split_at X delimiter 0)))
(assert (= segment1 (str.split_at X delimiter 1)))
(assert (= total_segments (str.num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (str.contains (str.split_rest X delimiter 2) "Host"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
