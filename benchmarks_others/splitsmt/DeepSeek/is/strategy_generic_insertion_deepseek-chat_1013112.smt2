(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (re.* (str.to_re " ")) (re.* (str.to_re " ")) (re.* (re.++ (str.to_re ";") (re.* (str.to_re " ")) (re.* (str.to_re " ")) (str.to_re "@.") ((_ re.loop 2 3) (re.range "a" "z")) (re.union (re.range "a" "z") (re.range "0" "9")) ((_ re.loop 2 2) (re.union (str.to_re ".") (str.to_re "-") (str.to_re "+") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.* (re.union (str.to_re ".") (str.to_re "-") (str.to_re "+") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.+ (re.union (str.to_re ".") (str.to_re "-") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.union (re.range "a" "z") (re.range "0" "9")))) (re.* (str.to_re " ")) (str.to_re "\u{a}@.") ((_ re.loop 2 3) (re.range "a" "z")) (re.union (re.range "a" "z") (re.range "0" "9")) ((_ re.loop 2 2) (re.union (str.to_re ".") (str.to_re "-") (str.to_re "+") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.* (re.union (str.to_re ".") (str.to_re "-") (str.to_re "+") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.+ (re.union (str.to_re ".") (str.to_re "-") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.union (re.range "a" "z") (re.range "0" "9")))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for splitting X by ";"
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert delimiter is ";"
(assert (= delimiter ";"))
; Assert total_segments is the number of splits of X by delimiter
(assert (= total_segments (str.num_splits X delimiter)))
; Assert segment0 is the first segment after splitting X by delimiter
(assert (= segment0 (str.split_at X delimiter 0)))
; Assert segment1 is the second segment after splitting X by delimiter
(assert (= segment1 (str.split_at X delimiter 1)))
; Assert that there are at least 2 segments to ensure segment1 is valid
(assert (>= total_segments 2))
; Assert that the rest after the first segment (from index 1) is non-empty
(assert (not (= (str.split_rest X delimiter 1) "")))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
