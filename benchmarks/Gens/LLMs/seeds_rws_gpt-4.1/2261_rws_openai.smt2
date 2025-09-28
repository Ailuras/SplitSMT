(set-info :smt-lib-version 2.6)
(set-logic QF_SLIA)
(set-info :source |
Email address validation with split constraints
SMT-LIB2 file generated for real-world string splitting scenarios
|)

; Declare the email string variable
(declare-const em String)

; Split em at '@': should yield exactly 2 segments (local and domain)
(assert (= (str.num_splits em "@") 2))

; ; Extract the domain part (after '@')
(declare-const dom String)
(assert (= dom (str.split_at em "@" 1)))

; The domain must not start or end with '.'
(assert (not (= (str.at dom 0) ".")))
(assert (not (= (str.at dom (- (str.len dom) 1)) ".")))

; ; The domain must have exactly two segments when split at '.' (e.g., "example.com")
(assert (= (str.num_splits dom ".") 2))

; ; Extract the TLD (last segment after '.')
(declare-const tld String)
(assert (= tld (str.split_at dom "." 1)))

; The TLD must be at least 2 characters (e.g., "com", "org")
(assert (>= (str.len tld) 2))

; The local-part (before '@') must contain at least one character and must not contain '.'
(declare-const local String)
(assert (= local (str.split_at em "@" 0)))
(assert (> (str.len local) 0))
(assert (not (str.contains local ".")))

; ; Unsatisfiable constraint: The TLD must be "co" and "uk" at the same time (contradiction)
(assert (= tld "co"))
(assert (= tld "uk"))

(check-sat)
(exit)