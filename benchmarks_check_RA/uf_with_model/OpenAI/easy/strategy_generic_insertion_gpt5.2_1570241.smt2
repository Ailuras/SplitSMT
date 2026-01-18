(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "ServerToolbar\u{a}")))))
(assert (not (str.in_re X (re.++ (re.* (re.union (str.to_re "(") (str.to_re ")") (re.range "+" ".") (re.range "0" "9"))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---

(declare-const hostLine String)
(declare-const hostValue String)

(assert (>= (num_splits X "Host:") 1))
(assert (= hostLine (split_rest X "Host:" 1)))
(assert (>= (str.len hostLine) 0))

(assert (>= (num_splits hostLine "\u{a}") 1))
(assert (= hostValue (split_at hostLine "\u{a}" 0)))

(assert (>= (str.len hostValue) 0))
(assert (not (str.contains hostValue "ServerToolbar")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
