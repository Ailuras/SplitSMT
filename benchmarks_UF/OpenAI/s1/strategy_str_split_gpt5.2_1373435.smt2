(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

(declare-const log String)
(declare-const timestamp String)
(declare-const level String)
(declare-const module String)
(declare-const message String)
(declare-const time_part String)
(declare-const date_part String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const log_bad String)
(declare-const bad_timestamp String)
(declare-const bad_level String)

; str_split interface

; Core structure: split by spaces and colons
(assert (>= (num_splits log " ") 4))
(assert (= timestamp (split_at log " " 0)))
(assert (= level (split_at log " " 1)))
(assert (= module (split_at log " " 2)))
(assert (= message (split_rest log " " 3)))

; Module is of the form "name:" and message continues after it
(assert (str.suffixof ":" module))

; Timestamp split: "YYYY-MM-DDTHH:MM:SS"
(assert (= 19 (str.len timestamp)))
(assert (= "T" (str.substr timestamp 10 1)))
(assert (= "-" (str.substr timestamp 4 1)))
(assert (= "-" (str.substr timestamp 7 1)))
(assert (= ":" (str.substr timestamp 13 1)))
(assert (= ":" (str.substr timestamp 16 1)))

; Validate timestamp digits via regex
(assert (str.in_re timestamp (re.++
  (re.loop (re.range "0" "9") 4 4)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "T")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2))))

; Extract time part via split_at on 'T' then ':'
(assert (= date_part (split_at timestamp "T" 0)))
(assert (= time_part (split_at timestamp "T" 1)))
(assert (>= (num_splits timestamp "T") 2))
(assert (>= (num_splits time_part ":") 3))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))
(assert (= 2 (str.len hour)))
(assert (= 2 (str.len minute)))
(assert (= 2 (str.len second)))

; Log level extraction: constrain to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message non-empty and should not start with a space (since split_rest uses original spacing)
(assert (>= (str.len message) 1))
(assert (not (= (str.at message 0) " ")))

; Also add a simple seed-mutation-like constraint relating content
; Ensure module (without colon) appears somewhere in message, by requiring module prefix before ':' is contained.
(declare-const module_name String)
(assert (= module_name (str.substr module 0 (- (str.len module) 1))))
(assert (str.contains message module_name))

; Second instance: deliberately UNSAT by contradicting level constraints
(assert (>= (num_splits log_bad " ") 4))
(assert (= bad_timestamp (split_at log_bad " " 0)))
(assert (= bad_level (split_at log_bad " " 1)))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Still keep timestamp-looking constraints for bad_timestamp
(assert (= 19 (str.len bad_timestamp)))
(assert (str.in_re bad_timestamp (re.++
  (re.loop (re.range "0" "9") 4 4)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "T")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
