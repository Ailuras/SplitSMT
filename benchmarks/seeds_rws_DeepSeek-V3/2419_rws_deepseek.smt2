; SMT-LIB2 script for configuration parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic QF_S)

; Declare string constants for delimiters
(declare-const eq-delimiter String) ; '=' for key-value pairs
(declare-const colon-delimiter String) ; ':' alternative separator
(declare-const newline String) ; '\n' for line separation
(declare-const section-open String) ; '[' for section start
(declare-const section-close String) ; ']' for section end

(assert (= eq-delimiter "="))
(assert (= colon-delimiter ":"))
(assert (= newline "\n"))
(assert (= section-open "["))
(assert (= section-close "]"))

; Declare variables for configuration processing
(declare-const config-line String) ; A single configuration line
(declare-const ini-section String) ; An INI file section header
(declare-const full-config String) ; Complete configuration content
(declare-const key String) ; Configuration key
(declare-const value String) ; Configuration value

; ; Example 1: Simple key-value pair with '=' delimiter
(assert (= config-line "timeout=30"))
(assert (= key (str.split_at config-line eq-delimiter 0)))
(assert (= value (str.split_at config_line eq-delimiter 1)))
(assert (str.contains "abcdefghijklmnopqrstuvwxyz" (str.at key 0))) ; First char must be letter

; ; Example 2: Alternative key-value pair with ':' delimiter
(declare-const alt-config String)
(assert (= alt-config "port:8080"))
(assert (= (str.split_at alt-config colon-delimiter 0) "port"))
(assert (= (str.split_at alt-config colon-delimiter 1) "8080"))

; ; Example 3: INI section header validation
(assert (= ini-section "[database]"))
(assert (str.prefixof section-open ini-section))
(assert (str.suffixof section-close ini-section))
(assert (> (str.len ini-section) 2)) ; Must have content between brackets

; ; Example 4: Multi-line configuration parsing
(assert (= full-config (str.++ "[server]" newline "host=localhost" newline "port=8080")))
(assert (= (str.split_at full-config newline 0) "[server]"))
(assert (= (str.split_at full-config newline 1) "host=localhost"))
(assert (= (str.split_at full-config newline 2) "port=8080"))

; ; Example 5: Unsatisfiable constraints - invalid section format
(declare-const bad-section String)
(assert (= bad-section "database]")) ; Missing opening bracket
(assert (str.prefixof section-open bad-section)) ; This will make it unsatisfiable

; ; Example 6: Value extraction with split_rest
(declare-const long-value String)
(assert (= long-value "path=/usr/local/bin:/usr/bin:/bin"))
(assert (= (str.split_at long-value eq-delimiter 0) "path"))
(assert (= (str.split_rest long-value eq-delimiter 1) "/usr/local/bin:/usr/bin:/bin"))

; ; Example 7: Counting configuration items
(assert (= (str.num_splits full-config newline) 3)) ; [server], host, port
(assert (= (str.num_splits config-line eq-delimiter) 2)) ; key and value

; ; Example 8: Key validation constraints
(assert (not (str.contains key " "))) ; Keys cannot contain spaces
(assert (not (str.contains key eq-delimiter))) ; Keys cannot contain delimiters
(assert (not (str.contains key colon-delimiter)))

; ; Check satisfiability of all constraints
(check-sat)
(exit)