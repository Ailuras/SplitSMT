
(set-logic QF_S)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const eq_delim String) ; '=' for key-value pairs
(declare-const colon_delim String) ; ':' alternative key-value separator
(declare-const nl_delim String) ; '\n' for line separation
(declare-const sec_open String) ; '[' for section opening
(declare-const sec_close String) ; ']' for section closing

(assert (= eq_delim "="))
(assert (= colon_delim ":"))
(assert (= nl_delim "\n"))
(assert (= sec_open "["))
(assert (= sec_close "]"))

; Declare variables for configuration processing
(declare-const config_content String) ; The entire configuration content
(declare-const target_key String) ; Key we're looking for
(declare-const target_section String) ; Section we're interested in
(declare-const extracted_value String) ; Extracted value for verification

; ; Example configuration content
(assert (= config_content (str.++ 
 "[database]\n"
 "host=localhost\n"
 "port=5432\n"
 "\n"
 "[server]\n"
 "address:127.0.0.1\n"
 "timeout=30\n"
)))

; ; Helper function to check if a line is a section header
(define-fun is_section_header ((line String)) Bool
 (and 
 (str.prefixof sec_open line)
 (str.suffixof sec_close line)
)
)

; Helper function to get section name from header
(define-fun get_section_name ((line String)) String
 (str.substr line 1 (- (str.len line) 2))
)

; ; Constraints for key validation and value extraction
(assert (= target_key "port"))
(assert (= target_section "database"))

; Split configuration into lines
(declare-const num_lines Int)
(assert (= num_lines (str.num_splits config_content nl_delim)))

; Find the line containing our target key-value pair
(declare-const found_value String)
(declare-const current_section String)
(assert (= current_section ""))

; Iterate through lines to find our key
(define-fun process_config ((i Int)) Bool
 (ite (< i num_lines)
 (let ((line (str.split_at config_content nl_delim i)))
 (ite (is_section_header line)
 (and 
 (= current_section (get_section_name line))
 (process_config (+ i 1))
)
 (ite (and 
 (= current_section target_section)
 (or 
 (str.contains line (str.++ target_key eq_delim))
 (str.contains line (str.++ target_key colon_delim))
)
)
 (and 
 (= found_value 
 (ite (str.contains line eq_delim)
 (str.split_at line eq_delim 1)
 (str.split_at line colon_delim 1)
)
)
 true
)
 (process_config (+ i 1))
)
)
)
 false
)
)

(assert (process_config 0))

; ; Verify the extracted value
(assert (= extracted_value "5432"))
(assert (= found_value extracted_value))

; Additional constraints for unsatisfiable case
(declare-const missing_key String)
(assert (= missing_key "nonexistent"))
(declare-const missing_section String)
(assert (= missing_section "logging"))

; This should make the problem unsatisfiable if uncommented
; (assert (and 
; (= target_key missing_key)
; (= target_section missing_section)
;))

(check-sat)
(get-value (extracted_value found_value current_section))
(get-value (config_content))
(exit)