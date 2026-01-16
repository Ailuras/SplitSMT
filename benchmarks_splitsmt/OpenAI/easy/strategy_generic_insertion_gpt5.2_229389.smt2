(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.opt (re.++ (re.opt (str.to_re "+")) ((_ re.loop 1 2) (re.range "0" "9")) (re.opt (re.union (str.to_re " ") (str.to_re "-"))))) (re.opt (re.union (re.++ (str.to_re "(") (re.opt (str.to_re "+")) ((_ re.loop 2 3) (re.range "0" "9")) (str.to_re ")")) (re.++ (re.opt (str.to_re "+")) ((_ re.loop 2 3) (re.range "0" "9"))))) (re.opt (re.union (str.to_re " ") (str.to_re "-"))) ((_ re.loop 3 4) (re.range "0" "9")) (re.opt (re.union (str.to_re " ") (str.to_re "-"))) ((_ re.loop 3 4) (re.range "0" "9")) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---

(declare-const X_line String)
(declare-const X_body String)

(assert (= X_line (str.split_at X "\u{a}" 0)))
(assert (= X_body (str.split_rest X "\u{a}" 1)))
(assert (= (str.num_splits X "\u{a}") 2))
(assert (= X_body ""))

(assert (>= (str.num_splits X_line "-") 1))
(assert (>= (str.num_splits X_line " ") 1))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
