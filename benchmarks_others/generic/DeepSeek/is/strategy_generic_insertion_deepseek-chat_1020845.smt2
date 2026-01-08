(set-logic ALL)
(declare-const x String)
(assert (str.in_re x (re.+ (str.to_re "' '"))))
(assert (= 7 (str.len x)))
(assert (not (= x "%/.KV.:Q")))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
; Declare new variables for split operations
(declare-const delimiter String)
(declare-const segment0 String)
(declare-const segment1 String)
; Assert constraints using str_split operations
(assert (= delimiter " "))
(assert (= segment0 (split_at x delimiter 0)))
(assert (= segment1 (split_at x delimiter 1)))
(assert (>= (num_splits x delimiter) 2))
(assert (str.in_re segment0 (re.+ (str.to_re "' '"))))
(assert (str.in_re segment1 (re.+ (str.to_re "' '"))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
