(set-logic ALL)
(declare-fun T () String)
(declare-fun U () String)
(declare-fun V () String)
(declare-fun W () String)
(declare-fun X () String)
(assert
    (and
        (not (str.contains (str.++ T U V W X T) (str.++ W V U T)))
        (str.in_re T (re.* (str.to_re "a")))
        (str.in_re U (re.* (str.to_re "a")))
        (str.in_re V (re.* (str.to_re "a")))
        (str.in_re W (re.* (str.to_re "a")))
        (str.in_re X (re.* (str.to_re "a")))
    )
)

; --- START CONSTRAINT ---
(declare-const delimiter String)
(assert (= delimiter "a"))
(assert (>= (str.num_splits T delimiter) 1))
(assert (= (str.split_at T delimiter 0) T))
(assert (>= (str.num_splits (str.++ T U V W X T) delimiter) 3))
(assert (= (str.split_at (str.++ T U V W X T) delimiter 1) U))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
