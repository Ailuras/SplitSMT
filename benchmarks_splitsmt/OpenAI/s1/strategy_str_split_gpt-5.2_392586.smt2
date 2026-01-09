(set-logic ALL)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; Core checks: timestamp format validation and log level extraction.

; --- split interface (uninterpreted) ---

; --- variables ---
(declare-const X String)            ; entire log line
(declare-const ts String)           ; timestamp field
(declare-const level_tag String)    ; e.g., "INFO:" (includes colon)
(declare-const level String)        ; extracted level without colon
(declare-const msg String)          ; message remainder
(declare-const src_tag String)      ; e.g., "src:auth"
(declare-const src_key String)
(declare-const src_val String)
(declare-const pid_tag String)      ; e.g., "pid:1234"
(declare-const pid_str String)

; --- tokenization by spaces ---
(assert (>= (str.num_splits X " ") 4))
(assert (= ts (str.split_at X " " 0)))
(assert (= level_tag (str.split_at X " " 1)))
(assert (= src_tag (str.split_at X " " 2)))
(assert (= pid_tag (str.split_at X " " 3)))
(assert (= msg (str.split_rest X " " 4)))

; --- timestamp validation: YYYY-MM-DDTHH:MM:SSZ ---
(assert (str.in_re ts
  (re.++
    ((_ re.loop 4 4) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "T")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "Z"))))

; --- log level extraction and validation ---
(assert (str.in_re level_tag (re.++ (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG")) (str.to_re ":"))))
(assert (= level (str.split_at level_tag ":" 0)))
(assert (= "" (str.split_at level_tag ":" 1)))
(assert (>= (str.num_splits level_tag ":") 2))

; --- key:value parsing for src and pid ---
(assert (= src_key (str.split_at src_tag ":" 0)))
(assert (= src_val (str.split_at src_tag ":" 1)))
(assert (= src_key "src"))
(assert (>= (str.num_splits src_tag ":") 2))
(assert (str.in_re src_val (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-")))))

(assert (= (str.split_at pid_tag ":" 0) "pid"))
(assert (= pid_str (str.split_at pid_tag ":" 1)))
(assert (>= (str.num_splits pid_tag ":") 2))
(assert (str.in_re pid_str ((_ re.loop 1 6) (re.range "0" "9"))))

; --- message sanity checks ---
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "User-Agent:")))

; preserve seed-style negative constraints (mutated for log context)
(assert (not (str.in_re X (re.++ (str.to_re "www.ezula.com") (re.* re.allchar) (str.to_re "FTP") (re.* re.allchar) (str.to_re "User-Agent:containsw3whoreport\u{a}")))))

; UNSAT twist: force contradictory level requirements
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
