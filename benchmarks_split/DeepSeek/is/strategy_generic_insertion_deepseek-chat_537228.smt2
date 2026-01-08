(set-logic ALL)
(declare-fun literal_9 () String)
(assert (= literal_9 "\u{3c}\u{64}\u{69}\u{76}\u{20}\u{63}\u{6c}\u{61}\u{73}\u{73}\u{3d}\u{22}\u{66}\u{75}\u{6c}\u{6c}\u{6e}\u{61}\u{6d}\u{65}\u{22}\u{3e}\u{75}\u{73}\u{65}\u{72}\u{3c}\u{2f}\u{64}\u{69}\u{76}\u{3e}"))
(assert (str.in_re literal_9 (re.++ (re.* re.allchar) (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- START CONSTRAINT ---
; Declare interface operations for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split results
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Set delimiter to "<div" for splitting
(assert (= delimiter "<div"))
; Assert total segments after splitting literal_9 by delimiter
(assert (= total_segments (num_splits literal_9 delimiter)))
; Assert that there are at least 2 segments
(assert (>= total_segments 2))
; Assert segment0 is the first segment (index 0)
(assert (= segment0 (split_at literal_9 delimiter 0)))
; Assert segment1 is the second segment (index 1)
(assert (= segment1 (split_at literal_9 delimiter 1)))
; Assert that segment0 does not contain the delimiter
(assert (not (str.contains segment0 delimiter)))
; Assert that segment1 contains the rest of the string after the first delimiter
(assert (= segment1 (split_rest literal_9 delimiter 1)))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)