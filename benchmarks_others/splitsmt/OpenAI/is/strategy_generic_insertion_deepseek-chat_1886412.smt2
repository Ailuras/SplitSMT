(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.+ (re.union (str.to_re "\u{5c}\u{22}") (str.to_re "\u{22}") (str.to_re "(") (str.to_re "\u{5c}") (str.to_re ")"))) (str.to_re "\u{a}"))))
(assert (not (str.in_re X (re.union (re.++ ((_ re.loop 3 3) (re.range "A" "Z")) (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 1 1) (str.to_re "d"))) (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.range "A" "Z")) (re.++ (re.range "A" "Z") (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union ((_ re.loop 3 3) (re.range "0" "9")) ((_ re.loop 2 2) (re.range "0" "9")) ((_ re.loop 1 1) (re.range "0" "9"))) (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 3 3) (re.range "A" "Z"))) (re.++ (str.to_re "\u{a}") (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (re.++ (str.to_re "0") (re.range "2" "9")) (re.++ (re.range "1" "9") (re.range "0" "9"))) (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) ((_ re.loop 3 3) (re.union (re.range "A" "H") (re.range "J" "P") (re.range "R" "Z"))) (re.union (re.range "A" "H") (re.range "K" "P") (str.to_re "R") (str.to_re "S") (str.to_re "V") (str.to_re "W") (str.to_re "Y")) (re.union (re.range "A" "H") (re.range "J" "P") (re.range "R" "Y")))))))
(assert (str.in_re X (re.++ (re.union (str.to_re " ") (str.to_re "a") (re.range " " " ") (str.to_re "z") (str.to_re ",") (str.to_re "0") (str.to_re "9") (str.to_re "?") (str.to_re ".")) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "Subject:") (re.+ (re.range "0" "9")) (str.to_re "zmnjgmomgbdz/zzmw.gzt\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/.jnlp") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}")))))

; --- START CONSTRAINT ---

(declare-const subj_prefix String)
(declare-const subj_digits String)
(declare-const subj_suffix String)

(assert (>= (str.num_splits X "Subject:") 2))
(assert (= subj_prefix (str.split_at X "Subject:" 0)))
(assert (= subj_digits (str.split_at X "Subject:" 1)))
(assert (= subj_suffix (str.split_rest X "Subject:" 2)))

(assert (= subj_prefix ""))
(assert (str.in_re subj_digits (re.+ (re.range "0" "9"))))
(assert (= subj_suffix "zmnjgmomgbdz/zzmw.gzt\n"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
