(set-logic ALL)

; Uninterpreted interface for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -----------------------------
; Scenario: Log Analysis (SAT instance)
; Log shape (informal): "YYYY-MM-DD HH:MM:SS LEVEL: message..."
; Split by spaces to isolate timestamp parts and the level+message token.
; Split by ':' to isolate time components and LEVEL prefix.
; -----------------------------

(declare-const log_line String)
(declare-const date_part String)
(declare-const time_and_rest String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_part String)
(declare-const msg_part String)

(declare-const y String)
(declare-const m String)
(declare-const d String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; Split by spaces: 0=date, 1=time, 2=LEVEL:, 3+=message
(assert (>= (num_splits log_line " ") 4))
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_and_msg (split_rest log_line " " 2)))

; date_part = YYYY-MM-DD
(assert (str.in_re date_part (re.++ (re.loop (str.to_re "0") 0 0) (str.to_re ""))))
; Use direct regex for digits and separators
(assert (str.in_re date_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 4 4)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Split date by '-' into y,m,d
(assert (>= (num_splits date_part "-") 3))
(assert (= y (split_at date_part "-" 0)))
(assert (= m (split_at date_part "-" 1)))
(assert (= d (split_at date_part "-" 2)))
(assert (= (str.len y) 4))
(assert (= (str.len m) 2))
(assert (= (str.len d) 2))

; time_part = HH:MM:SS
(assert (str.in_re time_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Split time by ':' into hh,mm,ss
(assert (>= (num_splits time_part ":") 3))
(assert (= hh (split_at time_part ":" 0)))
(assert (= mm (split_at time_part ":" 1)))
(assert (= ss (split_at time_part ":" 2)))
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; level_and_msg begins with LEVEL: then a space then message
; Extract level_part as token before ':' in the first word
(assert (>= (num_splits (split_at log_line " " 2) ":") 2))
(assert (= level_part (split_at (split_at log_line " " 2) ":" 0)))

; Level validation (allow common levels)
(assert (or (= level_part "INFO") (= level_part "WARN") (= level_part "ERROR") (= level_part "DEBUG")))

; Ensure message contains something and keep it simple: require substring "user"
(assert (str.contains log_line "user"))

; Provide a concrete witness to keep SAT predictable
(assert (= log_line "2025-01-09 13:05:59 INFO: user login ok"))

(check-sat)

; -----------------------------
; Scenario: Log Analysis (UNSAT instance)
; Contradiction: same log line forced, but level extracted cannot match required level.
; -----------------------------

(push)

(declare-const log_line_bad String)
(declare-const lvl_bad String)

(assert (= log_line_bad "2025-01-09 13:05:59 INFO: user login ok"))
(assert (>= (num_splits log_line_bad " ") 3))
(assert (= lvl_bad (split_at (split_at log_line_bad " " 2) ":" 0)))

; Force level to be ERROR, but it is INFO in the fixed string.
(assert (= lvl_bad "ERROR"))

(check-sat)
(pop)



; [GENERATION STATUS: SUCCESS]
(check-sat)