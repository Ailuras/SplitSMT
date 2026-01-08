(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "Toolbar") (re.* re.allchar) (str.to_re "www.webcruiser.cc") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "www.topadwarereviews.com\u{a}"))))
(assert (not (str.in_re X (re.++ (re.union (str.to_re "0") (str.to_re "+33")) (re.range "1" "9") ((_ re.loop 4 4) (re.++ (re.opt (re.union (str.to_re "-") (str.to_re ".") (str.to_re " "))) ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "Information") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:") (re.* re.allchar) (str.to_re "com\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "/.getElement") (re.opt (str.to_re "s")) (str.to_re "By") (re.union (str.to_re "Id") (str.to_re "TagName")) (str.to_re "(") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (str.to_re "\u{22}") (str.to_re "'")) (str.to_re "caption") (re.union (str.to_re "\u{22}") (str.to_re "'")) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ")") (re.* re.allchar) (str.to_re "innerHTML") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "=") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (str.to_re "\u{22}") (str.to_re "'")) (str.to_re "<thead/sm\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "wjpropqmlpohj/lo") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "media.dxcdirect.com\u{a}"))))

; --- START CONSTRAINT ---

(declare-const seg0 String)
(declare-const seg1 String)
(declare-const seg2 String)
(declare-const after_newline String)

(assert (>= (str.num_splits X "\u{a}") 2))
(assert (= seg0 (str.split_at X "\u{a}" 0)))
(assert (= after_newline (str.split_rest X "\u{a}" 1)))
(assert (= seg1 (str.split_at X "\u{a}" 1)))

(assert (>= (str.num_splits seg0 "www.") 2))
(assert (= seg2 (str.split_at seg0 "www." 1)))

(assert (str.contains X "www."))
(assert (str.contains seg0 "Toolbar"))
(assert (str.contains after_newline "media.dxcdirect.com"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
