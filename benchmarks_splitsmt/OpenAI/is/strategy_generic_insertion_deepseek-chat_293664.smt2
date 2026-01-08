(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (str.to_re "$Qd' ''"))))
(assert (str.in_re x (re.* (str.to_re "'O74&89b'"))))
(assert (str.in_re x (re.+ (str.to_re "!75:~_|'\x0c'1!KAFA'\n';'\r'S}*u1b'5e?-<Dd"))))
(assert (> (str.to_int x) 2))

; --- START CONSTRAINT ---
(declare-const d String)
(declare-const k Int)
(declare-const seg0 String)
(declare-const rest1 String)
(assert (= d "'"))
(assert (>= k 0))
(assert (< k (str.num_splits x d)))
(assert (>= (str.num_splits x d) 1))
(assert (= seg0 (str.split_at x d 0)))
(assert (= rest1 (str.split_rest x d 1)))
(assert (= x (str.++ seg0 (str.++ d rest1))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
