(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration parsing
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun config_block () String)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= (str.num_splits config_line "=") 2))
(assert (= (str.split_at config_line "=" 0) "database_host"))
(assert (= (str.split_at config_line "=" 1) "localhost"))

; Key validation - ensure key contains only valid characters
(assert (str.contains (str.split_at config_line "=" 0) "_"))
(assert (not (str.contains (str.split_at config_line "=" 0) " ")))
(assert (> (str.len (str.split_at config_line "=" 0)) 0))

; Alternative colon delimiter for key-value pairs
(declare-fun colon_config () String)
(assert (= colon_config "port: 5432"))
(assert (= (str.num_splits colon_config ":") 2))
(assert (= (str.split_at colon_config ":" 0) "port"))
(assert (= (str.to_int (str.replace (str.split_at colon_config ":" 1) " " "")) 5432))

; INI file section handling
(assert (= section_header "[database]"))
(assert (= (str.num_splits section_header "[") 2))
(assert (= (str.num_splits section_header "]") 2))
(assert (= (str.split_at section_header "[" 1) "database]"))
(assert (= (str.split_at (str.split_at section_header "[" 1) "]" 0) "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=80\n[database]\nname=mydb"))
(assert (> (str.num_splits ini_content "\n") 3))

; ; Extract server section configuration
(assert (str.contains ini_content "[server]"))
(assert (str.contains ini_content "[database]"))

; ; Value extraction from multi-line content
(declare-fun host_line () String)
(assert (= host_line "host=example.com"))
(assert (= (str.split_at host_line "=" 0) "host"))
(assert (= (str.split_at host_line "=" 1) "example.com"))
(assert (str.contains (str.split_at host_line "=" 1) "."))

; Section name validation
(declare-fun valid_section () String)
(assert (= valid_section "[user_settings]"))
(assert (= (str.len (str.split_at (str.split_at valid_section "[" 1) "]" 0)) 13))
(assert (str.contains (str.split_at (str.split_at valid_section "[" 1) "]" 0) "_"))

; Complex key-value with multiple equals signs
(declare-fun complex_config () String)
(assert (= complex_config "connection_string=server=db.example.com;port=5432"))
(assert (= (str.num_splits complex_config "=") 3))
(assert (= (str.split_at complex_config "=" 0) "connection_string"))
(assert (= (str.split_rest complex_config "=" 1) "server=db.example.com;port=5432"))

; Invalid configuration detection
(declare-fun invalid_line () String)
(assert (= invalid_line "invalid_key_without_value"))
(assert (= (str.num_splits invalid_line "=") 1))
(assert (= (str.num_splits invalid_line ":") 1))

; Section boundary detection
(declare-fun section_content () String)
(assert (= section_content "[app]\ndebug=true\nversion=1.0"))
(assert (= (str.num_splits section_content "\n") 3))
(assert (str.prefixes section_content "[app]"))

; Key normalization - ensure no leading/trailing spaces
(declare-fun raw_key () String)
(assert (= raw_key " timeout "))
(assert (= (str.replace (str.replace raw_key " " "") "" "") "timeout"))

; Value type validation for boolean configs
(declare-fun bool_config () String)
(assert (= bool_config "enabled=true"))
(assert (= (str.split_at bool_config "=" 1) "true"))
(assert (or (= (str.split_at bool_config "=" 1) "true") 
 (= (str.split_at bool_config "=" 1) "false")))

; Nested section handling with brackets
(declare-fun nested_section () String)
(assert (= nested_section "[logging.level]"))
(assert (str.contains (str.split_at (str.split_at nested_section "[" 1) "]" 0) "."))

; Configuration validation constraints
(declare-fun config_key () String)
(declare-fun config_val () String)
(assert (= key_value_pair "max_connections=100"))
(assert (= config_key (str.split_at key_value_pair "=" 0)))
(assert (= config_val (str.split_at key_value_pair "=" 1)))
(assert (> (str.len config_key) 0))
(assert (> (str.len config_val) 0))
(assert (not (str.contains config_key "=")))

; Multi-section INI structure
(declare-fun full_ini () String)
(assert (= full_ini "[general]\nname=app\n[db]\nhost=localhost"))
(assert (> (str.num_splits full_ini "[") 2))
(assert (= (str.num_splits full_ini "]") 3))

; ; Extract specific section content
(declare-fun db_section_start () String)
(assert (str.contains full_ini "[db]"))
(assert (str.contains (str.split_rest full_ini "[" 2) "host=localhost"))

; Conflicting constraint for unsatisfiable case
(declare-fun conflict_config () String)
(assert (= conflict_config "test=value"))
(assert (= (str.num_splits conflict_config "=") 2))
(assert (= (str.num_splits conflict_config "=") 3)) ; This creates unsatisfiability

(check-sat)
(exit)