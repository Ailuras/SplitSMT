(set-logic ALL)

; Uninterpreted interface for string split operations
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; -------------------------------
; Scenario: Email Validation
; We model validation with '@' and '.' delimiters.
; Provide one satisfiable instance and one unsatisfiable instance.
; -------------------------------

; ---------- SAT instance ----------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_label0_sat String)
(declare-const domain_label1_sat String)
(declare-const tld_sat String)
(declare-const rest_from_label1_sat String)
(declare-const local_dot_segments_sat Int)
(declare-const domain_dot_segments_sat Int)

; Split into local and domain by '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= 2 (num_splits email_sat "@")))

; Local-part must be non-empty and must not contain '@'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))

; Domain must be non-empty and must not contain '@'
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains domain_sat "@")))

; Domain must have at least one '.' and at least two labels (e.g., example.com)
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_dot_segments_sat (num_splits domain_sat ".")))

; First two labels and TLD extraction
(assert (= domain_label0_sat (split_at domain_sat "." 0)))
(assert (= domain_label1_sat (split_at domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- domain_dot_segments_sat 1))))

; Labels non-empty
(assert (> (str.len domain_label0_sat) 0))
(assert (> (str.len domain_label1_sat) 0))
(assert (>= (str.len tld_sat) 2))

; Constrain TLD to alphabetic lowercase only, length 2..6
(assert (<= (str.len tld_sat) 6))
(assert (str.in_re tld_sat (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))
(assert (str.in_re tld_sat (re.++ (re.range "a" "z") (re.++ (re.range "a" "z") (re.* (re.range "a" "z"))))))

; Local-part may include '.', but should not start or end with '.'
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Require at least 1 segment if split by '.' in local part (always true), but bound it to keep indices natural
(assert (>= (num_splits local_sat ".") 1))
(assert (= local_dot_segments_sat (num_splits local_sat ".")))

; Force a concrete example satisfying the constraints
(assert (= email_sat "alice.smith@example.co"))

; Use split_rest to relate remaining domain after the first label
(assert (= rest_from_label1_sat (split_rest domain_sat "." 1)))
(assert (str.contains rest_from_label1_sat tld_sat))

; ---------- UNSAT instance ----------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const domain_dot_segments_unsat Int)

; Basic email decomposition
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= 2 (num_splits email_unsat "@")))

; Domain must have at least two labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= domain_dot_segments_unsat (num_splits domain_unsat ".")))
(assert (= tld_unsat (split_at domain_unsat "." (- domain_dot_segments_unsat 1))))

; Impose conflicting requirements on the TLD to force UNSAT
(assert (>= (str.len tld_unsat) 2))
(assert (not (str.contains tld_unsat ".")))
(assert (= tld_unsat "com"))
(assert (= tld_unsat "net"))

; Also pin an example email to keep the instance grounded
(assert (= email_unsat "bob@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
