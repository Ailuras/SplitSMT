(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "<") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (re.* (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.union (re.++ (re.+ (re.union (str.to_re "-") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "=\u{22}") (re.* (re.comp (str.to_re "\u{22}"))) (str.to_re "\u{22}")) (re.++ (re.+ (re.union (str.to_re "-") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "='") (re.* (re.comp (str.to_re "'"))) (str.to_re "'")) (re.++ (re.+ (re.union (str.to_re "-") (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "=") (re.+ (re.union (str.to_re "'") (str.to_re "\u{22}") (str.to_re "<") (str.to_re ">") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))))))) (str.to_re ">\u{a}") (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.opt (str.to_re "/")) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (re.opt (str.to_re "/")) (re.* (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))))))
(assert (not (str.in_re X (re.++ (str.to_re "/") (re.union (str.to_re "\u{19}\u{0}") (str.to_re "\u{0}\u{5c}")) (str.to_re "\u{0}s\u{0}p\u{0}f\u{0}r\u{0}a\u{0}m\u{0}e\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")))))
(assert (str.in_re X (re.++ (re.+ (re.union (str.to_re "\u{9}") (str.to_re " "))) (str.to_re "\u{a}"))))
(assert (str.in_re X (re.++ (str.to_re "<!--") (re.* (re.union (re.range "0" "9") (re.comp (re.range "0" "9")))) (str.to_re "-->\u{a}"))))

; --- START CONSTRAINT ---
; Declare interface functions for str_split
; Declare new variables for constraints
(declare-const delim1 String)
(declare-const delim2 String)
(declare-const delim3 String)
(declare-const delim4 String)
(declare-const delim5 String)
; Assert constraints using str_split operations
(assert (= delim1 " "))
(assert (= delim2 "\u{a}"))
(assert (= delim3 "<!--"))
(assert (= delim4 "-->"))
(assert (= delim5 "="))
(assert (>= (num_splits X delim1) 2))
(assert (>= (num_splits X delim2) 1))
(assert (>= (num_splits X delim3) 1))
(assert (>= (num_splits X delim4) 1))
(assert (>= (num_splits X delim5) 1))
(assert (= (split_at X delim1 0) ""))
(assert (= (split_at X delim2 0) (str.substr X 0 (str.indexof X delim2 0))))
(assert (= (split_at X delim3 0) ""))
(assert (= (split_at X delim4 0) (str.substr X 0 (str.indexof X delim4 0))))
(assert (= (split_at X delim5 0) (str.substr X 0 (str.indexof X delim5 0))))
(assert (= (split_rest X delim1 1) (str.substr X (+ (str.indexof X delim1 0) 1) (- (str.len X) (+ (str.indexof X delim1 0) 1)))))
(assert (= (split_rest X delim2 1) (str.substr X (+ (str.indexof X delim2 0) 1) (- (str.len X) (+ (str.indexof X delim2 0) 1)))))
(assert (= (split_rest X delim3 1) (str.substr X (+ (str.indexof X delim3 0) 4) (- (str.len X) (+ (str.indexof X delim3 0) 4)))))
(assert (= (split_rest X delim4 1) (str.substr X (+ (str.indexof X delim4 0) 3) (- (str.len X) (+ (str.indexof X delim4 0) 3)))))
(assert (= (split_rest X delim5 1) (str.substr X (+ (str.indexof X delim5 0) 1) (- (str.len X) (+ (str.indexof X delim5 0) 1)))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
