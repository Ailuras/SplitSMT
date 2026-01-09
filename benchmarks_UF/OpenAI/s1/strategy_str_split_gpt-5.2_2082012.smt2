(set-logic ALL)

; Email Validation scenario using split_at/num_splits/split_rest

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Primary email strings
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)

; Extra variables for structure/consistency
(declare-const atCount Int)
(declare-const dotCount Int)
(declare-const localLen Int)
(declare-const domainLen Int)

; Core split structure: local@domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= atCount (num_splits email "@")))

; Exactly one '@' => exactly two segments
(assert (= atCount 2))

; Basic non-emptiness
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; No '@' inside either segment (enforces single delimiter usage)
(assert (= (num_splits local "@") 1))
(assert (= (num_splits domain "@") 1))

; Domain must have at least one dot (subdomain + tld) and tld is last segment
(assert (= dotCount (num_splits domain ".")))
(assert (>= dotCount 2))
(assert (= subdomain (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dotCount 1))))

; Prevent empty labels around dots in domain and local-part starts/ends not dot
(assert (> (str.len subdomain) 0))
(assert (> (str.len tld) 0))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Track lengths via integer variables
(assert (= localLen (str.len local)))
(assert (= domainLen (str.len domain)))
(assert (>= localLen 1))
(assert (>= domainLen 3))

; Mutated/extended regex constraints derived from seed style
; Local part: one or more of {a,b,'[',']','.', '_', '+', '-'}
(assert (str.in_re local
  (re.+
    (re.union (str.to_re "a")
      (re.union (str.to_re "b")
        (re.union (str.to_re "[")
          (re.union (str.to_re "]")
            (re.union (str.to_re ".")
              (re.union (str.to_re "_")
                (re.union (str.to_re "+") (str.to_re "-")))))))))))

; Domain: letters/digits/hyphen/dot, at least one dot somewhere
(assert (str.in_re domain
  (re.++
    (re.+ (re.union (str.to_re "b")
           (re.union (str.to_re "a")
             (re.union (str.to_re "7") (str.to_re "-")))))
    (re.++ (str.to_re ".")
      (re.+ (re.union (str.to_re "b")
             (re.union (str.to_re "a") (str.to_re "7"))))))))

; TLD constraints: typical 2..6 lowercase letters
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (str.to_re "a") (str.to_re "b")))))

; Consistency: reconstruct email (split_rest is uninterpreted, so use direct concat)
(assert (= email (str.++ local "@" domain)))

; --- Add an UNSAT corner to ensure diversity within this single file ---
; Require email to contain no '@' while also enforcing exactly one '@'
(assert (not (str.contains email "@")))

(check-sat)


; [GENERATION STATUS: SUCCESS]