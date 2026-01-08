(set-logic ALL)

; Uninterpreted interface operations for string split reasoning
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; ----------------------------
; SAT instance: well-formed log entry parsing
; Format (space-separated):
;   <timestamp> <level>:<component> <message>
; Example shape:
;   2026-01-07T12:34:56Z INFO:Auth user login
; ----------------------------
(declare-const log_line String)
(declare-const ts String)
(declare-const lvl_comp String)
(declare-const msg String)
(declare-const lvl String)
(declare-const comp String)
(declare-const rest_after_ts String)
(declare-const rest_after_lvlcomp String)

; Split by spaces into at least 3 tokens
(assert (= ts (split_at log_line " " 0)))
(assert (= lvl_comp (split_at log_line " " 1)))
(assert (= msg (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))
(assert (>= (str.len ts) 1))
(assert (>= (str.len lvl_comp) 1))
(assert (>= (str.len msg) 1))

; Define rest portions for additional consistency checks
(assert (= rest_after_ts (split_rest log_line " " 1)))
(assert (= rest_after_lvlcomp (split_rest log_line " " 2)))
(assert (= rest_after_ts (str.++ lvl_comp " " rest_after_lvlcomp)))
(assert (= log_line (str.++ ts " " rest_after_ts)))

; Parse the <level>:<component> token by ':'
(assert (= lvl (split_at lvl_comp ":" 0)))
(assert (= comp (split_at lvl_comp ":" 1)))
(assert (>= (num_splits lvl_comp ":") 2))
(assert (>= (str.len lvl) 1))
(assert (>= (str.len comp) 1))

; Allowed levels
(assert (or (= lvl "INFO") (= lvl "WARN") (= lvl "ERROR") (= lvl "DEBUG")))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SSZ
; Use regex for shape checking
(declare-const ts_re RegLan)
(assert (= ts_re (re.++
  (re.loop (str.to_re "0") 4 4)
  (str.to_re "-")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "-")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "T")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re ":")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re ":")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "Z"))))

; Stronger: digit classes via union of single digits
(declare-const DIGIT RegLan)
(assert (= DIGIT (re.union
  (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
  (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))

(declare-const ts_re2 RegLan)
(assert (= ts_re2 (re.++
  (re.loop DIGIT 4 4)
  (str.to_re "-")
  (re.loop DIGIT 2 2)
  (str.to_re "-")
  (re.loop DIGIT 2 2)
  (str.to_re "T")
  (re.loop DIGIT 2 2)
  (str.to_re ":")
  (re.loop DIGIT 2 2)
  (str.to_re ":")
  (re.loop DIGIT 2 2)
  (str.to_re "Z"))))

; Enforce timestamp matches regex (ts_re2 used; ts_re kept for diversity)
(assert (str.in_re ts ts_re2))
(assert (= (str.len ts) 20))

; Additional sanity checks about separators in timestamp
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

; Component should be alphabetic-ish (simple constraint: contains no spaces/colons)
(assert (not (str.contains comp " ")))
(assert (not (str.contains comp ":")))

; Message should not contain the raw token delimiter pattern for level/component at start
(assert (not (= msg "")))

; Ensure overall line contains expected delimiters
(assert (str.contains log_line " "))
(assert (str.contains lvl_comp ":"))

; Provide at least one concrete witness pattern to keep SAT easy
(assert (= log_line "2026-01-07T12:34:56Z INFO:Auth user login"))

; ----------------------------
; UNSAT instance: contradictory constraints about log level and tokenization
; ----------------------------
(declare-const bad_line String)
(declare-const bad_ts String)
(declare-const bad_lvlcomp String)
(declare-const bad_lvl String)
(declare-const bad_comp String)

(assert (= bad_ts (split_at bad_line " " 0)))
(assert (= bad_lvlcomp (split_at bad_line " " 1)))
(assert (>= (num_splits bad_line " ") 2))

(assert (= bad_lvl (split_at bad_lvlcomp ":" 0)))
(assert (= bad_comp (split_at bad_lvlcomp ":" 1)))
(assert (>= (num_splits bad_lvlcomp ":") 2))

; Require bad_lvl to be INFO and also not equal to INFO -> UNSAT core
(assert (= bad_lvl "INFO"))
(assert (not (= bad_lvl "INFO")))

; Also add a conflicting timestamp constraint for diversity
(assert (str.in_re bad_ts ts_re2))
(assert (= (str.len bad_ts) 19))

(check-sat)


; [GENERATION STATUS: SUCCESS]
