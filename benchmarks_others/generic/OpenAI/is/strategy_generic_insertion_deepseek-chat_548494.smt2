(set-logic ALL)
(declare-const key String)
(assert (str.in_re key (re.+ (re.range "O" "c"))))
(assert (<= 12 (str.to_int key)))
(assert (>= 26 (str.len key)))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const d String)
(declare-const s0 String)
(declare-const s1 String)

(assert (= d "O"))
(assert (= s0 (split_at key d 0)))
(assert (= s1 (split_at key d 1)))
(assert (>= (num_splits key d) 2))
(assert (= (str.++ s0 d (split_rest key d 1)) key))
(assert (= s0 ""))
(assert (<= 12 (str.len s1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
