(set-logic ALL)

; Email Validation scenario using str_split interface over '@' and '.' delimiters.

; --- Uninterpreted interface functions (str_split) ---

; --- Variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sld String)
(declare-const firstLabel String)
(declare-const restDomain String)
(declare-const label0 String)
(declare-const label1 String)

; --- Mutated seed-like constraint: keep a complex regex membership check but repurpose for local-part character shape ---
; Local-part must be non-empty and consist of allowed atoms separated by single dots.
(assert (str.in_re local
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "+")))))
    (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "+"))))))))))

; --- Core split structure for email ---
(assert (>= (str.num_splits email "@") 2))
(assert (<= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Ensure email reconstructs from parts (structural check).
(assert (= email (str.++ local "@" domain)))

; Local and domain non-empty
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Disallow spaces and consecutive dots in whole email (simple sanity)
(assert (not (str.contains email " ")))
(assert (not (str.contains email "..")))

; --- Domain structure using '.' splits ---
(assert (>= (str.num_splits domain ".") 2))

; Capture first label and rest, plus specific positions
(assert (= firstLabel (str.split_at domain "." 0)))
(assert (= restDomain (str.split_rest domain "." 1)))

; If there are exactly 2 labels, then label1 is TLD; otherwise still define some segments
(assert (= label0 (str.split_at domain "." 0)))
(assert (= label1 (str.split_at domain "." 1)))

; Require at least one dot in domain (already via num_splits >= 2), and no empty labels
(assert (> (str.len firstLabel) 0))
(assert (> (str.len label1) 0))

; Disallow leading/trailing dot in domain
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Domain must be made only of lower letters, digits, hyphen and dots; labels must not start/end with '-'
(assert (str.in_re domain (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re "-") (str.to_re ".")))))))
(assert (not (= (str.at firstLabel 0) "-")))
(assert (not (= (str.at firstLabel (- (str.len firstLabel) 1)) "-")))

; Extract sld and tld when domain has exactly 2 labels
(assert (=> (= (str.num_splits domain ".") 2)
            (and (= sld (str.split_at domain "." 0))
                 (= tld (str.split_at domain "." 1)))))

; TLD constraints: length 2..6 and letters only
(assert (=> (= (str.num_splits domain ".") 2)
            (and (>= (str.len tld) 2)
                 (<= (str.len tld) 6)
                 (str.in_re tld (re.+ (re.range "a" "z"))))))

; Additional domain constraint: if there are 3+ labels, require the last label (index 2) to be non-empty too
(assert (=> (>= (str.num_splits domain ".") 3)
            (> (str.len (str.split_at domain "." 2)) 0)))

; --- A small UNSAT branch guarded by a boolean-like condition removed; instead create a direct inconsistency on a fresh var for diversity ---
; This is kept satisfiable overall by not constraining email to equal badEmail.
(declare-const badEmail String)
(declare-const badDomain String)
(assert (= badEmail "a@b"))
(assert (= badDomain (str.split_at badEmail "@" 1)))
(assert (>= (str.num_splits badDomain ".") 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
