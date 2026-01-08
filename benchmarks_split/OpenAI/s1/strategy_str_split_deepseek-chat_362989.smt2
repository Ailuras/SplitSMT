; Email Validation scenario: validate complex email formats using '@' and '.' as delimiters
(set-logic ALL)

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables
(declare-const value String) ; the email address
(declare-const key String)
(declare-const local String)
(declare-const domain String)
(declare-const sld String)  ; second-level domain
(declare-const tld String)  ; top-level domain
(declare-const subrest String)

; Preserve some core structure from seed while adapting to email setting
(assert (and
  ; key fixed to mimic header-like context but email scenario
  (not (= (ite (= key "email") 1 0) 0))

  ; non-empty overall value
  (not (not (= (ite (= (str.len value) 0) 1 0) 0)))
  (not (= (ite (not (= (str.len value) 0)) 1 0) 0))

  ; must contain '@' and not contain spaces
  (not (= (ite (str.contains value "@") 1 0) 0))
  (not (not (= (ite (str.contains value " ") 1 0) 0)))

  ; split around '@' into exactly 2 segments (local and domain)
  (= (num_splits value "@") 2)
  (= local (split_at value "@" 0))
  (= domain (split_at value "@" 1))

  ; local and domain non-empty
  (> (str.len local) 0)
  (> (str.len domain) 0)

  ; local cannot start/end with '.' and cannot contain '@'
  (not (= (str.at local 0) "."))
  (not (= (str.at local (- (str.len local) 1)) "."))
  (not (str.contains local "@"))

  ; domain must contain at least one '.'
  (>= (num_splits domain ".") 2)

  ; set TLD as last split; and SLD as penultimate split for structure
  (= tld (split_at domain "." (- (num_splits domain ".") 1)))
  (= sld (split_at domain "." (- (num_splits domain ".") 2)))

  ; tld constraints: 2..6 letters only
  (>= (str.len tld) 2)
  (<= (str.len tld) 6)
  (str.in_re tld (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z"))))

  ; sld non-empty and no empty labels in domain
  (> (str.len sld) 0)

  ; domain labels: no leading/trailing '.' and no consecutive '..'
  (not (= (str.at domain 0) "."))
  (not (= (str.at domain (- (str.len domain) 1)) "."))
  (not (str.contains domain ".."))

  ; optional subdomains: if there are more than 2 labels, enforce each non-empty by forbidding '..'
  (= subrest (split_rest domain "." 0))

  ; index bounds-style constraints echoing seed's arithmetic checks
  (>= (str.indexof value "@" 0) 0)
  (>= (- (str.len value) (+ (str.indexof value "@" 0) 1)) 0)
  (>= 0 0)
))

; UNSAT branch to ensure diversity: require both exactly one '@' via split count AND also forbid '@'
(assert (and
  (= (num_splits value "@") 2)
  (not (str.contains value "@"))
))

(check-sat)


; [GENERATION STATUS: SUCCESS]