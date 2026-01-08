(set-logic ALL)

; Email Validation scenario using str_split with '@' and '.' delimiters

; Non-primitive interface operations (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Primary input
(declare-const s String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom_first String)
(declare-const dom_mid String)

; Preserve core “length/at/ite” structure from seed, but simplify and align with email validation
(assert
  (and
    (not (= (ite (> (str.len s) 0) 1 0) 0))
    (not (= (ite (> (str.len s) 5) 1 0) 0))
    (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))
    (not (not (= (ite (<= (str.len s) 0) 1 0) 0)))
    (not (not (= (ite (< (- (str.len s) 1) 0) 1 0) 0)))
    (not (not (= (ite (<= (- (str.len s) 1) 0) 1 0) 0)))
    (not (= (ite (= (str.at s 0) "@") 1 0) 0))
    (not (= (ite (= (str.at s (- (str.len s) 1)) "@") 1 0) 0))
    (not (= (ite (= (str.at s (- (str.len s) 1)) ".") 1 0) 0))
  )
)

; Split around '@' exactly once: local@domain
(assert (= (num_splits s "@") 2))
(assert (= local (split_at s "@" 0)))
(assert (= domain (split_at s "@" 1)))
(assert (= (split_rest s "@" 1) domain))

; Local part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain must contain dots and have at least 2 labels (e.g., example.com)
(assert (>= (num_splits domain ".") 2))
(assert (= dom_first (split_at domain "." 0)))
(assert (= dom_mid (split_rest domain "." 1)))
(assert (> (str.len dom_first) 0))
(assert (not (= (str.at dom_first 0) "-")))
(assert (not (= (str.at dom_first (- (str.len dom_first) 1)) "-")))

; Require TLD to be the last segment after splitting domain by '.'
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Disallow empty labels by forbidding leading/trailing '.' and consecutive '..'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))
(assert (= (str.indexof domain ".." 0) (- 1)))

; Mixed constraints: ensure the original string reconstructs from parts
(assert (= s (str.++ local "@" domain)))

; Also require a basic overall regex-style property: exactly one '@' and at least one '.' after it
(assert (str.contains domain "."))

(check-sat)


; [GENERATION STATUS: SUCCESS]
