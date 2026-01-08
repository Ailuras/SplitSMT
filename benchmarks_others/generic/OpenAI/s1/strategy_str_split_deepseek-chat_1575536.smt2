(set-logic ALL)
; Email Validation scenario using str_split and regex

; --- split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const domain_tld String)
(declare-const at_count Int)
(declare-const dot_count Int)

; --- basic split constraints for '@' ---
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; local part should not contain '@'
(assert (= (num_splits local "@") 1))

; domain must contain at least one '.' and have at least two labels
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))
(assert (= domain_first (split_at domain "." 0)))
(assert (>= (str.len domain_first) 1))

; last segment (TLD) should be length 2 or 3 (e.g., com, io)
(assert (= domain_tld (split_at domain "." (- dot_count 1))))
(assert (or (= (str.len domain_tld) 2) (= (str.len domain_tld) 3)))

; no empty segments in domain: reject leading, trailing, or consecutive dots
(assert (not (= domain_first "")))
(assert (not (= domain_tld "")))
(assert (not (str.contains domain "..")))

; forbid consecutive '@' (implied by at_count=2, but kept as structure)
(assert (not (str.contains email "@@")))

; --- regex constraints (mutated/extended from seed style) ---
; allow only a limited safe alphabet: letters, digits, '.', '_', '-', '@'
(declare-const allowed_re RegLan)
(assert (= allowed_re
  (re.*
    (re.union
      (re.range "a" "z")
      (re.union
        (re.range "A" "Z")
        (re.union
          (re.range "0" "9")
          (re.union (str.to_re ".")
            (re.union (str.to_re "_")
              (re.union (str.to_re "-") (str.to_re "@")))))))))
)
(assert (str.in_re email allowed_re))

; enforce exactly one '@' via split, plus ensure local/domain are not empty
(assert (not (= local "")))
(assert (not (= domain "")))

; local cannot start/end with '.' and cannot contain consecutive '.'
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; domain cannot start/end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; additional domain structure: the rest after first label must start with '.'
; (helps ensure split is consistent with presence of '.')
(assert (str.contains (split_rest domain "." 1) "."))

; --- UNSAT branch to ensure diversity: cannot have two distinct required TLD lengths simultaneously ---
(declare-const force_unsat Bool)
(assert (= force_unsat true))
(assert (=> force_unsat (and (= (str.len domain_tld) 2) (= (str.len domain_tld) 3))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
