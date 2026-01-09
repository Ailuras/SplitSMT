(set-logic ALL)

; Email Validation scenario using str_split interface

; Uninterpreted split operations

; Common string variables
(declare-const email_good String)
(declare-const local_good String)
(declare-const domain_good String)
(declare-const tld_good String)
(declare-const sld_good String)
(declare-const rest_domain_good String)

; A second email used to create an UNSAT sub-instance
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Integers for split indices (kept natural)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

; -------------------------
; Natural index constraints
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))

; -------------------------
; SAT instance: email_good is a valid complex email

; Exactly one '@' -> exactly two segments
(assert (= (str.num_splits email_good "@") 2))
(assert (= local_good (str.split_at email_good "@" k0)))
(assert (= domain_good (str.split_at email_good "@" k1)))

; Local part constraints: non-empty, no '@', no leading/trailing '.' and basic allowed charset
(assert (> (str.len local_good) 0))
(assert (not (str.contains local_good "@")))
(assert (not (= (str.at local_good 0) ".")))
(assert (not (= (str.at local_good (- (str.len local_good) 1)) ".")))
(assert (str.in_re local_good (re.++ (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._%+-")) (re.* (str.to_re "")))))

; Domain must contain at least one '.' -> at least two segments
(assert (>= (str.num_splits domain_good ".") 2))

; Enforce TLD is last segment and at least 2 chars alphabetic
(assert (= tld_good (str.split_at domain_good "." (- (str.num_splits domain_good ".") 1))))
(assert (>= (str.len tld_good) 2))
(assert (str.in_re tld_good (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))))

; Enforce second-level domain is segment 0 and non-empty
(assert (= sld_good (str.split_at domain_good "." 0)))
(assert (> (str.len sld_good) 0))
(assert (not (= (str.at sld_good 0) "-")))
(assert (not (= (str.at sld_good (- (str.len sld_good) 1)) "-")))
(assert (str.in_re sld_good (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"))))

; If there are more than 2 domain segments, ensure the remaining tail exists and is consistent
(assert (= rest_domain_good (str.split_rest domain_good "." 1)))
(assert (or (= (str.num_splits domain_good ".") 2)
            (and (> (str.len rest_domain_good) (str.len tld_good))
                 (str.contains rest_domain_good "."))))

; Concrete witness to keep the SAT part grounded
(assert (= email_good "john.doe+tag@sub.example.co"))

; -------------------------
; UNSAT instance: email_bad is forced to violate '@' segment constraints

; Force email_bad to be a typical-looking email...
(assert (= email_bad "a@b.com"))

; ...but also require it to have 3 segments when splitting by '@' (impossible for the concrete string)
(assert (= (str.num_splits email_bad "@") 3))
(assert (= local_bad (str.split_at email_bad "@" 0)))
(assert (= domain_bad (str.split_at email_bad "@" 1)))
(assert (= tld_bad (str.split_at domain_bad "." 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
