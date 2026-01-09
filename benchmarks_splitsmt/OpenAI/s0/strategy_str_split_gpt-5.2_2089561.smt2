(set-logic ALL)

; Uninterpreted interface for split

; Inputs
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sub1 String)
(declare-const sub2 String)
(declare-const local2 String)
(declare-const domain2 String)
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)

; Helper regexes (pure SMT regex, no extra functions)
(declare-const re_alnum RegLan)
(declare-const re_label_char RegLan)
(declare-const re_local_char RegLan)
(declare-const re_label RegLan)
(declare-const re_local RegLan)
(declare-const re_tld RegLan)

(assert (= re_alnum (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9")))))
(assert (= re_label_char (re.union re_alnum (re.union (str.to_re "-") (str.to_re "_")))))
(assert (= re_local_char (re.union re_label_char (re.union (str.to_re ".") (re.union (str.to_re "+") (str.to_re "%"))))))
(assert (= re_label (re.++ re_alnum (re.* re_label_char))) )
(assert (= re_local (re.++ re_alnum (re.* re_local_char))) )
(assert (= re_tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))) )

; =====================
; SAT instance: a complex but valid email
; =====================

; Exactly one '@'
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Local-part constraints: non-empty, allowed character pattern, no leading/trailing '.'
(assert (>= (str.len local) 1))
(assert (str.in_re local re_local))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; Domain constraints: must have at least 3 labels (e.g., sub1.sub2.tld)
(assert (>= (str.num_splits domain ".") 3))
(assert (= sub1 (str.split_at domain "." 0)))
(assert (= sub2 (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Each label non-empty and label-pattern
(assert (>= (str.len sub1) 1))
(assert (>= (str.len sub2) 1))
(assert (str.in_re sub1 re_label))
(assert (str.in_re sub2 re_label))

; TLD: at least 2 lowercase letters
(assert (>= (str.len tld) 2))
(assert (str.in_re tld re_tld))

; No empty labels in domain (no ".."), and no leading/trailing '.'
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Constructive example to ensure satisfiable
(assert (= email "john.doe+tag%42@sub_mail.example.co"))

(check-sat)

; =====================
; SAT instance: simpler valid email with different structure
; =====================

(assert (= (str.num_splits (str.++ local2 "@" domain2) "@") 2))
(assert (= local2 (str.split_at (str.++ local2 "@" domain2) "@" 0)))
(assert (= domain2 (str.split_at (str.++ local2 "@" domain2) "@" 1)))

(assert (>= (str.len local2) 1))
(assert (str.in_re local2 re_local))
(assert (not (str.contains local2 "..")))
(assert (not (= (str.at local2 0) ".")))
(assert (not (= (str.at local2 (- (str.len local2) 1)) ".")))

(assert (>= (str.num_splits domain2 ".") 2))
(assert (= bad_tld (str.split_at domain2 "." (- (str.num_splits domain2 ".") 1))))
(assert (>= (str.len bad_tld) 2))
(assert (str.in_re bad_tld re_tld))
(assert (not (str.contains domain2 "..")))
(assert (not (= (str.at domain2 0) ".")))
(assert (not (= (str.at domain2 (- (str.len domain2) 1)) ".")))

; Concrete SAT witness
(assert (= local2 "a_b-9"))
(assert (= domain2 "example.org"))

(check-sat)

; =====================
; UNSAT instance: contradictory email requirements
; =====================

; Exactly one '@' but also contains none -> contradiction via split semantics constraints we impose
(assert (= (str.num_splits bad_email "@") 2))
(assert (not (str.contains bad_email "@")))

; Still attempt to extract parts and constrain them
(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))

; Domain must have a dot and TLD >= 2
(assert (>= (str.num_splits bad_domain ".") 2))
(assert (= bad_tld (str.split_at bad_domain "." (- (str.num_splits bad_domain ".") 1))))
(assert (>= (str.len bad_tld) 2))

; Local cannot start with '.' but also must start with '.' -> contradiction
(assert (>= (str.len bad_local) 1))
(assert (not (= (str.at bad_local 0) ".")))
(assert (= (str.at bad_local 0) "."))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
