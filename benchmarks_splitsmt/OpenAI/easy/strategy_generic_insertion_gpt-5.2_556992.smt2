(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "RequestWindowszzzvmkituktgr/etieencoder\u{a}"))))

; --- START CONSTRAINT ---

(declare-const delim String)
(declare-const k Int)
(declare-const seg0 String)
(declare-const rest0 String)

(assert (= delim "/"))
(assert (= k 0))
(assert (>= (str.len X) 0))
(assert (>= (str.num_splits X delim) 1))
(assert (= seg0 (str.split_at X delim k)))
(assert (= rest0 (str.split_rest X delim k)))
(assert (= (str.++ seg0 rest0) X))
(assert (or (= seg0 "") (not (str.contains seg0 delim))))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
