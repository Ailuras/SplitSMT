(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun value () String)
(declare-fun key () String)
(assert (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (and (not (not (not (= (ite (str.contains (str.substr value 0 (- (str.indexof value " " 0) 0)) "D") 1 0) 0)))) (not (not (= (ite (str.contains (str.substr value 0 (- (str.indexof value " " 0) 0)) "C") 1 0) 0)))) (not (not (= (ite (str.contains (str.substr value 0 (- (str.indexof value " " 0) 0)) "B") 1 0) 0)))) (not (not (= (ite (str.contains (str.substr value 0 (- (str.indexof value " " 0) 0)) "A") 1 0) 0)))) (not (not (= (ite (= (str.len (str.substr value (+ (str.indexof value " " 0) 1) (- (str.len value) (+ (str.indexof value " " 0) 1)))) 0) 1 0) 0)))) (not (= (ite (str.contains value " ") 1 0) 0))) (not (not (= (ite (= (str.len value) 0) 1 0) 0)))) (not (= (ite (not (= (str.len value) 0)) 1 0) 0))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value (- (str.len value) 1)) " ") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) "\u{c}") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) "\u{b}") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) "\u{d}") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) "\u{a}") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) "\u{9}") 1 0) 0)))) (not (not (= (ite (= (str.at value 0) " ") 1 0) 0)))) (not (not (= (ite (= (str.len value) 0) 1 0) 0)))) (not (= (ite (= key "www-authenticate") 1 0) 0))) (not (= (ite (= key "www-authenticate") 1 0) 0))) (>= 0 0)) (>= (- (str.indexof value " " 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof value " " 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof value " " 0) 0) 0)) (>= 0 0)) (>= (- (str.indexof value " " 0) 0) 0)) (>= (+ (str.indexof value " " 0) 1) 0)) (>= (- (str.len value) (+ (str.indexof value " " 0) 1)) 0)))

; --- START CONSTRAINT ---
; str_split interface declarations

; new helper variables
(declare-const scheme String)
(declare-const rest_after_space String)
(declare-const first_token String)

; value must contain exactly one space, splitting into two segments
(assert (= (num_splits value " ") 2))
(assert (= first_token (split_at value " " 0)))
(assert (= rest_after_space (split_at value " " 1)))
(assert (= (split_rest value " " 1) rest_after_space))

; connect to existing constraints: first token is the prefix before the first space
(assert (= first_token (str.substr value 0 (str.indexof value " " 0))))

; scheme is a single letter among A,B,C,D and equals the first token
(assert (= scheme first_token))
(assert (or (= scheme "A") (= scheme "B") (= scheme "C") (= scheme "D")))
(assert (= (str.len scheme) 1))

; rest segment is non-empty (matches existing non-empty suffix constraint)
(assert (> (str.len rest_after_space) 0))
; --- END CONSTRAINT ---


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
