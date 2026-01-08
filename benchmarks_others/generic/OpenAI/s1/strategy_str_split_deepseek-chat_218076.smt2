(set-logic ALL)

; Scenario: Email Validation using '@' and '.' as delimiters
; Core seed structure preserved: keep sigmaStar_0, literals, epsilon, x_3, x_6; extend with email-specific constraints.

(declare-fun sigmaStar_0 () String)
(declare-fun literal_2 () String)
(declare-fun x_3 () String)
(declare-fun x_6 () String)
(declare-fun epsilon () String)
(declare-fun literal_5 () String)

; str_split interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Email-related variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sld String)
(declare-const domain_left String)
(declare-const domain_mid String)
(declare-const domain_right String)
(declare-const dot_count_domain Int)
(declare-const at_count_email Int)
(declare-const domain_len Int)
(declare-const local_len Int)
(declare-const tld_len Int)

; Seed literals (mutated into email-centric anchors)
(assert (= literal_2 "@"))
(assert (= x_3 (str.++ sigmaStar_0 literal_2)))
(assert (= epsilon ""))
(assert (= literal_5 "."))

; Keep a seed-like disjunction, but repurpose x_6 to be either empty or '.'
(assert (or (= x_6 epsilon) (= x_6 literal_5)))

; Email must contain '@' as a separator and not begin/end with it
(assert (= at_count_email (num_splits email "@")))
(assert (= at_count_email 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (= (str.at email 0) "@")))
(assert (not (= (str.at email (- (str.len email) 1)) "@")))

; Local-part constraints: no empty, no spaces, no additional '@'
(assert (= local_len (str.len local)))
(assert (>= local_len 1))
(assert (= (num_splits local "@") 1))
(assert (not (str.contains local " ")))

; Domain structure: require at least one '.' and exactly 2 or 3 labels
(assert (= dot_count_domain (num_splits domain ".")))
(assert (or (= dot_count_domain 2) (= dot_count_domain 3)))

; Extract domain labels for 2- or 3-label domains
(assert (= sld (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dot_count_domain 1))))
(assert (= domain_len (str.len domain)))
(assert (> domain_len 2))

; Ensure no empty labels around '.'
(assert (> (str.len sld) 0))
(assert (> (str.len tld) 0))

; TLD basic sanity: length 2..24, only letters (approx via regex of allchar minus easy exclusions is not available)
; Use a conservative regex for [A-Za-z]+ by explicit union ranges.
(declare-const reLower RegLan)
(declare-const reUpper RegLan)
(assert (= reLower (re.union (re.range "a" "z") (re.range "a" "z"))))
(assert (= reUpper (re.union (re.range "A" "Z") (re.range "A" "Z"))))
(assert (= tld_len (str.len tld)))
(assert (and (>= tld_len 2) (<= tld_len 24)))
(assert (str.in_re tld (re.+ (re.union reLower reUpper))))

; Domain must not contain spaces or '@'
(assert (not (str.contains domain " ")))
(assert (= (num_splits domain "@") 1))

; Additional structure for possible 3-label domains
(assert (= domain_left (split_at domain "." 0)))
(assert (= domain_mid (split_at domain "." 1)))
(assert (= domain_right (split_at domain "." 2)))
(assert (=> (= dot_count_domain 3) (and (> (str.len domain_left) 0) (> (str.len domain_mid) 0) (> (str.len domain_right) 0))))

; Avoid consecutive dots by requiring that splitting by '.' yields no empty second label when 3 labels
(assert (=> (= dot_count_domain 3) (not (= domain_mid ""))))

; Tie seed variable sigmaStar_0 to local part prefix for structural preservation
(assert (str.prefixof sigmaStar_0 local))

; SAT instance anchor: set a concrete satisfiable email
(assert (= email "alice.smith@dept.example.com"))

; Also include a separate UNSAT-like constraint on x_6 to ensure diversity without breaking satisfiable email
; x_6 must be either empty or '.', and we additionally require it to contain a character 'X' (impossible)
(declare-const mustContainX Bool)
(assert (= mustContainX true))
(assert (=> mustContainX (str.contains x_6 "X")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
