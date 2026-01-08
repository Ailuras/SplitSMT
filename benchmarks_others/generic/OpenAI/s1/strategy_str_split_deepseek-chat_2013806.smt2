(set-logic ALL)

; Scenario: Email Validation using str_split

; Uninterpreted interface operations for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const host String)
(declare-const reconstructed String)

; Keep a mutated version of the seed-style constraint (now about email/local)
(assert (not (= (str.replace email (str.replace local local "") email) (str.++ email email))))

; Basic email structure: must contain exactly one '@' (2 segments after splitting)
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part constraints: non-empty, cannot contain '@', and cannot start/end with '.'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: must contain at least one '.', with non-empty host and tld
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len host) 0))
(assert (> (str.len tld) 0))

; Domain must not start or end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Subdomain/rest constraints: take everything after the first dot
(assert (= subdomain (split_rest domain "." 1)))
(assert (> (str.len subdomain) 0))

; Require a plausible TLD length (e.g., 2..24)
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 24)))

; Reconstruct and ensure it matches (structural sanity)
(assert (= reconstructed (str.++ local "@" domain)))
(assert (= email reconstructed))

; SAT branch: allow either exactly two domain labels OR multiple labels
(assert (or (= (num_splits domain ".") 2) (>= (num_splits domain ".") 3)))

; UNSAT instance embedded: force contradictory TLD length simultaneously
(assert (and (<= (str.len tld) 1) (>= (str.len tld) 2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
