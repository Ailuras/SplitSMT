(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :smt-lib-version 2.6)

; Variable declarations for configuration parsing
(declare-fun config_line1 () String)
(declare-fun config_line2 () String)
(declare-fun config_line3 () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_name () String)
(declare-fun value_content () String)
(declare-fun full_key_value () String)
(declare-fun multi_line_config () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun parsed_section () String)

; Basic key-value pair parsing with equals delimiter
(assert (= config_line1 "database_host=localhost"))
(assert (= extracted_key (str.split_at config_line1 "=" 0)))
(assert (= extracted_value (str.split_at config_line1 "=" 1)))
(assert (= (str.num_splits config_line1 "=") 2))

; Key validation - keys should not be empty and contain valid characters
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (str.contains extracted_key "database"))

; Alternative delimiter parsing with colon
(assert (= config_line2 "port:8080"))
(assert (= (str.split_at config_line2 ":" 0) "port"))
(assert (= (str.split_at config_line2 ":" 1) "8080"))

; ; Value extraction validation
(assert (> (str.len (str.split_at config_line2 ":" 0)) 0))
(assert (str.is_digit (str.split_at config_line2 ":" 1)))

; INI section header parsing
(assert (= section_header "[database]"))
(assert (= (str.split_at section_header "[" 1) "database]"))
(assert (= (str.split_at (str.split_at section_header "[" 1) "]" 0) "database"))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Multi-line configuration parsing
(assert (= multi_line_config "host=localhost\nport=5432\nuser=admin"))
(assert (= (str.num_splits multi_line_config "\n") 3))
(assert (= (str.split_at multi_line_config "\n" 0) "host=localhost"))
(assert (= (str.split_at multi_line_config "\n" 1) "port=5432"))
(assert (= (str.split_at multi_line_config "\n" 2) "user=admin"))

; ; Extract key-value pairs from each line
(assert (= (str.split_at (str.split_at multi_line_config "\n" 0) "=" 0) "host"))
(assert (= (str.split_at (str.split_at multi_line_config "\n" 0) "=" 1) "localhost"))
(assert (= (str.split_at (str.split_at multi_line_config "\n" 1) "=" 0) "port"))
(assert (= (str.split_at (str.split_at multi_line_config "\n" 1) "=" 1) "5432"))

; Complex INI file structure
(assert (= ini_content "[server]\nhost=192.168.1.1\nport=80\n[database]\nhost=localhost"))
(assert (> (str.num_splits ini_content "\n") 3))
(assert (str.contains (str.split_at ini_content "\n" 0) "["))
(assert (str.contains (str.split_at ini_content "\n" 0) "]"))

; ; Section handling - extract section names
(assert (= parsed_section (str.split_at ini_content "\n" 0)))
(assert (str.prefixof "[" parsed_section))
(assert (str.suffixof "]" parsed_section))

; Key validation constraints
(assert (= config_line3 "timeout=30"))
(assert (= key_name (str.split_at config_line3 "=" 0)))
(assert (= value_content (str.split_at config_line3 "=" 1)))
(assert (> (str.len key_name) 0))
(assert (> (str.len value_content) 0))
(assert (not (str.contains key_name "=")))
(assert (not (str.contains key_name "\n")))

; ; Value extraction with multiple possible delimiters
(assert (= full_key_value "api_key:abc123=def456"))
(assert (or 
 (= (str.num_splits full_key_value ":") 2)
 (= (str.num_splits full_key_value "=") 2)))

; Ensure proper section bracket matching
(assert (= (str.num_splits "[section]" "[") 2))
(assert (= (str.num_splits "[section]" "]") 2))

; Configuration validation - no empty keys or values
(assert (> (str.len (str.split_at "name=value" "=" 0)) 0))
(assert (> (str.len (str.split_at "name=value" "=" 1)) 0))

; Handle malformed configuration lines
(assert (not (= (str.split_at "malformed_line" "=" 0) "malformed_line")))

; ; Section content extraction
(assert (= (str.split_rest ini_content "\n" 1) "host=192.168.1.1\nport=80\n[database]\nhost=localhost"))

; Ensure sections are properly closed
(assert (str.contains section_header "]"))
(assert (= (str.num_splits section_header "]") 2))

(check-sat)
(exit)