; SMT-LIB2 script for configuration file parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic QF_SLIA)

; Declare string constants for delimiters
(declare-const eq_delim String) ; '=' for key-value pairs
(declare-const colon_delim String) ; ':' alternative delimiter
(declare-const nl_delim String) ; '\n' for line separation
(declare-const sec_open String) ; '[' for section start
(declare-const sec_close String) ; ']' for section end

(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= sec_open "["))
(assert (= sec_close "]"))

; Declare variables for configuration processing
(declare-const config_line String) ; A single configuration line
(declare-const ini_section String) ; An INI section header
(declare-const full_config String) ; Complete configuration content
(declare-const extracted_key String) ; Extracted key from key-value pair
(declare-const extracted_val String) ; Extracted value from key-value pair

; ; Example 1: Simple key-value pair parsing
(assert (= config_line "timeout=30"))
(assert (= extracted_key (str.split_at config_line eq_delim 0)))
(assert (= extracted_val (str.split_at config_line eq_delim 1)))
(assert (str.prefixof "time" extracted_key)) ; Key validation
(assert (str.suffixof "out" extracted_key))
(assert (str.is_digit extracted_val)) ; Value validation

; ; Example 2: Alternative delimiter handling
(declare-const alt_config_line String)
(assert (= alt_config_line "port:8080"))
(assert (or 
 (= (str.split_at alt_config_line eq_delim 0) alt_config_line) ; No '=' found
 (= (str.split_at alt_config_line colon_delim 0) "port") ; Using colon delimiter
))

; ; Example 3: INI section parsing
(assert (= ini_section "[database]"))
(assert (str.contains ini_section sec_open))
(assert (str.contains ini_section sec_close))
(assert (= (str.split_at ini_section sec_open 1) "database]")) ; Extract section name
(assert (not (str.contains (str.split_at ini_section sec_open 1) sec_open))) ; No nested sections

; ; Example 4: Multi-line configuration parsing
(assert (= full_config (str.++ "[server]" nl_delim "host=localhost" nl_delim "port=8080" nl_delim)))
(assert (= (str.num_splits full_config nl_delim) 4)) ; 3 lines + empty string after last newline

; ; Extract server section content
(declare-const server_section String)
(assert (= server_section (str.split_at full_config sec_open 1)))
(assert (= server_section (str.++ "server]" nl_delim "host=localhost" nl_delim "port=8080" nl_delim)))

; ; Extract port value from full config
(declare-const port_line String)
(assert (= port_line (str.split_at (str.split_at full_config nl_delim 2) nl_delim 0)))
(assert (= port_line "port=8080"))
(assert (= (str.split_at port_line eq_delim 1) "8080"))

; ; Example 5: Invalid cases (should be unsat)
(assert (= config_line "malformed_key"))
(assert (not (= (str.num_splits config_line eq_delim) 2))) ; No delimiter found
(assert (str.contains config_line eq_delim)) ; Contradiction
(check-sat)



(exit)