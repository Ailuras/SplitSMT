
; SMT-LIB2 file for configuration parsing with key-value pairs and INI file processing
(set-logic QF_S)

; Declare string constants for delimiters
(declare-const equals String)
(assert (= equals "="))
(declare-const colon String)
(assert (= colon ":"))
(declare-const newline String)
(assert (= newline "\n"))
(declare-const open_bracket String)
(assert (= open_bracket "["))
(declare-const close_bracket String)
(assert (= close_bracket "]"))

; Declare variables for configuration parsing
(declare-const config_line String)
(declare-const ini_section String)
(declare-const key String)
(declare-const value String)
(declare-const full_config String)

; ; Example 1: Simple key-value pair parsing with '=' delimiter
(assert (= config_line "port=8080"))
(assert (= key (str.split_at config_line equals 0)))
(assert (= value (str.split_at config_line equals 1)))
(assert (str.contains "abcdefghijklmnopqrstuvwxyz" (str.at key 0))) ; Key must start with letter

; ; Example 2: Alternative key-value pair with ':' delimiter
(declare-const alt_config_line String)
(assert (= alt_config_line "timeout:30"))
(assert (or 
 (= (str.split_at alt_config_line equals 0) alt_config_line) ; No '=' in string
 (= value (str.split_at alt_config_line colon 1))
))

; ; Example 3: INI section handling
(assert (= ini_section "[database]"))
(assert (str.prefixof open_bracket ini_section))
(assert (str.suffixof close_bracket ini_section))
(assert (= (str.split_at ini_section open_bracket 1) "database]"))

; ; Example 4: Multi-line configuration parsing
(assert (= full_config (str.++ "[server]" newline "host=localhost" newline "port=8080" newline)))
(assert (> (str.num_splits full_config newline) 2)) ; Must have at least 2 config lines
(assert (str.contains (str.split_at full_config newline 1) open_bracket)) ; First line is section

; ; Example 5: Key validation constraints
(assert (not (str.contains key " "))) ; Keys cannot contain spaces
(assert (>= (str.len key) 3)) ; Minimum key length of 3
(assert (not (str.prefixof "_" key))) ; Keys cannot start with underscore

; ; Example 6: Value extraction from complex string
(declare-const complex_value String)
(assert (= complex_value (str.split_rest "path=/usr/local/bin:/usr/bin:/bin" equals 1)))
(assert (str.contains complex_value colon)) ; Value contains path separators

; ; Unsatisfiable example: Invalid section header
(declare-const bad_section String)
(assert (= bad_section "database]")) ; Missing opening bracket
(assert (str.prefixof open_bracket bad_section)) ; This will make it unsatisfiable

(check-sat)
(get-model)
(exit)