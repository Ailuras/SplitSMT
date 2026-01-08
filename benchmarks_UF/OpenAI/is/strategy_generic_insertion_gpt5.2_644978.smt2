(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.+ (re.++ (re.+ (str.to_re "S")) (str.to_re "b")))))
(assert (str.in_re y (re.+ (re.++ (re.+ (str.to_re ".")) (str.to_re "N")))))
(assert (not (= x y)))
(assert (= (str.len x) (str.to_int y)))

; --- START CONSTRAINT ---

(declare-const dx String)
(declare-const dy String)

(assert (= dx "b"))
(assert (= dy "N"))

(assert (>= (num_splits x dx) 1))
(assert (>= (num_splits y dy) 1))

(assert (= (split_at x dx 0) (str.replace x dx "")))
(assert (= (split_at y dy 0) (str.replace y dy "")))

(assert (= (split_rest x dx 0) x))
(assert (= (split_rest y dy 0) y))

(assert (>= (str.len (split_at x dx 0)) 1))
(assert (>= (str.len (split_at y dy 0)) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
