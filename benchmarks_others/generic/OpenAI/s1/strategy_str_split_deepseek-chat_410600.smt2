(set-logic ALL)

; Email Validation scenario using str_split with '@' and '.' delimiters

; Non-primitive interface operations (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables (mutated from seed)
(declare-const value2 String) ; email candidate
(declare-const key2 String)   ; header-like key retained from seed

; Derived segments
(declare-const local_part String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)

; Keep some seed-flavor constraints but adapt meaningfully
(assert (not (= (ite (= key2 "cache-control") 1 0) 0)))
(assert (not (not (= (ite (str.contains value2 "@") 1 0) 0))))
(assert (not (not (= (ite (= (str.len value2) 0) 1 0) 0))))

; Email must contain exactly one '@' => split count exactly 2
(assert (= (num_splits value2 "@") 2))
(assert (= local_part (split_at value2 "@" 0)))
(assert (= domain (split_at value2 "@" 1)))

; Basic local-part constraints
(assert (> (str.len local_part) 0))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "@")))
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain constraints: at least one '.' producing at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len first_label) 0))
(assert (> (str.len tld) 1))
(assert (<= (str.len tld) 63))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Preserve index/substring structure from seed but adapted to '@'
(assert (not (= (ite (= (str.indexof value2 "@" 0) (- 1)) 1 0) 0)))
(assert (>= (+ (str.indexof value2 "@" 0) 1) 0))
(assert (>= (- (str.len value2) (+ (str.indexof value2 "@" 0) 1)) 0))
(assert (not (not (not (= (ite (str.contains (str.substr value2 (+ (str.indexof value2 "@" 0) 1) (- (str.len value2) (+ (str.indexof value2 "@" 0) 1))) ".") 1 0) 0)))))

; SAT branch: a concrete satisfying email
(push 1)
(assert (= value2 "alice.smith+tag@sub.example.com"))
(check-sat)
(pop 1)

; UNSAT branch: violate single-@ constraint and also domain structure
(push 1)
(assert (= value2 "bob@@example"))
(assert (= (num_splits value2 "@") 2))
(check-sat)
(pop 1)



; [GENERATION STATUS: SUCCESS]
(check-sat)
