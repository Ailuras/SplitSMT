(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/") ((_ re.loop 4 4) (re.union (re.range " " "~") (str.to_re "\u{d}") (str.to_re "\u{a}"))) (str.to_re "/P\u{a}")))))

; --- START CONSTRAINT ---

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)

(assert (>= (str.num_splits X "/") 2))
(assert (= seg0 (str.split_at X "/" 0)))
(assert (= seg1 (str.split_at X "/" 1)))
(assert (= rest1 (str.split_rest X "/" 1)))

; ensure the leading segment is empty, i.e., X starts with "/"
(assert (= seg0 ""))

; enforce a structural decomposition of X using the split results
(assert (= X (str.++ "/" rest1)))

; constrain the second segment to be exactly 4 characters long (aligns with the excluded pattern shape)
(assert (= (str.len seg1) 4))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
