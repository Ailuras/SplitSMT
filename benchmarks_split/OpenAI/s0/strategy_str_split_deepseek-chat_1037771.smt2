(set-logic ALL)

; Interface: str_split (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Log Analysis Scenario ---
; We model parsing of structured server log entries separated by spaces and colons.
; Example intended shape:
;   "YYYY-MM-DD HH:MM:SS LEVEL: message..."

; ---------- Shared declarations ----------
(declare-const log_line String)
(declare-const date_part String)
(declare-const time_and_rest String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_token String)
(declare-const msg_part String)

(declare-const y String)
(declare-const m String)
(declare-const d String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

(declare-const ts String)

; ---------- Structural splitting constraints ----------
; Split by single space: [date] [time] [LEVEL:] [message...]
(assert (>= (num_splits log_line " ") 4))
(assert (= date_part (split_at log_line " " 0)))
(assert (= time_part (split_at log_line " " 1)))
(assert (= level_and_msg (split_rest log_line " " 2)))

; In the remainder starting at token 2, split by space to isolate LEVEL: and the rest message
(assert (>= (num_splits level_and_msg " ") 2))
(assert (= level_token (split_at level_and_msg " " 0)))
(assert (= msg_part (split_rest level_and_msg " " 1)))

; LEVEL token is of the form LEVEL:
(assert (>= (num_splits level_token ":") 2))
(assert (= (split_at level_token ":" 1) ""))

; timestamp string reconstruction
(assert (= ts (str.++ date_part (str.++ " " time_part))))

; ---------- Timestamp format validation (length + digit checks) ----------
; YYYY-MM-DD
(assert (= (str.len date_part) 10))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (= y (str.substr date_part 0 4)))
(assert (= m (str.substr date_part 5 2)))
(assert (= d (str.substr date_part 8 2)))

; HH:MM:SS
(assert (= (str.len time_part) 8))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= hh (str.substr time_part 0 2)))
(assert (= mm (str.substr time_part 3 2)))
(assert (= ss (str.substr time_part 6 2)))

; Digit-only checks via regex membership for subfields
(assert (str.in_re y (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re m (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re d (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Whole timestamp matches: YYYY-MM-DD HH:MM:SS
(assert (str.in_re ts
  (re.++
    (re.++
      (re.++
        (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))
        (str.to_re "-"))
      (re.++ (re.++ (re.range "0" "9") (re.range "0" "9")) (str.to_re "-")))
    (re.++
      (re.++ (re.range "0" "9") (re.range "0" "9"))
      (re.++
        (str.to_re " ")
        (re.++
          (re.++ (re.++ (re.range "0" "9") (re.range "0" "9")) (str.to_re ":"))
          (re.++
            (re.++ (re.++ (re.range "0" "9") (re.range "0" "9")) (str.to_re ":"))
            (re.++ (re.range "0" "9") (re.range "0" "9")))))))))

; ---------- Log level extraction and validation ----------
(declare-const level String)
(assert (= level (split_at level_token ":" 0)))
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message should be non-empty and contain at least one alphabetic character (simple regex)
(assert (> (str.len msg_part) 0))
(assert (str.in_re msg_part (re.++ (re.* re.allchar) (re.++ (re.range "A" "Z") (re.* re.allchar)))))

; ---------- Additional semantic checks (still SAT) ----------
; Ensure there is no extra colon in level_token besides the trailing one (relaxed: at most 2 segments)
(assert (<= (num_splits level_token ":") 2))

; Require the overall line to start with the date_part (consistency)
(assert (str.prefixof date_part log_line))

; ---------- Separate UNSAT instance (independent) ----------
; We include an isolated set of constraints that is intentionally UNSAT.
(declare-const bad_line String)
(declare-const bad_level_token String)
(declare-const bad_level String)
(assert (= bad_level_token (split_at bad_line " " 2)))
(assert (= bad_level (split_at bad_level_token ":" 0)))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]