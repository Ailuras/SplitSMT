(set-logic ALL)

; Uninterpreted split interface

; ---------- SAT instance: well-formed log line ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const rest1_sat String)
(declare-const level_sat String)
(declare-const module_sat String)
(declare-const message_sat String)
(declare-const yyyy_sat String)
(declare-const mm_sat String)
(declare-const dd_sat String)
(declare-const hh_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Structure: "YYYY-MM-DD HH:MM:SS LEVEL module: message..."
(assert (= ts_sat (str.split_at log_line_sat " " 0)))
(assert (= rest1_sat (str.split_rest log_line_sat " " 1)))
(assert (= level_sat (str.split_at rest1_sat " " 0)))
(assert (= module_sat (str.split_at rest1_sat " " 1)))
(assert (= message_sat (str.split_rest rest1_sat " " 2)))

; Ensure enough fields
(assert (>= (str.num_splits log_line_sat " ") 4))
(assert (>= (str.num_splits rest1_sat " ") 3))

; Timestamp token is "YYYY-MM-DD" and "HH:MM:SS" joined by 'T' to validate via regex
(assert (= (str.len ts_sat) 19))
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) " "))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

(assert (= yyyy_sat (str.substr ts_sat 0 4)))
(assert (= mm_sat   (str.substr ts_sat 5 2)))
(assert (= dd_sat   (str.substr ts_sat 8 2)))
(assert (= hh_sat   (str.substr ts_sat 11 2)))
(assert (= min_sat  (str.substr ts_sat 14 2)))
(assert (= sec_sat  (str.substr ts_sat 17 2)))

; Regex digit helper
(define-fun is2d ((s String)) Bool (str.in_re s (re.++ (re.range "0" "9") (re.range "0" "9"))))
(define-fun is4d ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))

(assert (is4d yyyy_sat))
(assert (is2d mm_sat))
(assert (is2d dd_sat))
(assert (is2d hh_sat))
(assert (is2d min_sat))
(assert (is2d sec_sat))

; Constrain log level extraction
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Module token must contain a colon and be of form "name:" with no spaces
(assert (str.contains module_sat ":"))
(assert (= (str.split_at module_sat ":" 1) ""))
(assert (>= (str.len (str.split_at module_sat ":" 0)) 1))

; Message exists and does not start with a space
(assert (>= (str.len message_sat) 1))
(assert (not (= (str.at message_sat 0) " ")))

; Provide a concrete satisfying example
(assert (= log_line_sat "2025-12-31 23:59:58 INFO auth: user login ok"))


; ---------- UNSAT instance: contradictory timestamp/level constraints ----------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const rest1_unsat String)
(declare-const level_unsat String)
(declare-const module_unsat String)
(declare-const message_unsat String)

(assert (= ts_unsat (str.split_at log_line_unsat " " 0)))
(assert (= rest1_unsat (str.split_rest log_line_unsat " " 1)))
(assert (= level_unsat (str.split_at rest1_unsat " " 0)))
(assert (= module_unsat (str.split_at rest1_unsat " " 1)))
(assert (= message_unsat (str.split_rest rest1_unsat " " 2)))

(assert (>= (str.num_splits log_line_unsat " ") 4))

; Force an invalid timestamp length but simultaneously require 19
(assert (= (str.len ts_unsat) 19))
(assert (= ts_unsat "2025-12-31"))

; Contradictory level constraints
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

; Also enforce module format
(assert (str.contains module_unsat ":"))
(assert (= (str.split_at module_unsat ":" 1) ""))
(assert (>= (str.len message_unsat) 0))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
