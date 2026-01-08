(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "Spy") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "\u{d}\u{a}") (re.* re.allchar) (str.to_re "YAHOOdestroyed!Host:\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const host_line String)

; Split X by LF and constrain the first line to be a Host header-like line
(assert (>= (num_splits X "\u{a}") 1))
(assert (>= (num_splits X "Host:") 2))
(assert (= host_line (split_at X "\u{a}" 0)))
(assert (= (split_at host_line "Host:" 0) ""))
(assert (not (= (split_rest host_line "Host:" 1) "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
