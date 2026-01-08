(set-logic ALL)
(declare-const key String)
(assert (str.in_re key (re.+ (re.range "O" "c"))))
(assert (<= 12 (str.to_int key)))
(assert (>= 26 (str.len key)))

; --- START CONSTRAINT ---

(declare-const d String)
(declare-const s0 String)
(declare-const s1 String)

(assert (= d "O"))
(assert (= s0 (str.split_at key d 0)))
(assert (= s1 (str.split_at key d 1)))
(assert (>= (str.num_splits key d) 2))
(assert (= (str.++ s0 d (str.split_rest key d 1)) key))
(assert (= s0 ""))
(assert (<= 12 (str.len s1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
