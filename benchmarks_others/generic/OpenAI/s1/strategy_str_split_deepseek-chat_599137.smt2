(set-logic ALL)

; --- Uninterpreted interface for string splitting ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed structure retained: Top/Bottom replacement maps ---
(declare-fun Top_0 () String)
(declare-fun Bottom_0 () String)
(assert (= Top_0 "110"))
(assert (= Bottom_0 "100"))
(declare-fun Top_1 () String)
(declare-fun Bottom_1 () String)
(assert (= Top_1 "110"))
(assert (= Bottom_1 "010"))
(declare-fun Top_2 () String)
(declare-fun Bottom_2 () String)
(assert (= Top_2 "100"))
(assert (= Bottom_2 "011"))

; --- Log analysis scenario variables ---
(declare-const raw_digits String)
(declare-const x_0 String)
(declare-const x_1 String)
(declare-const x_2 String)
(declare-const x String)
(declare-const y_0 String)
(declare-const y_1 String)
(declare-const y_2 String)
(declare-const y String)

(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const module String)
(declare-const message String)
(declare-const time_part String)
(declare-const date_part String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; raw digits: only 2/3/4, at least one char
(assert (str.in_re raw_digits (re.+ (re.union (str.to_re "2") (str.to_re "3") (str.to_re "4")))))

; Apply replacement chain (core structure preserved)
(assert (= x_0 raw_digits))
(assert (= y_0 raw_digits))
(assert (= x_1 (str.replace_all x_0 "2" Top_0)))
(assert (= x_2 (str.replace_all x_1 "3" Top_1)))
(assert (= x (str.replace_all x_2 "4" Top_2)))
(assert (= y_1 (str.replace_all y_0 "2" Bottom_0)))
(assert (= y_2 (str.replace_all y_1 "3" Bottom_1)))
(assert (= y (str.replace_all y_2 "4" Bottom_2)))

; Tie transformed content into a structured log line: "<ts> <level> <module>:<message>"
(assert (= log_line (str.++ x " " level " " module ":" message)))

; Split by spaces: [0]=timestamp, [1]=level, [2]=rest
(assert (>= (num_splits log_line " ") 3))
(assert (= ts (split_at log_line " " 0)))
(assert (= level (split_at log_line " " 1)))
(assert (= (split_rest log_line " " 2) (str.++ module ":" message)))

; Split the rest by colon into module and message
(assert (>= (num_splits (split_rest log_line " " 2) ":") 2))
(assert (= module (split_at (split_rest log_line " " 2) ":" 0)))
(assert (= message (split_rest (split_rest log_line " " 2) ":" 1)))

; Timestamp format validation: "YYYY-MM-DD:HH:MM:SS" (length 19, with fixed separators)
(assert (= (str.len ts) 19))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) ":"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= date_part (str.substr ts 0 10)))
(assert (= time_part (str.substr ts 11 8)))
(assert (= hour (str.substr ts 11 2)))
(assert (= minute (str.substr ts 14 2)))
(assert (= second (str.substr ts 17 2)))

; Log level extraction/validation: must be one of a few known strings
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Module must be non-empty and contain no spaces
(assert (>= (str.len module) 1))
(assert (not (str.contains module " ")))

; Message must be non-empty
(assert (>= (str.len message) 1))

; Connect x/y and timestamp to preserve seed intent but adapted to log parsing
(assert (= x y))
(assert (= ts x))

; --- Create an UNSAT twist: hour is forced to be a non-digit sequence but also equals first two chars of ts ---
; Since ts=x is built only from '1' and '0' digits (after replacement), this forces a contradiction.
(assert (str.in_re hour (re.+ (str.to_re "X"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
