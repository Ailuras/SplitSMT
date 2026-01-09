(set-logic ALL)

; Email Validation via str_split: using '@' and '.' delimiters

; --- Uninterpreted interface for string split ---

; --- Common helpers ---
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const tld String)
(declare-const tld2 String)
(declare-const reconstructed String)

; Basic decomposition around '@'
(assert (= local_part (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (<= (str.num_splits email "@") 2))

; Reconstruction sanity: local@domain
(assert (= reconstructed (str.++ local_part "@" domain)))
(assert (= email reconstructed))

; Local part constraints
(assert (>= (str.len local_part) 1))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part "..")))

; Domain constraints: must contain at least one '.' and no spaces
(assert (>= (str.len domain) 3))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))
(assert (>= (str.num_splits domain ".") 2))

; Extract first domain label and last label (TLD)
(assert (= domain_first (str.split_at domain "." 0)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))
(assert (>= (str.len domain_first) 1))
(assert (>= (str.len tld) 2))

; Ensure domain labels are non-empty at extremes and no consecutive dots
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Require TLD to be lowercase letters only, length 2..6
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; --- SAT instance constraints (a concrete satisfiable example) ---
(declare-const sat_email String)
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_tld String)
(assert (= sat_email "alice.smith+tag@example.co"))
(assert (= sat_local (str.split_at sat_email "@" 0)))
(assert (= sat_domain (str.split_at sat_email "@" 1)))
(assert (= sat_tld (str.split_at sat_domain "." (- (str.num_splits sat_domain ".") 1))))
(assert (= (str.num_splits sat_email "@") 2))
(assert (>= (str.num_splits sat_domain ".") 2))
(assert (>= (str.len sat_local) 1))
(assert (str.in_re sat_tld (re.+ (re.range "a" "z"))))

; --- UNSAT instance constraints (deliberate contradiction) ---
; This block asserts an email with two '@' but simultaneously constrains exactly one '@' split.
(declare-const unsat_email String)
(declare-const unsat_local String)
(declare-const unsat_domain String)
(assert (= unsat_email "bad@@example.com"))
(assert (= unsat_local (str.split_at unsat_email "@" 0)))
(assert (= unsat_domain (str.split_at unsat_email "@" 1)))
(assert (= (str.num_splits unsat_email "@") 2))
(assert (>= (str.num_splits unsat_email "@") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
