(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)

; Declare string variables for configuration parsing
(declare-const config_line string)
(declare-const ini_content string)
(declare-const section_header string)
(declare-const key_value_pair string)
(declare-const extracted_key string)
(declare-const extracted_value string)
(declare-const section_name string)
(declare-const full_config string)
(declare-const processed_line string)

; Declare integer variables for split operations
(declare-const num_equals_splits int)
(declare-const num_colon_splits int)
(declare-const num_newline_splits int)
(declare-const num_bracket_splits int)
(declare-const section_count int)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= num_equals_splits (str.num_splits config_line "=")))
(assert (= num_equals_splits 2))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))

; Key validation - keys must be non-empty and contain only valid characters
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (str.prefixof "database" extracted_key))

; Alternative configuration with colon delimiter
(declare-const alt_config string)
(declare-const alt_key string)
(declare-const alt_value string)
(assert (= alt_config "port:3306"))
(assert (= (str.num_splits alt_config ":") 2))
(assert (= alt_key (str.split_at alt_config ":" 0)))
(assert (= alt_value (str.split_at alt_config ":" 1)))

; ; Value extraction and validation
(assert (= alt_value "3306"))
(assert (str.is_digit alt_value))

; INI file section handling
(assert (= section_header "[database]"))
(assert (= (str.num_splits section_header "[") 2))
(assert (= (str.num_splits section_header "]") 2))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n[database]\nhost=localhost\nport=3306"))
(assert (= section_count (str.num_splits ini_content "\n")))
(assert (> section_count 5))

; ; Extract first line after splitting by newline
(declare-const first_line string)
(assert (= first_line (str.split_at ini_content "\n" 0)))
(assert (= first_line "[server]"))

; ; Extract and validate a key-value pair from the configuration
(declare-const server_host_line string)
(assert (= server_host_line (str.split_at ini_content "\n" 1)))
(assert (= server_host_line "host=example.com"))

; Parse the host configuration line
(declare-const host_key string)
(declare-const host_value string)
(assert (= host_key (str.split_at server_host_line "=" 0)))
(assert (= host_value (str.split_at server_host_line "=" 1)))
(assert (= host_key "host"))
(assert (= host_value "example.com"))

; Section bracket validation
(declare-const bracket_test string)
(assert (= bracket_test "[network]"))
(assert (str.prefixof "[" bracket_test))
(assert (str.suffixof "]" bracket_test))

; ; Complex section extraction with multiple brackets
(declare-const complex_section string)
(declare-const inner_content string)
(assert (= complex_section "[logging[debug]]"))
(assert (= (str.num_splits complex_section "[") 3))
(assert (= inner_content (str.split_at complex_section "[" 1)))

; Key validation constraints - keys cannot contain special characters
(declare-const invalid_key string)
(assert (= invalid_key "data base"))
(assert (str.contains invalid_key " "))

; This should make the constraint unsatisfiable if we require no spaces in keys
(declare-const valid_key_check string)
(assert (= valid_key_check extracted_key))
(assert (not (str.contains valid_key_check " ")))

; Value processing with multiple delimiters
(declare-const multi_value string)
(declare-const processed_value string)
(assert (= multi_value "user:admin:password"))
(assert (= (str.num_splits multi_value ":") 3))
(assert (= processed_value (str.split_at multi_value ":" 1)))
(assert (= processed_value "admin"))

; Configuration validation - ensure proper format
(declare-const config_format_check string)
(assert (= config_format_check key_value_pair))
(assert (or (str.contains config_format_check "=") (str.contains config_format_check ":")))

; ; Rest extraction for remaining configuration after first section
(declare-const remaining_config string)
(assert (= remaining_config (str.split_rest ini_content "\n" 3)))
(assert (str.contains remaining_config "[database]"))

; Final validation constraints
(assert (> (str.len section_name) 0))
(assert (> (str.len extracted_value) 0))
(assert (not (= extracted_key "")))
(assert (not (= extracted_value "")))

(check-sat)
(exit)