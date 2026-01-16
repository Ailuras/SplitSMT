(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "/USER ") (re.union (str.to_re "XP") (str.to_re "98") (str.to_re "95") (str.to_re "NT") (str.to_re "ME") (str.to_re "WIN") (str.to_re "2K3")) (str.to_re "-") (re.+ (re.range "0" "9")) (str.to_re " * 0 :/mi\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for split results
(declare-const delimiter String)
(declare-const first_segment String)
(declare-const second_segment String)
; Set delimiter to space for splitting
(assert (= delimiter " "))
; Split X by space and get segments
(assert (= first_segment (str.split_at X delimiter 0)))
(assert (= second_segment (str.split_at X delimiter 1)))
; Ensure at least two segments exist
(assert (>= (str.num_splits X delimiter) 2))
; Additional constraint: first segment should start with "/USER"
(assert (str.prefixof "/USER" first_segment))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
