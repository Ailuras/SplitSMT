(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Email Validation scenario using str_split and regex

; str_split interface

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const host String)

; Retain seed structure by constraining an auxiliary string with a complex regex
(declare-const var0 String)
(assert (str.in_re var0 (re.++ (re.union (re.union (str.to_re "00") (str.to_re "11")) (re.+ (str.to_re "2"))) (re.++ (re.union (re.union (str.to_re "333") (str.to_re "44")) (re.* (str.to_re "5"))) (re.++ (re.union (re.* (str.to_re "6")) (re.union (str.to_re "77") (str.to_re "88"))) (re.++ (re.+ (re.+ (str.to_re "999"))) (re.++ (re.* (re.+ (str.to_re "aa"))) (re.++ (re.+ (re.+ (str.to_re "bb"))) (re.++ (re.+ (re.* (str.to_re "ccc"))) (re.++ (re.* (re.union (str.to_re "d") (str.to_re "e"))) (re.++ (re.+ (re.+ (str.to_re "f"))) (re.++ (re.* (re.union (str.to_re "g") (str.to_re "h"))) (re.++ (re.+ (re.union (str.to_re "ii") (str.to_re "jj"))) (re.++ (re.* (re.+ (str.to_re "kkk"))) (re.++ (re.* (re.union (str.to_re "ll") (str.to_re "mmm"))) (re.++ (re.* (re.union (str.to_re "nnn") (str.to_re "ooo"))) (re.++ (re.+ (re.* (str.to_re "p"))) (re.++ (re.union (re.* (str.to_re "q")) (re.union (str.to_re "r") (str.to_re "ss"))) (re.++ (re.+ (re.+ (str.to_re "ttt"))) (re.++ (re.+ (re.union (str.to_re "uu") (str.to_re "vv"))) (re.++ (re.* (re.* (str.to_re "www"))) (re.++ (re.union (re.+ (str.to_re "xx")) (re.* (str.to_re "y"))) (re.++ (re.+ (re.+ (str.to_re "z"))) (re.++ (re.* (re.+ (str.to_re "AAA"))) (re.++ (re.union (re.* (str.to_re "B")) (re.union (str.to_re "CCC") (str.to_re "DDD"))) (re.++ (re.* (re.union (str.to_re "EEE") (str.to_re "F"))) (re.+ (re.+ (str.to_re "GG")))))))))))))))))))))))))))))

; Split email into local and domain using '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_rest email "@" 2)))
(assert (= 2 (num_splits email "@")))

; Basic well-formedness
(assert (> (str.len email) 3))
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Domain structure: must have at least one '.' to yield at least two segments
(assert (>= (num_splits domain ".") 2))

; Host is the first label, tld is the last label (assuming exactly 2 segments for simplicity)
(assert (= 2 (num_splits domain ".")))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))
(assert (= "" (split_rest domain "." 2)))

; Non-empty labels
(assert (> (str.len host) 0))
(assert (> (str.len tld) 1))

; Local part must not start or end with '.' and must not contain '@'
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "@")))

; Domain must not contain '@' either
(assert (not (str.contains domain "@")))

; TLD: alphabetic-ish approximation using limited set, and length bound
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.union (str.to_re "com") (str.to_re "org")) (re.* (re.union (str.to_re "net") (str.to_re "io"))))))

; Host: require it to be lowercase letters/hyphen and not start/end with '-'
(declare-const hostFirst String)
(declare-const hostLast String)
(assert (= hostFirst (str.at host 0)))
(assert (= hostLast (str.at host (- (str.len host) 1))))
(assert (not (= hostFirst "-")))
(assert (not (= hostLast "-")))
(assert (str.in_re host (re.++ (re.union (str.to_re "a") (str.to_re "b")) (re.* (re.union (re.union (str.to_re "a") (str.to_re "b")) (str.to_re "-"))))))

; Constructive constraint: email is concatenation of local@domain
(assert (= email (str.++ local "@" domain)))

; Create a deliberate contradiction (UNSAT instance): require local to contain '@' while '@' split says only one '@'
(assert (str.contains local "@"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
