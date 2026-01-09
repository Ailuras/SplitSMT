(set-logic ALL)
(declare-fun var0 () String)
(assert (str.in_re var0 (re.+ (re.+ (str.to_re "00")))))
(assert (not (str.in_re var0 (re.* (re.union (str.to_re "000") (str.to_re "1"))))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (num_splits var0 "00") 2))
(assert (= seg0 (split_at var0 "00" 0)))
(assert (= seg1 (split_at var0 "00" 1)))
(assert (= rest1 (split_rest var0 "00" 1)))
(assert (not (str.contains seg0 "1")))
(assert (not (str.contains seg1 "1")))
(assert (not (str.contains rest1 "1")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
