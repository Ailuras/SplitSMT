(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ ((_ re.loop 2 2) (re.union (re.range "A" "Z") (re.range "a" "z"))) ((_ re.loop 6 6) (re.range "0" "9")) ((_ re.loop 1 1) (re.union (re.range "A" "Z") (re.range "a" "z"))) (str.to_re "\u{a}"))))
(assert (str.in_re X (str.to_re "/newsurfer4/OK\u{d}\u{a}encodertvlistingsTM_SEARCH3\u{a}")))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".rtx/i\u{a}")))))

; --- START CONSTRAINT ---

(declare-const pre_lf String)
(declare-const post_lf String)
(declare-const seg0 String)
(declare-const seg1 String)

(assert (= (str.num_splits X "\u{a}") 2))
(assert (= pre_lf (str.split_at X "\u{a}" 0)))
(assert (= post_lf (str.split_at X "\u{a}" 1)))
(assert (= post_lf ""))

(assert (= seg0 (str.split_at pre_lf "/" 0)))
(assert (= seg1 (str.split_at pre_lf "/" 1)))
(assert (= seg0 ""))
(assert (= seg1 "newsurfer4"))
(assert (>= (str.num_splits pre_lf "/") 2))

(assert (not (str.contains pre_lf "/filename=")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
