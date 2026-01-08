(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.union (re.++ (re.opt (str.to_re "1")) (re.range "1" "2")) (re.range "1" "9") (str.to_re "10\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".m3u/i\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "/.dcr") (re.union (str.to_re "?") (str.to_re "\u{5c}") (str.to_re "/")) (str.to_re "/smiU\u{a}"))))
(assert (str.in_re X (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (str.to_re ".") ((_ re.loop 2 2) (re.range "0" "9")))) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (re.+ re.allchar) (str.to_re ".") (re.union (str.to_re "jpg") (str.to_re "jpeg") (str.to_re "JPG") (str.to_re "JPEG")) (str.to_re "\u{a}"))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const delimiter String)
(assert (= delimiter "/"))
(assert (>= (num_splits X delimiter) 2))
(assert (= (split_at X delimiter 0) ""))
(assert (str.contains (split_at X delimiter 1) "."))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
