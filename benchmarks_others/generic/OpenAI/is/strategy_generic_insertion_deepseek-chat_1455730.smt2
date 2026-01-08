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
; str_split interface function signatures
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; New helper variables
(declare-fun S () String)
(declare-fun seg0 () String)
(declare-fun seg1 () String)

; Define a concrete string built from existing variables and constrain splitting by delimiter "a"
(assert (= S (str.++ T U V W X T)))
(assert (>= (num_splits S "a") 1))
(assert (= seg0 (split_at S "a" 0)))
(assert (= seg1 (split_at S "a" 1)))
(assert (= (split_rest S "a" 1) (str.++ seg1)))

; Bound indices / lengths in a lightweight way consistent with natural indices
(assert (>= (str.len seg0) 0))
(assert (>= (str.len seg1) 0))

; Impose some non-trivial relation between split segments and existing vars
(assert (str.contains (str.++ seg0 "a" seg1) U))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
