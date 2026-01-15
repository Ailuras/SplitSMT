(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (str.to_re "RequestWindowszzzvmkituktgr/etieencoder\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const delim String)
(declare-const k Int)
(declare-const seg0 String)
(declare-const rest0 String)

(assert (= delim "/"))
(assert (= k 0))
(assert (>= (str.len X) 0))
(assert (>= (num_splits X delim) 1))
(assert (= seg0 (split_at X delim k)))
(assert (= rest0 (split_rest X delim k)))
(assert (= (str.++ seg0 rest0) X))
(assert (or (= seg0 "") (not (str.contains seg0 delim))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
