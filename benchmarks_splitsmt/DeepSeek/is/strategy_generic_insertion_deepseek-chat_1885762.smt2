(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (re.++ (str.to_re "") (str.to_re "1")))))
(assert (= 1 (str.len x)))
(assert (not (= x "BV")))
(assert (not (= x "I'\t'h'C(")))
(assert (not (= x "0^M")))

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter ","))
(assert (>= (str.num_splits x delimiter) 1))
(assert (= (str.split_at x delimiter 0) x))
(assert (= (str.split_rest x delimiter 0) x))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
