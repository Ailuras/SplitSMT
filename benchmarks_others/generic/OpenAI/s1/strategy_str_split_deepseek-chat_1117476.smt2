(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Log entry parsing scenario: "YYYY-MM-DD:HH:MM:SS LEVEL message..."
(declare-const log_entry String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const timepart String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Keep core structure from seed with mutated variable
(declare-fun var_4 () String)
(declare-const v Int)

; Base split structure: timestamp, level, rest
(assert (= ts (split_at log_entry " " 0)))
(assert (= level (split_at log_entry " " 1)))
(assert (= msg (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Timestamp is split by ':' into date and time
(assert (= year (split_at ts "-" 0)))
(assert (= month (split_at ts "-" 1)))
(assert (= day (split_at ts "-" 2)))
(assert (>= (num_splits ts "-") 3))
(assert (= timepart (split_rest ts "-" 3)))
(assert (= hour (split_at timepart ":" 0)))
(assert (= minute (split_at timepart ":" 1)))
(assert (= second (split_at timepart ":" 2)))
(assert (>= (num_splits timepart ":") 3))

; Regex building blocks
(declare-const digitRE RegLan)
(declare-const twoDigitsRE RegLan)
(declare-const fourDigitsRE RegLan)
(assert (= digitRE (re.range "0" "9")))
(assert (= twoDigitsRE (re.++ digitRE digitRE)))
(assert (= fourDigitsRE (re.++ twoDigitsRE twoDigitsRE)))

; Timestamp format validation: YYYY-MM-DD:HH:MM:SS
(assert (str.in_re year fourDigitsRE))
(assert (str.in_re month twoDigitsRE))
(assert (str.in_re day twoDigitsRE))
(assert (str.in_re hour twoDigitsRE))
(assert (str.in_re minute twoDigitsRE))
(assert (str.in_re second twoDigitsRE))
(assert (= (str.len ts) 19))

; Log level extraction/validation
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message must be non-empty and contain a colon somewhere (structured key:value)
(assert (> (str.len msg) 0))
(assert (str.contains msg ":"))

; Mutated seed-style constraints over var_4 and v
(assert (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (re.++ (str.to_re "b") (re.* (str.to_re "b"))))))
(assert (str.in_re var_4 (re.++ (str.to_re "a") (re.* (str.to_re "b")))))
(assert (str.in_re var_4 (re.++ (re.* (str.to_re "a")) (str.to_re "b"))))
(assert (str.in_re var_4 (re.* (re.range "a" "u"))))

; Tie var_4 to message prefix to preserve core structure while adapting to log analysis
(assert (str.contains msg var_4))
(assert (and (<= 0 (str.len var_4)) (= (* v 2) (+ (str.len var_4) 2))))

; Make this instance UNSAT by contradicting allowed log levels
(assert (not (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
