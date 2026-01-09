(set-logic ALL)

; Email Validation scenario using split operations and regex constraints

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)

(declare-const k_at Int)
(declare-const k_dot Int)

; Segment extraction via delimiters
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." 2)))

; Indices are natural
(assert (and (>= k_at 0) (>= k_dot 0)))

; Must have exactly one '@' producing two segments
(assert (= (num_splits email "@") 2))

; Domain must have at least three labels (e.g., a.b.cc)
(assert (>= (num_splits domain ".") 3))

; Ensure reconstructed structure contains separators in expected places
(assert (= email (str.++ local "@" domain)))
(assert (= domain (str.++ domain_label0 "." (split_rest domain "." 1))))

; Local-part: non-empty, must not contain '@', and restricted chars
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re ".") (str.to_re "+") (str.to_re "-")))))

; Domain labels: non-empty, must not contain '@' or '.'
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (not (str.contains domain_label0 "@")))
(assert (not (str.contains domain_label1 "@")))
(assert (not (str.contains domain_label0 ".")))
(assert (not (str.contains domain_label1 ".")))

; Domain label allowed chars: letters/digits/hyphen, must start with a letter
(assert (str.in_re domain_label0 (re.++ (re.range "a" "z") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))
(assert (str.in_re domain_label1 (re.++ (re.range "a" "z") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))

; TLD: 2..6 letters
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Disallow consecutive dots in the whole email (approximation)
(assert (not (str.contains email "..")))

; --- Derived UNSAT core from seed style (conflicting constraints) ---
; Require email to be made of at least two "00" blocks
(assert (str.in_re email (re.+ (re.+ (str.to_re "00")))))
; Forbid any string that is a concatenation of "000" and/or "1" (conflicts with above)
(assert (not (str.in_re email (re.* (re.union (str.to_re "000") (str.to_re "1"))))))

; Additionally force presence of '@' and '.' structure, making the conflict unavoidable
(assert (str.contains email "@"))
(assert (str.contains domain "."))

(check-sat)


; [GENERATION STATUS: SUCCESS]