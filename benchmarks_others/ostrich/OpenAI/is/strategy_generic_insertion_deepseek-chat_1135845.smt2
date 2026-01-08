(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "com") (re.range "0" "9") (str.to_re "search.conduit.com") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "User-Agent:\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "}{Trojan:") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "by") (re.+ (re.range "0" "9")) (str.to_re "to") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "dddlogin.dudu.comSurveillance\u{13}IPOblivion\u{a}"))))
(assert (str.in_re X (str.to_re "PortaUser-Agent:Host:\u{a}")))
(assert (not (str.in_re X (re.++ (str.to_re "01") ((_ re.loop 1 1) (re.range "0" "2")) ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".m4b/i\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

(declare-const ua_line String)
(declare-const after_ua String)

; Ensure X contains a "User-Agent:" line and relate pieces via split functions
(assert (>= (num_splits X "User-Agent:") 2))
(assert (= ua_line (split_at X "User-Agent:" 1)))
(assert (= after_ua (split_rest X "User-Agent:" 1)))
(assert (str.contains after_ua "User-Agent:"))

; The suffix from the second occurrence onward should equal the remainder after splitting again
(assert (= (split_rest after_ua "User-Agent:" 1) (split_rest X "User-Agent:" 2)))

; Indices used are natural
(assert (>= (num_splits X "User-Agent:") 0))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
