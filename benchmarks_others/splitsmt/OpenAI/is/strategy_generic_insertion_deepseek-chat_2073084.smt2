(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "ookflolfctm/nmot.fmu\u{a}")))
(assert (str.in_re X (re.++ (re.opt (re.++ (str.to_re "//-->") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))))) (str.to_re "<") (re.opt (str.to_re "/")) (str.to_re "SCRIPT") (re.* (re.comp (str.to_re ">"))) (str.to_re ">") (re.opt (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "<!--") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "whenu.com\u{1b}") (re.+ (re.range "0" "9")) (str.to_re "Agent") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "toWebupdate.cgithisHost:connection\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/(?=") ((_ re.loop 300 300) (re.comp (str.to_re ")"))) (str.to_re "/\u{a}")))))
(assert (str.in_re X (str.to_re "ixqshv/qzccsMM_RECO.EXE%3fwwwwp-includes/theme.php?\u{a}")))

; --- START CONSTRAINT ---

(declare-const prefix_before_nl String)
(declare-const suffix_from_nl String)
(declare-const first_line String)
(declare-const last_line String)

(assert (>= (str.num_splits X "\u{a}") 2))
(assert (= prefix_before_nl (str.split_at X "\u{a}" 0)))
(assert (= suffix_from_nl (str.split_rest X "\u{a}" 1)))
(assert (= first_line prefix_before_nl))
(assert (= last_line suffix_from_nl))
(assert (>= (str.len first_line) 0))
(assert (>= (str.len last_line) 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
