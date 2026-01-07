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

; Configuration parsing constraints

; Basic key-value pair parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= (str.num_splits config_line "=") 2))

; Key validation - keys should not be empty and contain valid characters
(assert (not (= extracted_key "")))
(assert (str.contains extracted_key "database"))

; ; Value extraction should handle different delimiters
(declare-fun alt_config () String)
(assert (= alt_config "port:8080"))
(assert (= (str.split_at alt_config ":" 0) "port"))
(assert (= (str.split_at alt_config ":" 1) "8080"))

; INI section handling with square brackets
(assert (= section_header "[database]"))
(assert (= (str.split_at section_header "[" 1) "database]"))
(assert (= (str.split_at (str.split_at section_header "[" 1) "]" 0) "database"))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Multi-line configuration processing
(declare-fun multiline_config () String)
(assert (= multiline_config "host=localhost\nport=5432\nuser=admin"))
(assert (= (str.num_splits multiline_config "\n") 3))
(assert (= (str.split_at multiline_config "\n" 0) "host=localhost"))
(assert (= (str.split_at multiline_config "\n" 1) "port=5432"))
(assert (= (str.split_at multiline_config "\n" 2) "user=admin"))

; ; Extract key from first line of multiline config
(declare-fun first_line () String)
(assert (= first_line (str.split_at multiline_config "\n" 0)))
(assert (= (str.split_at first_line "=" 0) "host"))

; Complete INI file structure with sections
(declare-fun ini_file () String)
(assert (= ini_file "[server]\nhost=localhost\nport=8080\n[database]\nhost=db.example.com\nport=5432"))

; Count total lines in INI file
(assert (= (str.num_splits ini_file "\n") 6))

; ; Extract server section content
(declare-fun server_section () String)
(assert (= server_section (str.split_at ini_file "\n" 1)))
(assert (str.contains server_section "host=localhost"))

; ; Validate section header format
(declare-fun section_line () String)
(assert (= section_line "[server]"))
(assert (= (str.num_splits section_line "[") 2))
(assert (= (str.num_splits section_line "]") 2))

; Key validation constraints - keys should not contain special characters
(declare-fun invalid_key () String)
(assert (= invalid_key "host[name]=server1"))
(declare-fun parsed_invalid_key () String)
(assert (= parsed_invalid_key (str.split_at invalid_key "=" 0)))
(assert (str.contains parsed_invalid_key "["))

; ; Value extraction with colon delimiter for alternative format
(declare-fun colon_config () String)
(assert (= colon_config "timeout:30"))
(assert (= (str.split_at colon_config ":" 1) "30"))

; Handle configuration with multiple equals signs
(declare-fun complex_value () String)
(assert (= complex_value "connection_string=host=localhost;port=5432"))
(assert (= (str.num_splits complex_value "=") 3))
(assert (= (str.split_at complex_value "=" 0) "connection_string"))
(assert (= (str.split_rest complex_value "=" 1) "host=localhost;port=5432"))

; Section boundary detection
(declare-fun next_section () String)
(assert (= next_section "[logging]"))
(assert (str.contains next_section "["))
(assert (str.contains next_section "]"))

; ; Validate that extracted section name is not empty
(declare-fun empty_section () String)
(assert (= empty_section "[]"))
(declare-fun empty_section_name () String)
(assert (= empty_section_name (str.split_at (str.split_at empty_section "[" 1) "]" 0)))
(assert (= empty_section_name ""))

; This should make the constraints unsatisfiable if we require non-empty section names
(assert (not (= empty_section_name "")))

; Additional key-value validation
(declare-fun valid_config_entry () String)
(assert (= valid_config_entry "max_connections=100"))
(declare-fun config_key () String)
(declare-fun config_value () String)
(assert (= config_key (str.split_at valid_config_entry "=" 0)))
(assert (= config_value (str.split_at valid_config_entry "=" 1)))
(assert (not (= config_key "")))
(assert (not (= config_value "")))

; Ensure proper section header format
(declare-fun malformed_section () String)
(assert (= malformed_section "[incomplete"))
(assert (= (str.num_splits malformed_section "]") 1))

(check-sat)
(exit)