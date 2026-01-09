(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Core log line
(declare-const X String)

; Split interface (uninterpreted as per methodology)

; Derived fields
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const rest_after_ts String)
(declare-const lvl_and_msg String)
(declare-const x_contains_forbidden Bool)

; Seed constraint preserved (mutated: still forbids membership in a specific singleton regex)
(assert (not (str.in_re X (str.to_re "DmInf^\u{d}\u{a}\u{d}\u{a}Attached/bar_pl/chk.fcgi\u{a}"))))

; Basic structure: "<timestamp> <level>: <message>"
(assert (>= (str.num_splits X " ") 3))
(assert (= ts (str.split_at X " " 0)))
(assert (= level (str.split_at X " " 1)))
(assert (= rest_after_ts (str.split_rest X " " 1)))
(assert (= lvl_and_msg (str.split_rest X " " 1)))

; Expect at least one colon after the level (e.g., "INFO:")
(assert (>= (str.num_splits lvl_and_msg ":") 2))
(assert (= msg (str.split_rest lvl_and_msg ":" 1)))

; Timestamp format validation: YYYY-MM-DDThh:mm:ss
(assert (>= (str.num_splits ts "T") 2))
(assert (= date (str.split_at ts "T" 0)))
(assert (= time (str.split_at ts "T" 1)))

(assert (= 10 (str.len date)))
(assert (= 8 (str.len time)))
(assert (= "-" (str.at date 4)))
(assert (= "-" (str.at date 7)))
(assert (= ":" (str.at time 2)))
(assert (= ":" (str.at time 5)))

(assert (>= (str.num_splits date "-") 3))
(assert (= year (str.split_at date "-" 0)))
(assert (= month (str.split_at date "-" 1)))
(assert (= day (str.split_at date "-" 2)))
(assert (= 4 (str.len year)))
(assert (= 2 (str.len month)))
(assert (= 2 (str.len day)))

(assert (>= (str.num_splits time ":") 3))
(assert (= hour (str.split_at time ":" 0)))
(assert (= minute (str.split_at time ":" 1)))
(assert (= second (str.split_at time ":" 2)))
(assert (= 2 (str.len hour)))
(assert (= 2 (str.len minute)))
(assert (= 2 (str.len second)))

; Allowed levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should not contain a forbidden path fragment (typical log sanitization check)
(assert (= x_contains_forbidden (str.contains X "Attached/bar_pl/chk.fcgi")))
(assert (not x_contains_forbidden))

; ---------------------------
; Additional UNSAT branch to ensure diversity: if level is ERROR then msg must contain "panic",
; but also forbid "panic" globally in the message.
; This makes the whole instance UNSAT when combined with (level="ERROR").
; Force level to ERROR to activate the contradiction.
(assert (= level "ERROR"))
(assert (=> (= level "ERROR") (str.contains msg "panic")))
(assert (not (str.contains msg "panic")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
