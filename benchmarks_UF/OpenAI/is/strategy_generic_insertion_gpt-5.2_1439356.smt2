(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (str.to_re "subject:node=LoginNSIS_DOWNLOAD\u{a}")))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const prefix String)
(declare-const payload String)

(assert (= prefix (split_at X "node=" 0)))
(assert (= payload (split_at X "node=" 1)))
(assert (>= (num_splits X "node=") 2))

(assert (= prefix "subject:"))
(assert (str.contains payload "LoginNSIS_DOWNLOAD"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]