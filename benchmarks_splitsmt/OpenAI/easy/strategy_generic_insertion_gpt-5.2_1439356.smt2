(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "subject:node=LoginNSIS_DOWNLOAD\u{a}")))

; --- START CONSTRAINT ---

(declare-const prefix String)
(declare-const payload String)

(assert (= prefix (str.split_at X "node=" 0)))
(assert (= payload (str.split_at X "node=" 1)))
(assert (>= (str.num_splits X "node=") 2))

(assert (= prefix "subject:"))
(assert (str.contains payload "LoginNSIS_DOWNLOAD"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
