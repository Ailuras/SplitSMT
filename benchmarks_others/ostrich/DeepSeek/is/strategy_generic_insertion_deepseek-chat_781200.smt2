(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.union (re.range "a" "z") (re.range "A" "Z")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))) (re.* (re.++ (str.to_re ".") (re.union (re.range "a" "z") (re.range "A" "Z")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "//index.php?") ((_ re.loop 15 15) (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))) (str.to_re "=l3S/U\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for split results
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Set delimiter to "?" for splitting query parameters
(assert (= delimiter "?"))
; Assert that X contains the delimiter
(assert (str.contains X delimiter))
; Compute total segments after splitting X by delimiter
(assert (= total_segments (num_splits X delimiter)))
; Ensure at least 2 segments exist (e.g., path and query)
(assert (>= total_segments 2))
; Extract the first segment (path part before "?")
(assert (= segment0 (split_at X delimiter 0)))
; Extract the second segment (query part after "?")
(assert (= segment1 (split_at X delimiter 1)))
; Ensure the first segment ends with "index.php"
(assert (str.suffixof "index.php" segment0))
; Ensure the second segment has length 15 and matches the pattern from the regex
(assert (= (str.len segment1) 15))
(assert (str.in_re segment1 (re.++ ((_ re.loop 15 15) (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))) (str.to_re "=l3S/U"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
