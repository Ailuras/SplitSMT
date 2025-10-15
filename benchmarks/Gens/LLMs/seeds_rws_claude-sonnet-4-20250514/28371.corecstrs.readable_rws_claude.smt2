(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :status unknown)

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_line () String)
(declare-fun key_name () String)
(declare-fun value_content () String)
(declare-fun section_name () String)
(declare-fun full_config () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_header () String)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.num_splits config_line "=") 2))
(assert (= (str.split_at config_line "=" 0) "database_host"))
(assert (= (str.split_at config_line "=" 1) "localhost"))

; Key validation - ensure key contains only valid characters
(assert (str.prefixof "database_" (str.split_at config_line "=" 0)))
(assert (> (str.len (str.split_at config_line "=" 0)) 3))

; ; Value extraction with colon delimiter for alternative format
(declare-fun alt_config () String)
(assert (= alt_config "port: 5432"))
(assert (= (str.num_splits alt_config ":") 2))
(assert (= (str.split_at alt_config ":" 0) "port"))
(assert (str.contains (str.split_at alt_config ":" 1) "5432"))

; Section handling with square brackets
(assert (= section_line "[database]"))
(assert (= (str.num_splits section_line "[") 2))
(assert (= (str.num_splits section_line "]") 2))
(assert (= (str.split_at section_line "[" 1) "database]"))
(assert (= (str.split_at (str.split_at section_line "[" 1) "]" 0) "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n[database]\nname=mydb"))
(assert (>= (str.num_splits ini_content "\n") 5))

; ; Extract first section name
(assert (= (str.split_at ini_content "\n" 0) "[server]"))
(assert (str.contains (str.split_at ini_content "\n" 0) "["))
(assert (str.contains (str.split_at ini_content "\n" 0) "]"))

; ; Extract key-value pairs from multi-line content
(assert (= (str.split_at ini_content "\n" 1) "host=example.com"))
(assert (= (str.num_splits (str.split_at ini_content "\n" 1) "=") 2))
(assert (= (str.split_at (str.split_at ini_content "\n" 1) "=" 0) "host"))
(assert (= (str.split_at (str.split_at ini_content "\n" 1) "=" 1) "example.com"))

; Section validation - ensure proper bracket format
(declare-fun invalid_section () String)
(assert (= invalid_section "[incomplete"))
(assert (= (str.num_splits invalid_section "[") 2))
(assert (= (str.num_splits invalid_section "]") 1))

; Key validation constraints
(assert (= key_name "max_connections"))
(assert (> (str.len key_name) 0))
(assert (not (str.contains key_name "=")))
(assert (not (str.contains key_name ":")))
(assert (not (str.contains key_name "\n")))

; ; Value extraction with whitespace handling
(assert (= value_content " 100 "))
(assert (str.contains value_content "100"))
(assert (> (str.len value_content) 3))

; Complex configuration parsing
(assert (= full_config "[app]\ndebug=true\nlog_level=info\n[db]\nhost=localhost"))
(assert (>= (str.num_splits full_config "\n") 5))

; ; Extract section names using bracket delimiters
(assert (= (str.split_at full_config "\n" 0) "[app]"))
(assert (= (str.split_at (str.split_at full_config "\n" 0) "[" 1) "app]"))
(assert (= (str.split_at (str.split_at (str.split_at full_config "\n" 0) "[" 1) "]" 0) "app"))

; ; Validate extracted key-value pair
(assert (= (str.split_at full_config "\n" 1) "debug=true"))
(assert (= extracted_key (str.split_at (str.split_at full_config "\n" 1) "=" 0)))
(assert (= extracted_value (str.split_at (str.split_at full_config "\n" 1) "=" 1)))
(assert (= extracted_key "debug"))
(assert (= extracted_value "true"))

; Section header processing
(assert (= section_header "[network_settings]"))
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))
(assert (= (str.len (str.split_at (str.split_at section_header "[" 1) "]" 0)) 16))

; ; Multi-segment value extraction
(declare-fun complex_value () String)
(assert (= complex_value "url=http://api.example.com:8080/v1"))
(assert (= (str.num_splits complex_value "=") 2))
(assert (= (str.num_splits (str.split_at complex_value "=" 1) ":") 3))

; Ensure proper configuration structure
(declare-fun config_block () String)
(assert (= config_block "[main]\nversion=2.0\nname=app"))
(assert (= (str.num_splits config_block "\n") 3))
(assert (str.prefixof "[" (str.split_at config_block "\n" 0)))
(assert (str.contains (str.split_at config_block "\n" 1) "="))
(assert (str.contains (str.split_at config_block "\n" 2) "="))

; Key validation - no special characters in keys
(declare-fun test_key () String)
(assert (= test_key "valid_key_123"))
(assert (not (str.contains test_key "[")))
(assert (not (str.contains test_key "]")))
(assert (not (str.contains test_key "=")))
(assert (> (str.len test_key) 5))

; Value validation - handle empty values
(declare-fun empty_value_line () String)
(assert (= empty_value_line "optional_setting="))
(assert (= (str.num_splits empty_value_line "=") 2))
(assert (= (str.len (str.split_at empty_value_line "=" 1)) 0))

; Conflicting constraints for unsatisfiable case
(declare-fun conflict_line () String)
(assert (= conflict_line "test=value"))
(assert (= (str.num_splits conflict_line "=") 2))
(assert (= (str.split_at conflict_line "=" 0) "test"))
(assert (= (str.split_at conflict_line "=" 1) "different_value"))
(assert (= (str.split_at conflict_line "=" 1) "value"))

(check-sat)
(exit)