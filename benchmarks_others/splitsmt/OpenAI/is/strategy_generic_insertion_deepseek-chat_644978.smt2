(set-logic ALL)
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

(assert (>= (str.num_splits x dx) 1))
(assert (>= (str.num_splits y dy) 1))

(assert (= (str.split_at x dx 0) (str.replace x dx "")))
(assert (= (str.split_at y dy 0) (str.replace y dy "")))

(assert (= (str.split_rest x dx 0) x))
(assert (= (str.split_rest y dy 0) y))

(assert (>= (str.len (str.split_at x dx 0)) 1))
(assert (>= (str.len (str.split_at y dy 0)) 1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
