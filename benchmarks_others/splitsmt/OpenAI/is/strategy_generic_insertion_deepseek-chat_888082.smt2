(set-logic ALL)
(declare-fun literal_5 () String)
(assert (= literal_5 "\u{3c}\u{2f}\u{74}\u{64}\u{3e}\u{3c}\u{74}\u{64}\u{3e}\u{5c}\u{6e}\u{6c}\u{6f}\u{6f}\u{6b}\u{62}\u{61}\u{63}\u{6b}\u{26}\u{6e}\u{62}\u{73}\u{70}\u{3b}"))
(assert (str.in_re literal_5 (re.++ (re.* re.allchar) (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- START CONSTRAINT ---

(declare-fun seg0 () String)
(declare-fun seg1 () String)
(declare-fun rest1 () String)

(assert (>= (str.num_splits literal_5 "\\") 2))
(assert (= seg0 (str.split_at literal_5 "\\" 0)))
(assert (= seg1 (str.split_at literal_5 "\\" 1)))
(assert (= rest1 (str.split_rest literal_5 "\\" 1)))

; ensure the split actually occurs and the first delimiter is a backslash
(assert (str.prefixof "\\" (str.substr literal_5 (str.len seg0) 1)))

; the substring right after the first backslash begins with '<'
(assert (str.prefixof "<" seg1))

; from segment 1 onward, it contains the token "<SCRIPT" (case sensitive)
(assert (str.contains rest1 "<SCRIPT"))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
