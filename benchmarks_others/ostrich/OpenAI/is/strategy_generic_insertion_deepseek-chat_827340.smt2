(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re ".aspx") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "www.altnet.com\u{1b}Subject:\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const suffix0 String)
(declare-const suffix1 String)

(assert (= suffix0 (split_at X ".aspx" 0)))
(assert (= suffix1 (split_at X ".aspx" 1)))
(assert (= suffix1 (split_rest X ".aspx" 1)))
(assert (>= (num_splits X ".aspx") 2))
(assert (= (str.++ suffix0 ".aspx" suffix1) X))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
