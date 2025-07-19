(set-logic QF_S)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration content
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun config_block () String)

; Declare integer variables for split operations
(declare-fun num_equals_splits () Int)
(declare-fun num_colon_splits () Int)
(declare-fun num_newline_splits () Int)
(declare-fun num_bracket_splits () Int)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= num_equals_splits (str.num_splits config_line "=")))
(assert (= num_equals_splits 2))

; ; Extract key and value from equals-separated pair
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))

; Key validation - must be non-empty and contain only valid characters
(assert (> (str.len extracted_key) 0))
(assert (= extracted_key "database_host"))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "\t")))

; ; Value extraction validation
(assert (= extracted_value "localhost"))
(assert (> (str.len extracted_value) 0))

; INI section header parsing
(assert (= section_header "[database]"))
(assert (= (str.num_splits section_header "[") 2))
(assert (= (str.num_splits section_header "]") 2))

; ; Extract section name between brackets
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))
(assert (= section_name "database"))

; Multi-line configuration processing
(assert (= ini_content "host=localhost\nport=5432\nuser=admin"))
(assert (= (str.num_splits ini_content "\n") 3))

; ; Extract first configuration line
(assert (= (str.split_at ini_content "\n" 0) "host=localhost"))
(assert (= (str.split_at ini_content "\n" 1) "port=5432"))
(assert (= (str.split_at ini_content "\n" 2) "user=admin"))

; Colon-based key-value parsing alternative
(declare-fun colon_config () String)
(declare-fun colon_key () String)
(declare-fun colon_value () String)

(assert (= colon_config "timeout:30"))
(assert (= num_colon_splits (str.num_splits colon_config ":")))
(assert (= num_colon_splits 2))
(assert (= colon_key (str.split_at colon_config ":" 0)))
(assert (= colon_value (str.split_at colon_config ":" 1)))

; Key validation for colon format
(assert (= colon_key "timeout"))
(assert (not (str.contains colon_key "=")))
(assert (not (str.contains colon_key ":")))

; Complex INI file structure
(declare-fun full_ini () String)
(declare-fun section_count () Int)

(assert (= full_ini "[server]\nhost=example.com\nport=80\n[database]\nhost=db.example.com"))
(assert (= section_count (str.num_splits full_ini "[")))
(assert (= section_count 3))

; ; Extract sections and validate structure
(assert (= (str.split_at full_ini "[" 1) "server]\nhost=example.com\nport=80\n[database]\nhost=db.example.com"))
(assert (str.contains (str.split_at full_ini "[" 1) "]"))

; Configuration block processing
(assert (= config_block "name=myapp\nversion=1.0\ndebug=true"))
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun line3 () String)

(assert (= line1 (str.split_at config_block "\n" 0)))
(assert (= line2 (str.split_at config_block "\n" 1)))
(assert (= line3 (str.split_at config_block "\n" 2)))

; ; Validate each line has proper key-value structure
(assert (= (str.num_splits line1 "=") 2))
(assert (= (str.num_splits line2 "=") 2))
(assert (= (str.num_splits line3 "=") 2))

; ; Extract and validate keys from each line
(declare-fun key1 () String)
(declare-fun key2 () String)
(declare-fun key3 () String)

(assert (= key1 (str.split_at line1 "=" 0)))
(assert (= key2 (str.split_at line2 "=" 0)))
(assert (= key3 (str.split_at line3 "=" 0)))

(assert (= key1 "name"))
(assert (= key2 "version"))
(assert (= key3 "debug"))

; Ensure keys are unique within section
(assert (not (= key1 key2)))
(assert (not (= key1 key3)))
(assert (not (= key2 key3)))

; Value type validation
(declare-fun value1 () String)
(declare-fun value2 () String)
(declare-fun value3 () String)

(assert (= value1 (str.split_at line1 "=" 1)))
(assert (= value2 (str.split_at line2 "=" 1)))
(assert (= value3 (str.split_at line3 "=" 1)))

(assert (= value1 "myapp"))
(assert (= value2 "1.0"))
(assert (= value3 "true"))

; Boolean value validation
(assert (or (= value3 "true") (= value3 "false")))

; Section header validation with complex structure
(declare-fun complex_header () String)
(declare-fun header_content () String)

(assert (= complex_header "[web.server]"))
(assert (= (str.num_splits complex_header "[") 2))
(assert (= (str.num_splits complex_header "]") 2))
(assert (= header_content (str.split_at (str.split_at complex_header "[" 1) "]" 0)))
(assert (= header_content "web.server"))

; Remaining content after split operations
(declare-fun remaining_config () String)
(assert (= remaining_config (str.split_rest config_block "\n" 1)))
(assert (= remaining_config "version=1.0\ndebug=true"))

; Malformed configuration detection
(declare-fun malformed_line () String)
(declare-fun malformed_splits () Int)

(assert (= malformed_line "invalid_entry_no_delimiter"))
(assert (= malformed_splits (str.num_splits malformed_line "=")))
(assert (= malformed_splits 1))

; This should make the configuration invalid
(assert (> malformed_splits 1))

(check-sat)
(exit)