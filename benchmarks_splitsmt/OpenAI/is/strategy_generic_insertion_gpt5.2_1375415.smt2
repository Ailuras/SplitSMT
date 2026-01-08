(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "ookflolfctm/nmot.fmu\u{a}")))
(assert (str.in_re X (re.++ (re.opt (re.++ (str.to_re "//-->") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))))) (str.to_re "<") (re.opt (str.to_re "/")) (str.to_re "SCRIPT") (re.* (re.comp (str.to_re ">"))) (str.to_re ">") (re.opt (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "<!--") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "whenu.com\u{1b}") (re.+ (re.range "0" "9")) (str.to_re "Agent") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "toWebupdate.cgithisHost:connection\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/(?=") ((_ re.loop 300 300) (re.comp (str.to_re ")"))) (str.to_re "/\u{a}")))))
(assert (str.in_re X (str.to_re "ixqshv/qzccsMM_RECO.EXE%3fwwwwp-includes/theme.php?\u{a}")))

; --- START CONSTRAINT ---

(declare-const seg0_nl String)
(declare-const seg1_nl String)
(declare-const rest_from_1_nl String)

(assert (>= (str.num_splits X "\n") 1))
(assert (= seg0_nl (str.split_at X "\n" 0)))
(assert (= seg1_nl (str.split_at X "\n" 1)))
(assert (= rest_from_1_nl (str.split_rest X "\n" 1)))

(assert (str.contains seg0_nl "ookflolfctm/nmot.fmu"))
(assert (str.contains rest_from_1_nl "ixqshv/qzccsMM_RECO.EXE%3fwwwwp-includes/theme.php?"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
