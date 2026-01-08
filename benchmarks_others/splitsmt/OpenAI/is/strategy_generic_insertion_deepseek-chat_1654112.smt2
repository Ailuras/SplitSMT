(set-logic ALL)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.* (str.to_re "'M`1US_")))))
(assert (str.in_re y (re.+ (str.to_re "A."))))
(assert (= (str.to_int x) 4))
(assert (= 10 (str.len y)))

; --- START CONSTRAINT ---

(declare-const x_seg0 String)
(declare-const y_seg0 String)
(declare-const y_seg1 String)

(assert (>= (str.num_splits x "`") 2))
(assert (= x_seg0 (str.split_at x "`" 0)))
(assert (= (str.split_rest x "`" 1) "1US_"))

(assert (= 2 (str.num_splits y ".")))
(assert (= y_seg0 (str.split_at y "." 0)))
(assert (= y_seg1 (str.split_at y "." 1)))
(assert (= y_seg0 "A"))
(assert (= y_seg1 ""))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
