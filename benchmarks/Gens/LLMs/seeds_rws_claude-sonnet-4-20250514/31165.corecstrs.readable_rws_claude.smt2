(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")
(set-logic QF_SLIA)

; Declare string variables for configuration parsing
(declare-fun config_line1 () String)
(declare-fun config_line2 () String)
(declare-fun config_line3 () String)
(declare-fun ini_section () String)
(declare-fun ini_content () String)
(declare-fun full_config () String)

; ; Declare variables for extracted components
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun section_name () String)
(declare-fun section_content () String)

; Declare variables for validation
(declare-fun valid_key () String)
(declare-fun invalid_key () String)
(declare-fun extracted_value () String)

; Configuration line constraints - key=value format
(assert (= config_line1 "database_host=localhost"))
(assert (= config_line2 "port:8080"))
(assert (= config_line3 "timeout=30"))

; ; Key-value extraction using equals delimiter
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))
(assert (= (str.num_splits config_line1 "=") 2))

; ; Key-value extraction using colon delimiter
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))
(assert (= (str.num_splits config_line2 ":") 2))

; Key validation constraints
(assert (= valid_key "database_host"))
(assert (= invalid_key ""))
(assert (str.contains key1 "database"))
(assert (> (str.len key1) 0))
(assert (not (str.contains key1 " ")))

; ; Value extraction and validation
(assert (= extracted_value value1))
(assert (or (= extracted_value "localhost") (= extracted_value "127.0.0.1")))
(assert (> (str.len extracted_value) 0))

; INI section handling with brackets
(assert (= ini_section "[database]"))
(assert (= section_name (str.split_at ini_section "[" 1)))
(assert (= section_name (str.split_at section_name "]" 0)))
(assert (= (str.num_splits ini_section "[") 2))
(assert (= (str.num_splits section_name "]") 1))

; Multi-line INI content processing
(assert (= ini_content "host=localhost\nport=5432\nuser=admin"))
(assert (= (str.num_splits ini_content "\n") 3))

; ; Extract first configuration line from multi-line content
(assert (= (str.split_at ini_content "\n" 0) "host=localhost"))
(assert (= (str.split_at ini_content "\n" 1) "port=5432"))
(assert (= (str.split_at ini_content "\n" 2) "user=admin"))

; ; Section content extraction
(assert (= section_content (str.split_rest ini_content "\n" 1)))
(assert (str.contains section_content "port=5432"))
(assert (str.contains section_content "user=admin"))

; Full configuration file structure
(assert (= full_config "[database]\nhost=localhost\nport=5432\n[server]\ntimeout=30"))
(assert (> (str.num_splits full_config "\n") 3))

; ; Extract database section
(assert (= (str.split_at full_config "[database]" 1) "\nhost=localhost\nport=5432\n[server]\ntimeout=30"))

; ; Validate section structure
(assert (str.contains full_config "[database]"))
(assert (str.contains full_config "[server]"))
(assert (= (str.num_splits full_config "[") 3))

; Key validation rules
(assert (not (str.contains key1 "=")))
(assert (not (str.contains key2 ":")))
(assert (not (str.prefixof key1 " ")))
(assert (not (str.suffixof  key1 " ")))

; ; Value extraction constraints
(assert (not (str.contains value1 "\n")))
(assert (> (str.len value2) 0))

; Section name validation
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))
(assert (> (str.len section_name) 0))

; ; Complex constraint: ensure proper key-value pair format
(assert (or 
 (and (str.contains config_line1 "=") (= (str.num_splits config_line1 "=") 2))
 (and (str.contains config_line1 ":") (= (str.num_splits config_line1 ":") 2))))

; ; Constraint: section must be properly bracketed
(assert (and 
 (str.prefixof ini_section "[")
 (str.suffixof  ini_section "]")
 (= (str.num_splits ini_section "[") 2)
 (= (str.num_splits ini_section "]") 2)))

; ; Constraint: multi-line content processing
(assert (= (str.split_rest full_config "\n" 0) full_config))

; Additional validation constraints
(assert (not (= key1 "")))
(assert (not (= value1 "")))
(assert (not (= section_name "")))

; Ensure consistent delimiter usage within sections
(assert (str.contains (str.split_at ini_content "\n" 0) "="))
(assert (str.contains (str.split_at ini_content "\n" 1) "="))
(assert (str.contains (str.split_at ini_content "\n" 2) "="))

(check-sat)
(exit)