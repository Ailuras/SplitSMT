(set-logic ALL)

; Uninterpreted string-split interface

; ==========================
; Scenario: Email Validation
; ==========================

; ---------
; SAT part
; ---------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const host_and_tld String)
(declare-const host String)
(declare-const subdomain0 String)
(declare-const subdomain1 String)

; Basic split around '@'
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (= (str.num_splits email "@") 2))

; Local-part constraints: non-empty, no spaces, does not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Domain constraints: non-empty, must contain at least one '.', no spaces, does not contain '@'
(assert (> (str.len domain) 0))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))
(assert (>= (str.num_splits domain ".") 2))

; Extract last label as TLD using split_rest: last segment after '.'
; Enforce 2 segments by '.' for a simple domain: host.tld
(assert (= (str.num_splits domain ".") 2))
(assert (= host_and_tld domain))
(assert (= host (str.split_at host_and_tld "." 0)))
(assert (= tld (str.split_at host_and_tld "." 1)))

; Host label constraints
(assert (> (str.len host) 0))
(assert (not (str.contains host "..")))
(assert (not (str.contains host "-")))

; TLD constraints: length 2..6, only lowercase letters
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Constrain full email to be local@host.tld and avoid double '@'
(assert (= email (str.++ local "@" host "." tld)))
(assert (not (str.contains (str.substr email 1 (- (str.len email) 1)) "@")))

; Additional (optional) split checks: subdomain variables unused in host.tld case but declared for diversity
(assert (= subdomain0 (str.split_at domain "." 0)))
(assert (= subdomain1 (str.split_at domain "." 1)))
(assert (= subdomain0 host))
(assert (= subdomain1 tld))

; Witness to keep SAT grounded
(assert (= email "user@site.com"))

; -----------
; UNSAT part
; -----------
; A second email intended to be invalid by contradictory constraints
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)

(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))
(assert (= (str.num_splits bad_email "@") 2))

; Force bad_email to a concrete value with a 1-character TLD, but also require TLD length >= 2
(assert (= bad_email "a@b.c"))
(assert (= bad_tld (str.split_at bad_domain "." 1)))
(assert (= (str.num_splits bad_domain ".") 2))
(assert (>= (str.len bad_tld) 2))
(assert (= bad_tld "c"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
