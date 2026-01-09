(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "wowokay") (re.+ (re.range "0" "9")) (str.to_re "FTP") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:Filtered\u{22}reaction.txt\u{22}\u{a}")))))
(assert (not (str.in_re X (str.to_re "clvompycem/cen.vcnHost:User-Agent:\u{d}\u{a}\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".jfif/i\u{a}")))))

; --- START CONSTRAINT ---
; Declare interface function signatures for str_split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter "://"))
(assert (= segment0 (split_at X delimiter 0)))
(assert (= segment1 (split_at X delimiter 1)))
(assert (= total_segments (num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (str.contains segment0 "wowokay"))
(assert (str.contains segment1 "FTP"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
