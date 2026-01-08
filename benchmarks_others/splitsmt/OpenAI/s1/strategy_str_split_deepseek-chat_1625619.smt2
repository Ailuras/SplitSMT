(set-logic ALL)

; Email Validation scenario using str_split interface

(declare-fun key1 () String)
(declare-fun value2 () String)
(declare-fun key2 () String)
(declare-fun value1 () String)

(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)

; Preserve some seed structure (cache-control keys) but repurpose values as unrelated headers
(assert (= key1 "cache-control"))
(assert (= key2 "cache-control"))

; Keep a lightweight mutation of the seed idea: value1 contains '=' and ',' (header-like)
(assert (str.contains value1 "="))
(assert (not (= (str.indexof value1 "=" 0) (- 1))))
(assert (str.contains value1 ","))
(assert (> (str.len value1) 3))

; Constrain value2 to be non-empty and contain some uppercase marker (kept from seed but simplified)
(assert (> (str.len value2) 0))
(assert (str.contains value2 "A"))
(assert (str.contains value2 "Z"))

; Core email constraints
(assert (> (str.len email) 5))
(assert (str.contains email "@"))
(assert (= (str.num_splits email "@") 2))
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain_part (str.split_at email "@" 1)))

; local-part must be non-empty and cannot contain '@'
(assert (> (str.len local_part) 0))
(assert (= (str.indexof local_part "@" 0) (- 1)))

; domain must contain at least one dot and have at least 2 labels
(assert (str.contains domain_part "."))
(assert (>= (str.num_splits domain_part ".") 2))

; enforce at least three labels: e.g., sub.example.tld
(assert (>= (str.num_splits domain_part ".") 3))
(assert (= domain_label0 (str.split_at domain_part "." 0)))
(assert (= domain_label1 (str.split_at domain_part "." 1)))
(assert (= tld (str.split_at domain_part "." 2)))

; labels non-empty
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 1))

; disallow empty labels caused by leading/trailing/consecutive dots
(assert (not (= (str.at domain_part 0) ".")))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))
(assert (= (str.indexof domain_part ".." 0) (- 1)))

; simple structural reconstruction check
(assert (= reconstructed (str.++ local_part "@" domain_part)))
(assert (= email reconstructed))

; Mix in a regex-based policy: local-part chars and basic domain/tld policy
(declare-const re_atom RegLan)
(declare-const re_local RegLan)
(declare-const re_label RegLan)
(declare-const re_tld RegLan)
(declare-const re_domain RegLan)

(assert (= re_atom (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re "."))))
(assert (= re_local (re.++ re_atom (re.* re_atom))))
(assert (= re_label (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))
(assert (= re_tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))
(assert (= re_domain (re.++ re_label (str.to_re ".") re_label (str.to_re ".") re_tld)))

(assert (str.in_re local_part re_local))
(assert (str.in_re domain_part re_domain))

; UNSAT twist: simultaneously require two different TLDs
(assert (= tld "com"))
(assert (= tld "org"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
