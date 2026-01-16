(set-logic ALL)

; Email Validation scenario using '@' and '.' as delimiters with str_split interface


(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const label0 String)
(declare-const label1 String)

; Preserve core structure: attack matches a regex built from prefix, a fixed loop of infix, and postfix
(assert (str.in_re attack (re.++ prefix ((_ re.loop 50 50) infix) postfix)))

; Mutated prefix/infix/postfix to align with email-like components
; prefix: literal '1'
(assert (= prefix (str.to_re "\u{31}")))

; infix: allow many local-part characters and separators ('.' '_' '+'), excluding '@' by construction
(assert (= infix (re.+ (re.union (re.range "a" "z")
                                (re.range "A" "Z")
                                (re.range "0" "9")
                                (str.to_re ".")
                                (str.to_re "_")
                                (str.to_re "+")))))

; postfix: end with '@' to ensure result becomes a candidate email when concatenated with postfixs
(assert (= postfix (str.to_re "\u{40}")))

; postfixs: domain part must contain at least one '.' and end with a TLD of length 2..6 alphabetic
(assert (str.in_re postfixs (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
                                  (re.++ (str.to_re ".")
                                         (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
                                                (re.++ (str.to_re ".")
                                                       ((_ re.loop 2 6) (re.union (re.range "a" "z") (re.range "A" "Z")))))))))
(assert (>= (str.len postfixs) 1))

; Construct full email candidate
(assert (= result (str.++ attack postfixs)))
(assert (= email result))

; Split-based validation constraints
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (= (str.num_splits email "@") 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 1))

; Domain must have at least two labels when split by '.'
(assert (>= (str.num_splits domain ".") 2))
(assert (= label0 (str.split_at domain "." 0)))
(assert (= label1 (str.split_at domain "." 1)))
(assert (>= (str.len label0) 1))
(assert (>= (str.len label1) 1))

; TLD is last segment: constrain it using a regex and length bounds
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Basic sanity: local part should not contain '@' and domain should not contain '@'
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
