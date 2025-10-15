(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun full_config () String)
(declare-fun processed_line () String)

; Declare integer variables for split operations
(declare-const num_equals_splits Int)
(declare-const num_colon_splits Int)
(declare-const num_newline_splits Int)
(declare-const num_bracket_splits Int)
(declare-const section_count Int)

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
(declare-fun alt_config () String)
(declare-fun alt_key () String)
(declare-fun alt_value () String)
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
(declare-fun first_line () String)
(assert (= first_line (str.split_at ini_content "\n" 0)))
(assert (= first_line "[server]"))

; ; Extract and validate a key-value pair from the configuration
(declare-fun server_host_line () String)
(assert (= server_host_line (str.split_at ini_content "\n" 1)))
(assert (= server_host_line "host=example.com"))

; Parse the host configuration line
(declare-fun host_key () String)
(declare-fun host_value () String)
(assert (= host_key (str.split_at server_host_line "=" 0)))
(assert (= host_value (str.split_at server_host_line "=" 1)))
(assert (= host_key "host"))
(assert (= host_value "example.com"))

; Section bracket validation
(declare-fun bracket_test () String)
(assert (= bracket_test "[network]"))
(assert (str.prefixof "[" bracket_test))
(assert (str.suffixof "]" bracket_test))

; ; Complex section extraction with multiple brackets
(declare-fun complex_section () String)
(declare-fun inner_content () String)
(assert (= complex_section "[logging[debug]]"))
(assert (= (str.num_splits complex_section "[") 3))
(assert (= inner_content (str.split_at complex_section "[" 1)))

; Key validation funraints - keys cannot contain special characters
(declare-fun invalid_key () String)
(assert (= invalid_key "data base"))
(assert (str.contains invalid_key " "))

; This should make the funraint unsatisfiable if we require no spaces in keys
(declare-fun valid_key_check () String)
(assert (= valid_key_check extracted_key))
(assert (not (str.contains valid_key_check " ")))

; Value processing with multiple delimiters
(declare-fun multi_value () String)
(declare-fun processed_value () String)
(assert (= multi_value "user:admin:password"))
(assert (= (str.num_splits multi_value ":") 3))
(assert (= processed_value (str.split_at multi_value ":" 1)))
(assert (= processed_value "admin"))

; Configuration validation - ensure proper format
(declare-fun config_format_check () String)
(assert (= config_format_check key_value_pair))
(assert (or (str.contains config_format_check "=") (str.contains config_format_check ":")))

; ; Rest extraction for remaining configuration after first section
(declare-fun remaining_config () String)
(assert (= remaining_config (str.split_rest ini_content "\n" 3)))
(assert (str.contains remaining_config "[database]"))

; Final validation constraints
(assert (> (str.len section_name) 0))
(assert (> (str.len extracted_value) 0))
(assert (not (= extracted_key "")))
(assert (not (= extracted_value "")))

(check-sat)
(exit)