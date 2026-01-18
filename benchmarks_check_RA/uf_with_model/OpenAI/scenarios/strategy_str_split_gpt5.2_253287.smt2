(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; --- Uninterpreted interface functions for str_split ---

; --- Email validation scenario: SAT instance ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const sld_ok String)
(declare-const first_label_ok String)
(declare-const rest_labels_ok String)

; Split around '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= "" (split_rest email_ok "@" 2)))
(assert (= (num_splits email_ok "@") 2))

; Local-part constraints: non-empty, no '@', no spaces
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: must contain '.', not start/end with '.', non-empty labels
(assert (>= (str.len domain_ok) 3))
(assert (>= (num_splits domain_ok ".") 2))
(assert (not (= (split_at domain_ok "." 0) "")))
(assert (not (= (split_at domain_ok "." (- (num_splits domain_ok ".") 1)) "")))

; Bind last two labels (SLD and TLD) using indices derived from num_splits
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (= sld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 2))))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 15))

; Require at least one label before the SLD (i.e., allow subdomains but not mandatory)
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (not (= first_label_ok "")))

; Domain labels must avoid spaces and '@'
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))

; Restrict TLD to letters only
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Ensure local part begins with an alnum and contains only allowed characters (simplified)
(assert (str.in_re local_ok (re.++ (re.union (re.range "a" "z") (re.range "0" "9"))
                                   (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "+"))))))

; Ensure each label in domain is alnum/hyphen and does not start/end with hyphen (approx via regex for whole domain)
(declare-const domain_label_re RegLan)
(assert (= domain_label_re (re.++ (re.union (re.range "a" "z") (re.range "0" "9"))
                                   (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
                                   (re.union (re.range "a" "z") (re.range "0" "9")))))
(declare-const domain_re RegLan)
(assert (= domain_re (re.++ domain_label_re (re.* (re.++ (str.to_re ".") domain_label_re)))))
(assert (str.in_re domain_ok domain_re))

; Provide a concrete satisfying witness for the SAT part
(assert (= email_ok "john.doe+1@sub.example.com"))

; --- Email validation scenario: UNSAT instance ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Split around '@'
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))
(assert (= (num_splits email_bad "@") 2))

; Force a specific email with a one-letter TLD, while requiring TLD length >= 2 (contradiction)
(assert (= email_bad "a@b.c"))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))
(assert (>= (num_splits domain_bad ".") 2))
(assert (>= (str.len tld_bad) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
