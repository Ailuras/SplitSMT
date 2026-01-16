(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "DmInf^\u{d}\u{a}\u{d}\u{a}Attached/bar_pl/chk.fcgi\u{a}"))))

; --- START CONSTRAINT ---

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const rest1 String)

(assert (>= (str.num_splits X "/") 2))
(assert (= seg0 (str.split_at X "/" 0)))
(assert (= seg1 (str.split_at X "/" 1)))
(assert (= rest1 (str.split_rest X "/" 1)))
(assert (str.contains rest1 "bar_pl"))
(assert (not (str.contains seg0 "Attached")))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
