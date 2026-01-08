(set-logic ALL)

; Email Validation scenario using str_split over '@' and '.'

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- Variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom1 String)
(declare-const dom2 String)
(declare-const secondLevel String)
(declare-const subdomain String)
(declare-const atCount Int)
(declare-const dotCount Int)
(declare-const tldLen Int)

; --- Core structure: split at '@' then validate domain parts ---
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= atCount (num_splits email "@")))
(assert (= atCount 2))

; Local-part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Domain constraints: must contain at least one '.'
(assert (= dotCount (num_splits domain ".")))
(assert (>= dotCount 2))

(assert (= tld (split_at domain "." (- dotCount 1))))
(assert (= tldLen (str.len tld)))
(assert (>= tldLen 2))
(assert (<= tldLen 6))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; First two domain segments (to enforce structure)
(assert (= dom1 (split_at domain "." 0)))
(assert (= dom2 (split_at domain "." 1)))
(assert (> (str.len dom1) 0))
(assert (> (str.len dom2) 0))

; Enforce that domain is exactly three labels: subdomain.secondLevel.tld
(assert (= dotCount 3))
(assert (= subdomain dom1))
(assert (= secondLevel dom2))
(assert (> (str.len secondLevel) 1))
(assert (str.in_re secondLevel (re.+ (re.union (re.range "a" "z") (re.range "0" "9")))))

; Additional sanity: reconstruct email from parts (relaxation-friendly)
(assert (= email (str.++ local "@" domain)))
(assert (not (= (str.len email) 0)))
(assert (<= (str.len email) 64))

; --- UNSAT branch to ensure diversity (guarded by fixed false) ---
; If enabled, would contradict atCount=2
(assert (=> false (not (= atCount 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
