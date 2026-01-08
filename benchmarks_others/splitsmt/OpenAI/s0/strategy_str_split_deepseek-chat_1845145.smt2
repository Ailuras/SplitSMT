(set-logic ALL)

; Email Validation scenario using str_split interface

; --- Uninterpreted split interface ---

; --- Core variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_head String)
(declare-const tld String)
(declare-const second_level String)

; Indices used for split operations
(declare-const k0 Int)
(declare-const k1 Int)

; --- Basic index/natural constraints (interface discipline) ---
(assert (= k0 0))
(assert (= k1 1))
(assert (>= k0 0))
(assert (>= k1 0))

; --- High-level structure: local@domain ---
(assert (>= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))

; Disallow empty local/domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Simple sanity constraints on email string itself
(assert (not (str.contains email " ")))
(assert (not (str.contains email "\n")))
(assert (not (str.contains email "\t")))

; Local-part: must not contain '@', but can contain '.' (not fully RFC)
(assert (not (str.contains local "@")))
; Domain must not contain '@'
(assert (not (str.contains domain "@")))

; --- Domain structure: at least one dot, extract head and tld ---
(assert (>= (str.num_splits domain ".") 2))
(assert (= domain_head (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))

; Domain labels must be non-empty
(assert (> (str.len domain_head) 0))
(assert (> (str.len tld) 0))

; Enforce no leading/trailing dot in domain by requiring first label and last part non-empty
; (already implied above, but repeated explicitly for clarity)
(assert (not (= domain_head "")))
(assert (not (= tld "")))

; Further constrain: tld must itself contain at most one dot (i.e., either "com" or "co.uk" style)
(assert (or (= (str.num_splits tld ".") 1)
            (= (str.num_splits tld ".") 2)))

; If tld has two labels, extract second-level and final label; otherwise second_level is whole tld
(assert (= second_level (str.split_at tld "." 0)))

; Ensure all labels in tld are non-empty
(assert (> (str.len (str.split_at tld "." 0)) 0))
(assert (=> (= (str.num_splits tld ".") 2)
            (> (str.len (str.split_at tld "." 1)) 0)))

; Additional mild restrictions: local and domain should be reasonably short
(assert (<= (str.len local) 64))
(assert (<= (str.len domain) 255))

; --- SAT instance witness constraints (choose a concrete-valid email) ---
(declare-const sat_email String)
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_tld String)
(assert (= sat_email "alice.smith+tag@sub.example.co.uk"))
(assert (>= (str.num_splits sat_email "@") 2))
(assert (= sat_local (str.split_at sat_email "@" 0)))
(assert (= sat_domain (str.split_at sat_email "@" 1)))
(assert (>= (str.num_splits sat_domain ".") 2))
(assert (= sat_tld (str.split_rest sat_domain "." 1)))
(assert (> (str.len sat_local) 0))
(assert (> (str.len sat_domain) 0))
(assert (not (str.contains sat_email " ")))

; --- UNSAT instance: contradictory requirements on a single email ---
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(assert (= bad_email "bob@example.com"))
(assert (= bad_local (str.split_at bad_email "@" 0)))
(assert (= bad_domain (str.split_at bad_email "@" 1)))
; Contradiction: require domain to have at least one dot and also no dots at all
(assert (>= (str.num_splits bad_domain ".") 2))
(assert (= (str.num_splits bad_domain ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
