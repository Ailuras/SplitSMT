(set-logic ALL)
(declare-fun literal_5 () String)
(assert (= literal_5 "\u{3c}\u{2f}\u{74}\u{64}\u{3e}\u{3c}\u{74}\u{64}\u{3e}\u{73}\u{68}\u{6f}\u{77}\u{6f}\u{6e}\u{6c}\u{79}\u{26}\u{6e}\u{62}\u{73}\u{70}\u{3b}"))
(assert (str.in_re literal_5 (re.++ (re.* re.allchar) (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const seg0 String)
(declare-const seg1 String)

(assert (>= (num_splits literal_5 "<td>") 2))
(assert (= seg0 (split_at literal_5 "<td>" 0)))
(assert (= seg1 (split_at literal_5 "<td>" 1)))
(assert (= seg0 "</td>"))
(assert (str.contains seg1 "shownonly"))
(assert (= (split_rest literal_5 "<td>" 1) seg1))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]