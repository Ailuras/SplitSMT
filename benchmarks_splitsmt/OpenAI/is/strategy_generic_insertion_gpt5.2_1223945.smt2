(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "frame_ver2") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "www.urlblaze.net") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "source=IncrediFind") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "AgentHost:Host:Host:/GRSpynova3AFrom:\u{a}"))))
(assert (str.in_re X (re.++ (re.union (re.++ (re.opt (re.range "0" "1")) (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3"))) (str.to_re ":\u{a}") (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re X (re.++ (str.to_re "//AES") (re.+ (re.range "0" "9")) (str.to_re "O") (re.+ (re.range "0" "9")) (str.to_re ".jsp?") ((_ re.loop 20 20) (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "=") (str.to_re "+") (str.to_re "/"))) (str.to_re "/iU\u{a}"))))
(assert (not (str.in_re X (re.union (re.++ (str.to_re "/Dr") (re.opt (str.to_re "."))) (re.++ (str.to_re "Phd") (re.opt (str.to_re "."))) (str.to_re "MBA/i\u{a}")))))

; --- START CONSTRAINT ---

(declare-const pre_jsp String)
(declare-const query_and_tail String)
(declare-const after_colon_nl String)

(assert (>= (str.len X) 0))

; Split around the ".jsp?" marker present in one of the regexes
(assert (>= (str.num_splits X ".jsp?") 2))
(assert (= pre_jsp (str.split_at X ".jsp?" 0)))
(assert (= query_and_tail (str.split_rest X ".jsp?" 1)))

; Split around the ":\n" marker present in one of the regexes
(assert (>= (str.num_splits X ":\u{a}") 2))
(assert (= after_colon_nl (str.split_rest X ":\u{a}" 1)))
(assert (>= (str.len after_colon_nl) 0))

; Exclude the forbidden pattern using split components as well
(assert (not (str.contains pre_jsp "/Dr")))
(assert (not (str.contains pre_jsp "Phd")))
(assert (not (str.contains pre_jsp "MBA/i\u{a}")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
