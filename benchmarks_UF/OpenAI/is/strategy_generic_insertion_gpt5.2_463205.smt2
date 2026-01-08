(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "www.cameup.com\u{13}") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "spyblini.ini\u{a}"))))
(assert (str.in_re X (str.to_re "presentsearch.netLocalHost:PORT=WatchDogHost:\u{a}")))

; --- START CONSTRAINT ---

(declare-const port_part String)

(assert (>= (num_splits X ":") 3))
(assert (= port_part (split_at X ":" 2)))
(assert (str.contains port_part "PORT="))
(assert (= (split_at port_part "=" 1) "WatchDogHost"))
(assert (= (split_rest X ":" 0) X))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
