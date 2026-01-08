(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "www.cameup.com\u{13}") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "spyblini.ini\u{a}"))))
(assert (str.in_re X (str.to_re "presentsearch.netLocalHost:PORT=WatchDogHost:\u{a}")))

; --- START CONSTRAINT ---

(declare-const firstLine String)
(declare-const afterFirstLF String)

(assert (>= (str.num_splits X "\u{a}") 2))
(assert (= firstLine (str.split_at X "\u{a}" 0)))
(assert (= afterFirstLF (str.split_rest X "\u{a}" 1)))
(assert (str.contains firstLine "LocalHost:PORT=WatchDogHost:"))
(assert (str.contains afterFirstLF "www.cameup.com\u{13}"))
(assert (str.contains afterFirstLF "spyblini.ini"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
