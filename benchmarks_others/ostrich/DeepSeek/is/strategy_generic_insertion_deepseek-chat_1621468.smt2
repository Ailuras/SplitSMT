(set-logic ALL)
(declare-fun sigmaStar_0 () String)
(declare-fun literal_1 () String)
(declare-fun x_2 () String)
(declare-fun literal_3 () String)
(declare-fun x_4 () String)
(assert (= literal_1 "\u{3c}\u{74}\u{72}\u{3e}\u{5c}\u{6e}\u{3c}\u{74}\u{64}\u{20}\u{61}\u{6c}\u{69}\u{67}\u{6e}\u{3d}\u{27}\u{63}\u{65}\u{6e}\u{74}\u{65}\u{72}\u{27}\u{20}\u{63}\u{6f}\u{6c}\u{73}\u{70}\u{61}\u{6e}\u{3d}\u{27}\u{34}\u{27}\u{20}\u{63}\u{6c}\u{61}\u{73}\u{73}\u{3d}\u{27}\u{74}\u{62}\u{6c}\u{31}\u{27}\u{3e}"))
(assert (= x_2 (str.++ literal_1 sigmaStar_0)))
(assert (= literal_3 "\u{3c}\u{2f}\u{74}\u{64}\u{3e}\u{5c}\u{6e}\u{3c}\u{2f}\u{74}\u{72}\u{3e}\u{5c}\u{6e}"))
(assert (= x_4 (str.++ x_2 literal_3)))
(assert (str.in_re x_4 (re.++ (re.* re.allchar) (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
(declare-const total_segments Int)
; Assert constraints using str_split operations
(assert (= delimiter "\\n"))
(assert (= segment0 (split_at x_4 delimiter 0)))
(assert (= segment1 (split_at x_4 delimiter 1)))
(assert (= total_segments (num_splits x_4 delimiter)))
(assert (>= total_segments 2))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
