(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Uninterpreted functions for str_split interface

; Core input email string
(declare-const X String)

; Derived parts using split constraints
(declare-const local String)
(declare-const domain String)
(declare-const domain_head String)
(declare-const tld String)
(declare-const subdomain String)

; Keep seed-like “negative regex” structure but adapted to email validation
(assert (not (str.in_re X (str.to_re "pjpoptwql/rlnjsportsHost:Subject:YAHOOdestroyed!\u{a}"))))

; Disallow URL-like prefixes in email
(assert (not (str.in_re X (re.++ (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_") (str.to_re "-") (str.to_re ".")))
                              (str.to_re "://")
                              (re.* re.allchar)))))

; Require a linefeed at end (seed preserved motif), but ensure it's an email-like line
(assert (str.in_re X (re.++ (re.* re.allchar) (str.to_re "\u{a}"))))

; Basic split by '@' to obtain local and domain
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (>= (num_splits X "@") 2))
(assert (<= (num_splits X "@") 2))

; Local part constraints: non-empty, no spaces, no additional '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (= (num_splits local "@") 1))

; Domain constraints: must contain at least one '.' and at least two segments when split on '.'
(assert (> (str.len domain) 0))
(assert (= domain (split_rest X "@" 1)))
(assert (>= (num_splits domain ".") 2))

; Extract domain head and last label (TLD)
(assert (= domain_head (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Additionally reason about a potential subdomain part (everything after first '.')
(assert (= subdomain (split_rest domain "." 1)))
(assert (> (str.len domain_head) 0))
(assert (> (str.len subdomain) 0))

; TLD must be alphabetic and at least length 2 (apply to subdomain end via regex on subdomain)
(declare-const alpha String)
(assert (= alpha "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
(assert (str.in_re subdomain (re.++ (re.* re.allchar) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))))))
(assert (>= (str.len tld) 2))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Reject common invalid patterns: consecutive dots, leading dot in local, trailing dot in local, and domain ending with '.'
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Preserve another seed-like negative regex but tuned away from IP-ish payloads
(assert (not (str.in_re X (re.++ (str.to_re "phpinfo") (re.* (re.union (str.to_re "\u{a}") (str.to_re "\u{d}"))) (re.* re.allchar)))))

; SAT/UNSAT diversity: ensure it is a valid email-like structure while forbidding a specific domain
(assert (not (str.contains domain "aresflashdownloader.com")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
