(set-logic QF_S)

; Example 1: Email Format Validation
; Assumes email address split at '@' into local-part and domain-part

(declare-fun email () String)
(declare-fun local_part () String)
(declare-fun domain_part () String)

(assert (= (str.len email) (+ (str.len local_part) (str.len domain_part) 1))) ; account for '@'

(assert (str.contains email "@"))
(assert (str.prefixof local_part email))
(assert (str.suffixof domain_part email))

; split_at: index of '@'
(declare-fun at_idx () Int)
(assert (= at_idx (str.indexof email "@" 0)))

(assert (>= at_idx 1)) ; at least one char before '@'
(assert (< at_idx (- (str.len email) 1))) ; at least one char after '@'

(assert (= local_part (str.substr email 0 at_idx)))
(assert (= domain_part (str.substr email (+ at_idx 1) (- (str.len email) (+ at_idx 1)))))

; optional: domain must contain at least one '.'
(assert (>= (str.indexof domain_part "." 0) 1))
(check-sat)