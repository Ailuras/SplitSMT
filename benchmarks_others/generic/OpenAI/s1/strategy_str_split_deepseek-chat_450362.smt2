(set-logic ALL)

; Uninterpreted interface for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables retained
(declare-const var_7 String)
(declare-const var_8 String)

; Log analysis specific variables
(declare-const log_entry String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const rest_after_level String)
(declare-const host String)

; --- Mutated/extended seed core constraints ---
(assert (str.in_re (str.++ var_7 "z" var_8)
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                           (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))
(assert (str.in_re var_8 (re.* (re.range "a" "u"))))
(assert (str.in_re var_7 (re.* (re.range "a" "u"))))
(assert (<= 0 (str.len var_8)))

; Connect seed vars into the log entry to preserve core structure while changing scenario
; Use var_7 and var_8 as a constrained "host" token appearing later in the log.
(assert (= host (str.++ var_7 "z" var_8)))

; --- Log parsing via split operations ---
; Expected format (space-separated tokens):
;   <timestamp> <level>: <message> host=<host>
(assert (= ts (split_at log_entry " " 0)))
(assert (= level (split_at log_entry " " 1)))
(assert (= rest_after_level (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; level token ends with ':' and is one of INFO/WARN/ERROR/DEBUG
(assert (str.in_re level (re.union (str.to_re "INFO:")
                           (re.union (str.to_re "WARN:")
                           (re.union (str.to_re "ERROR:")
                                    (str.to_re "DEBUG:"))))))

; message is the rest after the first two tokens
(assert (= message rest_after_level))
(assert (>= (str.len message) 1))

; Require that the message contains the host marker and that it uses the seed-derived host
(assert (str.contains message "host="))
(assert (str.contains message (str.++ "host=" host)))

; --- Timestamp format validation ---
; Timestamp expected: YYYY-MM-DD:HH:MM:SS
(assert (= date_part (split_at ts ":" 0)))
(assert (= time_part (split_rest ts ":" 1)))
(assert (= year (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day (split_at date_part "-" 2)))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))

(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only constraints for timestamp components
(assert (str.in_re year (re.++ (re.range "0" "9")
                               (re.++ (re.range "0" "9")
                                      (re.++ (re.range "0" "9")
                                             (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Colons check: exactly 3 segments when splitting timestamp by ':'
(assert (= (num_splits ts ":") 4))

; Additional sanity: timestamp must not contain spaces
(assert (not (str.contains ts " ")))

; --- Create an UNSAT core by contradicting timestamp delimiter expectations ---
; If date_part is derived by splitting on ':', it must not itself contain ':'
(assert (not (str.contains date_part ":")))
; Contradiction: force date_part to contain ':'
(assert (str.contains date_part ":"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
