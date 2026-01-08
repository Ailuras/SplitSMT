(set-logic ALL)

; Email Validation scenario with split_at/num_splits/split_rest constraints

; --- Uninterpreted interface for str_split ---

; --- Seed-preserved core variables ---
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

; --- Email-specific variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain0 String)
(declare-const subdomain1 String)
(declare-const user0 String)
(declare-const user1 String)
(declare-const domain_left String)
(declare-const attack_is_email Bool)

; --- Preserve core structure: a long regex-built "attack" + postfixs, but repurpose as an email candidate ---
(assert (str.in_re attack (re.++ prefix ((_ re.loop 50 50) infix) postfix)))

; Make prefix/infix/postfix simpler but still non-trivial (mutated from seed while preserving structure)
(assert (= prefix (re.++ (str.to_re "user") (re.++ (re.+ (re.union (str.to_re "_") (str.to_re "-") (str.to_re ".") (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "1") (str.to_re "2") (str.to_re "3"))) (str.to_re "@")))))

(assert (= infix (re.++ (str.to_re "sub") (re.++ (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "-") (str.to_re "1") (str.to_re "2"))) (str.to_re ".")))))

(assert (= postfix (re.++ (str.to_re "example") (re.++ (str.to_re ".") (re.union (str.to_re "com") (str.to_re "net") (str.to_re "org"))))))

(assert (str.in_re postfixs postfix))
(assert (>= (str.len postfixs) 3))
(assert (= result (str.++ attack postfixs)))

; Email candidate equals the constructed result
(assert (= email result))

; --- Core email split constraints using '@' and '.' as delimiters ---
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= (str.split_rest email "@" 1) domain))
(assert (= (str.num_splits email "@") 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 1))

; local part must not contain '@'
(assert (= (str.num_splits local "@") 1))

; domain must have at least 2 labels: something.tld
(assert (>= (str.num_splits domain ".") 2))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (= domain_left (str.split_rest domain "." 0)))
(assert (>= (str.len tld) 2))

; also constrain first two labels for structure
(assert (= subdomain0 (str.split_at domain "." 0)))
(assert (= subdomain1 (str.split_at domain "." 1)))
(assert (>= (str.len subdomain0) 1))
(assert (>= (str.len subdomain1) 1))

; local part further split by '.' into user segments
(assert (= user0 (str.split_at local "." 0)))
(assert (= user1 (str.split_at local "." 1)))
(assert (>= (str.num_splits local ".") 1))
(assert (>= (str.len user0) 1))

; Character-level sanity: email must contain '@' and '.' in the domain
(assert (str.contains email "@"))
(assert (str.contains domain "."))

; --- A satisfiable branch constraint (softly linked) ---
(assert (= attack_is_email true))
(assert (=> attack_is_email (str.contains local "user")))

; --- Create an UNSAT core condition to ensure mixed SAT/UNSAT instances ---
; This makes it impossible: if there are exactly 2 split segments by '@', then local cannot equal full email.
(assert (not (= local email)))
(assert (= local email))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
