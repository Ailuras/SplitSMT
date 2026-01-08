(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (re.++ (str.to_re "25") (re.range "0" "5")) (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9")) (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9")) ((_ re.loop 1 2) (re.range "0" "9"))) ((_ re.loop 3 3) (re.++ (str.to_re ".") (re.union (re.++ (str.to_re "25") (re.range "0" "5")) (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9")) (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9")) ((_ re.loop 1 2) (re.range "0" "9"))))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
; str_split interface function signatures
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; New helper variables
(declare-const line0 String)
(declare-const rest_after0 String)

; Constrain X to be splittable by newline into at least 1 segment
(assert (>= (num_splits X "\u{a}") 1))
(assert (= line0 (split_at X "\u{a}" 0)))
(assert (= rest_after0 (split_rest X "\u{a}" 1)))

; Ensure the first segment is non-empty and does not start with a dot
(assert (> (str.len line0) 0))
(assert (not (= (str.at line0 0) ".")))

; If there is more text after the first newline, then the remainder must be non-empty
(assert (=> (>= (num_splits X "\u{a}") 2) (> (str.len rest_after0) 0)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
