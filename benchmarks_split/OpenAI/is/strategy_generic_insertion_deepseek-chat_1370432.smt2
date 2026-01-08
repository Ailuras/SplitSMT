(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "on") (re.range "0" "9") (str.to_re "Name=Your+Host+is:cdpViewHost:User-Agent:\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "Uin=") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ".htaServerTheef2trustyfiles.comlogsHost:\u{a}"))))
(assert (str.in_re X (str.to_re "u=with:HBand,Deathhoroscope2\u{a}")))
(assert (not (str.in_re X (re.++ (re.* (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.opt (re.++ ((_ re.loop 0 61) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))) (str.to_re "."))) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.opt (re.++ ((_ re.loop 0 61) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const ua_line String)
(declare-const ua_prefix String)
(declare-const ua_value String)

(assert (>= (num_splits X "User-Agent:\u{a}") 2))
(assert (= ua_line (split_at X "User-Agent:\u{a}" 1)))
(assert (>= (num_splits ua_line "\u{a}") 2))
(assert (= ua_prefix (split_at ua_line "\u{a}" 0)))
(assert (= ua_prefix ""))
(assert (= ua_value (split_at ua_line "\u{a}" 1)))
(assert (not (str.contains ua_value "\u{a}")))
(assert (not (str.contains ua_value "\u{d}")))

(assert (>= (num_splits X "Uin=") 2))
(assert (not (str.contains (split_rest X "Uin=" 1) "Uin=")))

(assert (>= (num_splits X "Host:\u{a}") 2))
(assert (not (str.contains (split_rest X "Host:\u{a}" 1) "Host:\u{a}")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]