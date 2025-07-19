; SMT-LIB2 script for configuration file parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic QF_S)

; Declare string constants for delimiters
(declare-const eq_delim String) ; '=' delimiter
(declare-const colon_delim String) ; ':' delimiter
(declare-const nl_delim String) ; '\n' delimiter
(declare-const lbr_delim String) ; '[' delimiter
(declare-const rbr_delim String) ; ']' delimiter

(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= lbr_delim "["))
(assert (= rbr_delim "]"))

; Declare variables for configuration parsing
(declare-const config_line String)
(declare-const ini_section String)
(declare-const key String)
(declare-const value String)
(declare-const full_config String)

; ; Example constraints for key-value parsing
; Case 1: Simple key=value pair
(assert (or
 ; Equals delimiter case
 (and 
 (= (str.num_splits config_line eq_delim) 2)
 (= key (str.split_at config_line eq_delim 0))
 (= value (str.split_at config_line eq_delim 1))
 (not (str.contains key " ")) ; keys shouldn't contain spaces
)
 ; Colon delimiter case
 (and
 (= (str.num_splits config_line colon_delim) 2)
 (= key (str.split_at config_line colon_delim 0))
 (= value (str.split_at config_line colon_delim 1))
 (not (str.contains key " ")) ; keys shouldn't contain spaces
)
))

; Key validation constraints
(assert (>= (str.len key) 1)) ; keys must be at least 1 character
(assert (not (str.contains key eq_delim))) ; keys cannot contain delimiters
(assert (not (str.contains key colon_delim)))
(assert (not (str.contains key nl_delim)))

; INI section handling constraints
(assert (or
 ; No section case
 (and 
 (not (str.contains full_config lbr_delim))
 (not (str.contains full_config rbr_delim))
)
 ; With section case
 (and
 (str.contains full_config lbr_delim)
 (str.contains full_config rbr_delim)
 (> (str.num_splits full_config lbr_delim) 1)
 (= ini_section 
 (str.split_at 
 (str.split_at full_config lbr_delim 1) 
 rbr_delim 
 0
)
)
 (>= (str.len ini_section) 1) ; section names must be at least 1 char
 (not (str.contains ini_section " ")) ; no spaces in section names
)
))

; Multi-line configuration constraints
(assert (or
 ; Single line case
 (and
 (= (str.num_splits full_config nl_delim) 1)
 (= config_line full_config)
)
 ; Multi-line case
 (and
 (> (str.num_splits full_config nl_delim) 1)
 ; Config line must be one of the non-empty lines
 (or
 (= config_line (str.split_at full_config nl_delim 0))
 (= config_line (str.split_at full_config nl_delim 1))
)
 ; Section must appear before its keys if present
 (=> 
 (and 
 (str.contains full_config lbr_delim)
 (str.contains full_config rbr_delim)
)
 (str.prefixof 
 (str.++ lbr_delim ini_section rbr_delim)
 (str.split_rest full_config nl_delim 0)
)
)
)
))

; Specific test cases (mix of satisfiable and unsatisfiable)
; Test 1: Valid key-value pair
(assert (or
 (= full_config "timeout=30")
 (= full_config "timeout:30")
))

; Test 2: Invalid key (contains delimiter)
(assert (not (= key "time=out")))

; Test 3: Section handling
(assert (or
 (= full_config "[database]\nhost=localhost")
 (= full_config "[server]\nport:8080")
 (= full_config "single_key=value") ; no section case
))

; Test 4: Unsatisfiable case - empty key
(assert (not (= key "")))

; Test 5: Unsatisfiable case - section with space
(assert (not (str.contains ini_section " ")))

(check-sat)
(get-model)
(exit)