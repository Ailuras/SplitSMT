(set-logic ALL)

; Email Validation scenario with split-based constraints and regex structure

; --- str_split interface ---

; --- Core strings ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const leftmost String)
(declare-const reconstructed String)

; --- Regex building blocks (mutated from seed) ---
(declare-const local_re RegLan)
(declare-const label_re RegLan)
(declare-const domain_re RegLan)
(declare-const email_re RegLan)

; Split constraints using '@' and '.' delimiters
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= reconstructed (str.++ local "@" domain)))
(assert (= email reconstructed))
(assert (= (str.num_splits email "@") 2))

; Domain must contain at least one '.'
(assert (>= (str.num_splits domain ".") 2))
(assert (= leftmost (str.split_at domain "." 0)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Index bounds / naturality (interface discipline)
(assert (>= (str.num_splits domain ".") 2))
(assert (>= (- (str.num_splits domain ".") 1) 0))

; Local and domain must be non-empty
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))
(assert (>= (str.len tld) 2))

; Disallow spaces and additional '@'
(assert (not (str.contains email " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Disallow empty labels: no leading '.', no trailing '.', no '..'
(assert (not (= (str.split_at domain "." 0) "")))
(assert (not (= tld "")))
(assert (not (str.contains domain "..")))

; Regex for local part: [A-Za-z0-9_+.-]+ but not starting or ending with '.'
(assert (= local_re
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".") ))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
  )))

; Regex for a domain label: [A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?
(assert (= label_re
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.opt
      (re.++
        (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
      ))
  )))

; Domain regex: label ('.' label)+
(assert (= domain_re
  (re.++
    label_re
    (re.+ (re.++ (str.to_re ".") label_re))
  )))

; Full email regex
(assert (= email_re (re.++ local_re (str.to_re "@") domain_re)))
(assert (str.in_re email email_re))

; Additional semantic constraints: leftmost label can't start with '-' and tld must be alphabetic-only
(assert (not (str.contains leftmost "-")))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Create both SAT and UNSAT pressure: enforce a dot in local, but also forbid any '.' in local -> UNSAT
(assert (str.contains local "."))
(assert (not (str.contains local ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
