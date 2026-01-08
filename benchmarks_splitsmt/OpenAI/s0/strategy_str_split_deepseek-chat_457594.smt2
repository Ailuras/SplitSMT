(set-logic ALL)

; Uninterpreted interface for string split methodology

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Example shape (conceptual):
;   YYYY-MM-DD HH:MM:SS:LEVEL message...
; =========================

; ---------- SAT instance ----------
(declare-const log_line String)
(declare-const token0 String) ; date
(declare-const token1 String) ; time:level
(declare-const token2 String) ; message remainder (first word)
(declare-const rest_after2 String)

(declare-const date String)
(declare-const time_level String)
(declare-const time_str String)
(declare-const level_str String)
(declare-const message_str String)

; Split by spaces: require at least 3 tokens: date, time:level, message...
(assert (>= (str.num_splits log_line " ") 3))
(assert (= token0 (str.split_at log_line " " 0)))
(assert (= token1 (str.split_at log_line " " 1)))
(assert (= token2 (str.split_at log_line " " 2)))
(assert (= rest_after2 (str.split_rest log_line " " 2)))

; token0 is the date
(assert (= date token0))

; token1 is "HH:MM:SS:LEVEL" split by ':'
(assert (= time_level token1))
(assert (>= (str.num_splits time_level ":") 4))
(assert (= time_str (str.++ (str.split_at time_level ":" 0) ":" (str.split_at time_level ":" 1) ":" (str.split_at time_level ":" 2))))
(assert (= level_str (str.split_at time_level ":" 3)))

; message starts at token2 and continues
(assert (= message_str rest_after2))

; Date format validation: YYYY-MM-DD
(assert (= (str.len date) 10))
(assert (= (str.at date 4) "-"))
(assert (= (str.at date 7) "-"))
(assert (str.in_re date (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; Time format validation: HH:MM:SS (basic digits/colons + ranges on HH, MM, SS)
(assert (= (str.len time_str) 8))
(assert (= (str.at time_str 2) ":"))
(assert (= (str.at time_str 5) ":"))
(assert (str.in_re time_str (re.++ (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re ":")
                                   (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re ":")
                                   (re.loop (re.range "0" "9") 2 2))))

; Tighten time ranges (without numeric conversion):
; HH in 00-23
(assert (or (= (str.at time_str 0) "0")
            (= (str.at time_str 0) "1")
            (= (str.at time_str 0) "2")))
(assert (or (and (= (str.at time_str 0) "2") (or (= (str.at time_str 1) "0")
                                                  (= (str.at time_str 1) "1")
                                                  (= (str.at time_str 1) "2")
                                                  (= (str.at time_str 1) "3")))
            (and (or (= (str.at time_str 0) "0") (= (str.at time_str 0) "1"))
                 (str.in_re (str.at time_str 1) (re.range "0" "9")))))

; MM and SS in 00-59
(assert (or (= (str.at time_str 3) "0")
            (= (str.at time_str 3) "1")
            (= (str.at time_str 3) "2")
            (= (str.at time_str 3) "3")
            (= (str.at time_str 3) "4")
            (= (str.at time_str 3) "5")))
(assert (or (= (str.at time_str 6) "0")
            (= (str.at time_str 6) "1")
            (= (str.at time_str 6) "2")
            (= (str.at time_str 6) "3")
            (= (str.at time_str 6) "4")
            (= (str.at time_str 6) "5")))
(assert (str.in_re (str.at time_str 4) (re.range "0" "9")))
(assert (str.in_re (str.at time_str 7) (re.range "0" "9")))

; Log level extraction: constrain to common levels
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message must be non-empty and should not contain ':' in its first token (simple heuristic)
(assert (> (str.len message_str) 0))
(assert (not (str.contains token2 ":")))

; Provide a concrete satisfying structure (still leaves freedom for other parts)
(assert (str.prefixof "2025-01-" date))
(assert (= (str.at date 8) "0"))
(assert (= (str.at date 9) "7"))
(assert (= time_str "12:34:56"))
(assert (= level_str "INFO"))
(assert (str.contains message_str "request"))

; ---------- UNSAT instance (separate set of vars) ----------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time_level String)
(declare-const bad_time_str String)
(declare-const bad_level_str String)

; Basic parsing constraints
(assert (>= (str.num_splits bad_log_line " ") 2))
(assert (= bad_date (str.split_at bad_log_line " " 0)))
(assert (= bad_time_level (str.split_at bad_log_line " " 1)))
(assert (>= (str.num_splits bad_time_level ":") 4))
(assert (= bad_time_str (str.++ (str.split_at bad_time_level ":" 0) ":" (str.split_at bad_time_level ":" 1) ":" (str.split_at bad_time_level ":" 2))))
(assert (= bad_level_str (str.split_at bad_time_level ":" 3)))

; Contradictory timestamp constraints: enforce both a strict date regex AND wrong fixed separators
(assert (= (str.len bad_date) 10))
(assert (= (str.at bad_date 4) "-")
)
(assert (= (str.at bad_date 7) "-"))
(assert (str.in_re bad_date (re.++ (re.loop (re.range "0" "9") 4 4)
                                   (str.to_re "-")
                                   (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re "-")
                                   (re.loop (re.range "0" "9") 2 2))))
; Force an impossible character at a fixed digit position
(assert (= (str.at bad_date 0) "X"))

; Also add contradictory log-level constraints
(assert (or (= bad_level_str "INFO") (= bad_level_str "WARN")))
(assert (= bad_level_str "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
