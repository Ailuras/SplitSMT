(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "dialupvpn_pwd") (re.range "0" "9") (str.to_re "<title>Actual") (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "SpywareStrike") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "fowclxccdxn/uxwn.ddywww.virusprotectpro.com\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "www.ricercadoppia.com") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "TPSystem") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "User-Agent:\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "32e3432e") (re.+ (str.to_re "w")) (str.to_re "\u{a}")))))
(assert (str.in_re X (re.union (re.++ (re.* (re.union (re.range "0" "9") (str.to_re ","))) (re.opt (str.to_re ".")) (re.* (re.range "0" "9")) (re.+ (re.range "1" "9")) (re.* (re.range "0" "9"))) (re.++ (re.+ (re.range "1" "9")) (re.* (re.union (re.range "0" "9") (str.to_re ","))) (str.to_re ".") (re.* (re.range "0" "9"))) (re.++ (str.to_re "\u{a}") (re.+ (re.range "1" "9")) (re.* (re.union (re.range "0" "9") (str.to_re ","))) (re.* (re.range "0" "9"))))))
(assert (not (str.in_re X (re.++ ((_ re.loop 3 3) (re.++ (re.union (re.++ (re.opt (re.union (str.to_re "0") (str.to_re "1"))) (re.opt (re.range "0" "9")) (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9")) (re.++ (str.to_re "25") (re.range "0" "5"))) (str.to_re "."))) (re.union (re.++ (re.opt (re.union (str.to_re "0") (str.to_re "1"))) (re.opt (re.range "0" "9")) (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9")) (re.++ (str.to_re "25") (re.range "0" "5"))) (str.to_re "\u{a}")))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter1 String)
(declare-const delimiter2 String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_splits Int)
; Assert constraints using str_split operations
(assert (= delimiter1 "://"))
(assert (= delimiter2 "\u{a}"))
(assert (= segment0 (split_at X delimiter1 0)))
(assert (>= (num_splits X delimiter1) 2))
(assert (= segment1 (split_at X delimiter1 1)))
(assert (= total_splits (num_splits X delimiter2)))
(assert (>= total_splits 1))
(assert (str.contains (split_rest X delimiter2 0) "www"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)