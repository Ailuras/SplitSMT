(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (re.union (re.++ ((_ re.loop 1 1) (re.range "1" "9")) ((_ re.loop 0 2) (re.range "0" "9")) (str.to_re ",") (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (str.to_re ","))) ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ ((_ re.loop 1 1) (re.range "1" "9")) (re.* (re.range "0" "9")))) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "--") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3"))) (str.to_re "::\u{a}") (re.range "0" "1") (re.range "0" "9") (re.range "0" "3") (re.range "0" "9") (re.range "0" "5") (re.range "0" "9") (re.range "0" "5") (re.range "0" "9")))))
(assert (not (str.in_re X (re.++ (re.* (str.to_re " ")) (re.union (re.++ (str.to_re "1") (re.range "0" "2")) (re.range "1" "9")) (str.to_re ":") (re.range "0" "5") (re.range "0" "9") (re.* (str.to_re " ")) (re.union (str.to_re "a") (str.to_re "p") (str.to_re "A") (str.to_re "P")) (re.union (str.to_re "m") (str.to_re "M")) (re.* (str.to_re " ")) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.union (str.to_re "0") (re.++ (str.to_re "\u{a}") (re.range "1" "9") (re.* (re.range "0" "9")))))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const d_nl String)
(declare-const seg0 String)
(declare-const seg1 String)

(assert (= d_nl "\u{a}"))
(assert (= seg0 (split_at X d_nl 0)))
(assert (= seg1 (split_at X d_nl 1)))
(assert (= (split_rest X d_nl 1) seg1))
(assert (>= (num_splits X d_nl) 1))
(assert (<= (num_splits X d_nl) 2))
(assert (= X (ite (= (num_splits X d_nl) 1)
                  seg0
                  (str.++ seg0 d_nl seg1))))
(assert (and (<= 0 (str.len seg0)) (<= (str.len seg0) (str.len X))))
(assert (and (<= 0 (str.len seg1)) (<= (str.len seg1) (str.len X))))
(assert (not (str.contains seg0 "--")))
(assert (not (str.contains seg0 ",")))
(assert (not (str.contains seg0 ":")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
