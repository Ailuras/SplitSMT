(set-logic ALL)

; Uninterpreted split interface for email parsing

; Email candidate
(declare-const X String)

; Segments around '@' and '.'
(declare-const local String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)

; Core split structure
(assert (= local (str.split_at X "@" 0)))
(assert (= domain (str.split_at X "@" 1)))
(assert (= domain (str.split_rest X "@" 1)))
(assert (= (str.num_splits X "@") 2))

; Domain must have at least one '.' (i.e., at least 2 labels)
(assert (>= (str.num_splits domain ".") 2))
(assert (= dom_label0 (str.split_at domain "." 0)))
(assert (= dom_label1 (str.split_at domain "." 1)))
(assert (= tld (str.split_at domain "." (- (str.num_splits domain ".") 1))))

; Disallow empty segments
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (> (str.len dom_label0) 0))
(assert (> (str.len tld) 0))

; No whitespace in the full email
(assert (not (str.contains X " ")))
(assert (not (str.contains X "\t")))
(assert (not (str.contains X "\n")))
(assert (not (str.contains X "\r")))

; Local-part constraints: start with alnum, allow alnum and [._+-] in middle, end with alnum
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9")))))

; Domain constraints: overall allowed charset and structure: labels separated by '.'
(assert (str.in_re domain
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.+ (re.++
            (str.to_re ".")
            (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))))

; First label and TLD cannot start/end with '-'
(assert (not (= (str.at dom_label0 0) "-")))
(assert (not (= (str.at dom_label0 (- (str.len dom_label0) 1)) "-")))
(assert (not (= (str.at tld 0) "-")))
(assert (not (= (str.at tld (- (str.len tld) 1)) "-")))

; TLD must be alphabetic only, length 2..24
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 24)))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Additional structural checks: do not allow consecutive dots in local or domain
(assert (not (str.contains local "..")))
(assert (not (str.contains domain "..")))

; Ensure exactly one '@' in the entire string
(assert (= (str.num_splits X "@") 2))

; Create both SAT and UNSAT pressure: forbid a specific valid-looking email while requiring a pattern it matches
(declare-const bad String)
(assert (= bad "a.b+1@ex-ample.co"))
(assert (str.in_re X (str.to_re bad)))
(assert (not (= X bad)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
