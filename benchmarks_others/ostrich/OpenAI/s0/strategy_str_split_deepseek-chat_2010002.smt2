(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; ----------------------------
; Scenario: Email Validation
; ----------------------------

; Primary email under validation (intended SAT)
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_label0_ok String)
(declare-const domain_label1_ok String)
(declare-const tld_ok String)
(declare-const domain_prefix_ok String)

; Secondary email under validation (intended UNSAT)
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const bad_label0 String)
(declare-const bad_label1 String)
(declare-const bad_label2 String)

; ----------------------------
; SAT instance: email_ok constraints
; ----------------------------

; Exactly one '@' delimiter => two segments
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Basic sanity: non-empty local and domain, and local cannot contain '@'
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains local_ok "@")))

; Domain must have at least one '.' => at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))
(assert (= domain_label0_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))

; The rest from label1 onward forms the domain suffix
(assert (= domain_prefix_ok (split_rest domain_ok "." 1)))
(assert (> (str.len domain_label0_ok) 0))
(assert (> (str.len tld_ok) 1))

; No empty labels: require the first two labels non-empty when present
(assert (=> (>= (num_splits domain_ok ".") 2)
            (> (str.len (split_at domain_ok "." 1)) 0)))

; Forbid leading or trailing '.' in domain
(assert (not (= (str.at domain_ok 0) ".")))
(assert (not (= (str.at domain_ok (- (str.len domain_ok) 1)) ".")))

; Ensure domain contains no '@'
(assert (not (str.contains domain_ok "@")))

; Strengthen: local part contains a dot somewhere (allowed in many emails)
(assert (str.contains local_ok "."))

; Provide a concrete satisfying example to ensure SAT
(assert (= email_ok "john.doe@example.co.uk"))

; ----------------------------
; UNSAT instance: email_bad constraints
; ----------------------------

; Claim exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Additionally (contradict) that there are at least 3 segments by '@'
(assert (>= (num_splits email_bad "@") 3))

; Add domain structure constraints that would otherwise be reasonable
(assert (>= (num_splits domain_bad ".") 2))
(assert (= bad_label0 (split_at domain_bad "." 0)))
(assert (= bad_label1 (split_at domain_bad "." 1)))
(assert (=> (>= (num_splits domain_bad ".") 3)
            (= bad_label2 (split_at domain_bad "." 2))))

; Non-empty first label and TLD length constraint
(assert (> (str.len bad_label0) 0))
(assert (> (str.len (split_at domain_bad "." (- (num_splits domain_bad ".") 1))) 1))

; Provide a concrete-looking email string (still UNSAT due to '@' split contradiction)
(assert (= email_bad "alice@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
