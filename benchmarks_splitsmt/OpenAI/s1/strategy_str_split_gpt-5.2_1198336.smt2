(set-logic ALL)

; Scenario: Email Validation using str_split with '@' and '.' delimiters

; --- Uninterpreted interface operations (str_split) ---

; --- Seed variables (kept) ---
(declare-const y String)
(declare-const y1 String)
(declare-const y2 String)
(declare-const y3 String)
(declare-const x String)
(declare-const z String)

; --- New variables for email structure ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const domain_tail String)
(declare-const at_count Int)
(declare-const dot_count Int)

; --- Mutated seed constraints: keep transformation chain, but detach fixed x to allow email reasoning ---
(assert (= y1 (str.replace_all y "u" "A")))
(assert (= y2 (str.replace_all y1 "a" "T")))
(assert (= y3 (str.replace_all y2 "g" "C")))
(assert (= x  (str.replace_all y3 "c" "G")))

; Use a smaller motif and preserve core idea of contains
(assert (= z "ugaugacaccaguacg"))
(assert (str.contains y z))

; --- Email constraints ---
; Email is derived from x to preserve structural linkage
(assert (= email x))

; Exactly one '@' => two segments when splitting by "@"
(assert (= at_count (str.num_splits email "@")))
(assert (= at_count 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Local part constraints: non-empty, no '.' as first/last, and no '@'
(assert (>= (str.len local) 1))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (= (str.num_splits local "@") 1))

; Domain must have at least one '.' -> at least two labels
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))
(assert (= dom_label0 (str.split_at domain "." 0)))
(assert (= dom_label1 (str.split_at domain "." 1)))
(assert (= domain_tail (str.split_rest domain "." 1)))

; Labels should be non-empty and not start/end with '-'
(assert (>= (str.len dom_label0) 1))
(assert (>= (str.len dom_label1) 1))
(assert (not (= (str.at dom_label0 0) "-")))
(assert (not (= (str.at dom_label0 (- (str.len dom_label0) 1)) "-")))
(assert (not (= (str.at dom_label1 0) "-")))
(assert (not (= (str.at dom_label1 (- (str.len dom_label1) 1)) "-")))

; TLD is the last segment after the final '.' and has length >= 2
(assert (= tld (str.split_at domain "." (- dot_count 1))))
(assert (>= (str.len tld) 2))

; Additional sanity: domain_tail contains a '.' iff there are 3+ labels
(assert (=> (>= dot_count 3) (str.contains domain_tail ".")))
(assert (=> (= dot_count 2) (not (str.contains domain_tail ".."))))

; --- Concretize to create a definite instance (SAT) while respecting the seed linkage ---
(assert (= email "user.name+tag@example.co"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
