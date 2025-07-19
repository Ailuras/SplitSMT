(set-info :source |
 Configuration Parsing: Key-value pair and INI file processing
; Focus: key validation, value extraction, section handling
|)
(set-info :smt-lib-version 2.6)
(set-logic QF_S)

; Declare string variables for configuration content
(declare-const config_line string)
(declare-const ini_content string)
(declare-const section_header string)
(declare-const key_value_pair string)
(declare-const extracted_key string)
(declare-const extracted_value string)
(declare-const section_name string)

; Configuration line parsing with equals delimiter
; Format: key=value
(assert (= config_line "database_host=localhost"))

; ; Extract key from key-value pair using equals delimiter
(assert (= extracted_key (str.split_at config_line "=" 0)))

; ; Extract value from key-value pair using equals delimiter
(assert (= extracted_value (str.split_at config_line "=" 1)))

; Key validation: must be non-empty and contain only valid characters
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "\n")))

; ; Value validation: must be non-empty after extraction
(assert (> (str.len extracted_value) 0))

; INI file section header parsing
; Format: [section_name]
(assert (= section_header "[database]"))

; Verify section header format
(assert (= (str.split_at section_header "[" 0) ""))
(assert (str.contains section_header "]"))

; ; Extract section name between brackets
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Section name validation
(assert (> (str.len section_name) 0))
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))

; Multi-line INI content processing
(assert (= ini_content "[server]\nport=8080\nhost=localhost\n[database]\nname=mydb\nuser=admin"))

; Count number of lines in INI content
(assert (> (str.num_splits ini_content "\n") 3))

; ; Extract first line (should be section header)
(assert (= (str.split_at ini_content "\n" 0) "[server]"))

; ; Extract second line (should be key-value pair)
(declare-const second_line string)
(assert (= second_line (str.split_at ini_content "\n" 1)))

; Verify second line is a valid key-value pair with equals
(assert (= (str.num_splits second_line "=") 2))

; Alternative delimiter handling - colon separator
(declare-const colon_config string)
(declare-const colon_key string)
(declare-const colon_value string)

(assert (= colon_config "timeout:30"))
(assert (= colon_key (str.split_at colon_config ":" 0)))
(assert (= colon_value (str.split_at colon_config ":" 1)))

; Ensure colon format is properly parsed
(assert (= (str.num_splits colon_config ":") 2))
(assert (> (str.len colon_key) 0))
(assert (> (str.len colon_value) 0))

; Complex section processing
(declare-const complex_section string)
(assert (= complex_section "[network]\nip=192.168.1.1\nport=443\nssl=true"))

; ; Extract section header from complex section
(declare-const complex_header string)
(assert (= complex_header (str.split_at complex_section "\n" 0)))

; Verify it's a proper section header
(assert (str.prefix complex_header "["))
(assert (str.suffix complex_header "]"))

; ; Extract configuration entries after section header
(declare-const remaining_config string)
(assert (= remaining_config (str.split_rest complex_section "\n" 1)))

; Verify remaining config contains key-value pairs
(assert (str.contains remaining_config "="))
(assert (> (str.num_splits remaining_config "\n") 1))

; Edge case: empty section handling
(declare-const empty_section string)
(assert (= empty_section "[empty]"))

; Verify empty section structure
(assert (= (str.num_splits empty_section "[") 2))
(assert (= (str.num_splits empty_section "]") 2))

; Invalid configuration detection
(declare-const invalid_config string)
(assert (= invalid_config "invalid_line_without_delimiter"))

; This should have no valid key-value separator
(assert (= (str.num_splits invalid_config "=") 1))
(assert (= (str.num_splits invalid_config ":") 1))

; Multi-value handling with same key
(declare-const multi_value string)
(assert (= multi_value "colors=red,blue,green"))

; ; Extract the values part
(declare-const values_part string)
(assert (= values_part (str.split_at multi_value "=" 1)))

; Nested section validation
(declare-const nested_content string)
(assert (= nested_content "[parent]\nchild_key=value\n[parent.child]\ndeep_key=deep_value"))

; Count sections by counting opening brackets
(assert (= (str.num_splits nested_content "[") 3))

; Whitespace handling in keys and values
(declare-const whitespace_config string)
(assert (= whitespace_config "key = value with spaces"))

; ; Extract parts with potential whitespace
(declare-const ws_key string)
(declare-const ws_value string)
(assert (= ws_key (str.split_at whitespace_config "=" 0)))
(assert (= ws_value (str.split_at whitespace_config "=" 1)))

; Key should not contain equals sign after splitting
(assert (not (str.contains ws_key "=")))

(check-sat)
(exit)