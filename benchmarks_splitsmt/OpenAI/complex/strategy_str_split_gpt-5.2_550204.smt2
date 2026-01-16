(set-logic ALL)

; Uninterpreted interface functions for str_split

; Variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; Preserve seed core structure but mutate from fixed literal to email validation
(assert (= T_1 (= email "Search")))

; Email split around '@'
(assert (= at_count (str.num_splits email "@")))
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= (str.split_rest email "@" 1) domain))

; Basic sanity constraints
(assert (>= at_count 2))
(assert (<= at_count 2))
(assert (= local_len (str.len local_part)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 0))

; Domain must have at least one '.' and exactly two labels (label.tld)
(assert (= dot_count (str.num_splits domain ".")))
(assert (>= dot_count 2))
(assert (<= dot_count 2))
(assert (= domain_label0 (str.split_at domain "." 0)))
(assert (= domain_label1 (str.split_at domain "." 1)))
(assert (= tld domain_label1))
(assert (= (str.split_rest domain "." 1) domain_label1))
(assert (> (str.len domain_label0) 0))
(assert (>= (str.len tld) 2))

; Common email format restrictions (syntactic)
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain "@")))

; Delimiter placement: local-part cannot start/end with '.'
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; Domain label cannot start/end with '-'
(assert (not (= (str.at domain_label0 0) "-")))
(assert (not (= (str.at domain_label0 (- (str.len domain_label0) 1)) "-")))

; Tie to seed Boolean and add a second Boolean that makes the instance UNSAT
; If T_1 holds then email is exactly "Search", which cannot satisfy having exactly one '@'
(assert T_1)
(assert (= T_2 (and (= at_count 2) (= dot_count 2))))
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
