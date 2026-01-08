(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "encoder") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "cyber@yahoo.comcu\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".mppl/i\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".ogg/i\u{a}")))))
(assert (not (str.in_re X (re.++ (re.opt (str.to_re "$")) (re.union (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (str.to_re ",")) (re.* (re.++ ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (str.to_re ",")))) ((_ re.loop 3 3) (re.range "0" "9")) (re.opt (re.++ (str.to_re ".") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.++ ((_ re.loop 1 3) (re.range "0" "9")) (re.opt (re.++ (str.to_re ".") ((_ re.loop 0 2) (re.range "0" "9"))))) (re.++ (str.to_re ".") ((_ re.loop 1 2) (re.range "0" "9")))) (str.to_re "\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "<") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.+ (re.comp (str.to_re ">"))) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re ">\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter ":"))
(assert (= segment0 (str.split_at X delimiter 0)))
(assert (= segment1 (str.split_at X delimiter 1)))
(assert (= total_segments (str.num_splits X delimiter)))
(assert (>= total_segments 2))
(assert (str.contains segment0 "encoder"))
(assert (str.contains segment1 "cyber"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
