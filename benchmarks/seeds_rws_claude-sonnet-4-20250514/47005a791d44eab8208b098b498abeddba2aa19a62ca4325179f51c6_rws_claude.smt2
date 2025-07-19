(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration content
(declare-const config_line string)
(declare-const ini_content string)
(declare-const section_line string)
(declare-const key_value_pair string)
(declare-const extracted_key string)
(declare-const extracted_value string)
(declare-const section_name string)
(declare-const full_config string)

; Declare integer variables for split operations
(declare-const num_equals_splits int)
(declare-const num_colon_splits int)
(declare-const num_newline_splits int)
(declare-const num_bracket_splits int)
(declare-const section_index int)
(declare-const key_index int)
(declare-const value_index int)

; Configuration line with key-value pair using equals delimiter
(assert (= config_line "database_host=localhost"))

; ; Extract key and value from equals-separated pair
(assert (= num_equals_splits (str.num_splits config_line "=")))
(assert (= num_equals_splits 2))
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))

; Key validation: ensure key is non-empty and contains valid characters
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "\n")))
(assert (not (str.contains extracted_key "[")))
(assert (not (str.contains extracted_key "]")))

; ; Value extraction validation
(assert (> (str.len extracted_value) 0))
(assert (= extracted_key "database_host"))
(assert (= extracted_value "localhost"))

; INI section handling with brackets
(assert (= section_line "[database]"))
(assert (= num_bracket_splits (str.num_splits section_line "[")))
(assert (= num_bracket_splits 2))

; ; Extract section name between brackets
(declare-const section_with_bracket string)
(assert (= section_with_bracket (str.split_at section_line "[" 1)))
(assert (= (str.num_splits section_with_bracket "]") 2))
(assert (= section_name (str.split_at section_with_bracket "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nport=8080\nhost=127.0.0.1\n[database]\nname=mydb\nuser=admin"))

; Count total lines in configuration
(declare-const total_lines int)
(assert (= total_lines (str.num_splits ini_content "\n")))
(assert (= total_lines 6))

; ; Extract specific configuration lines
(declare-const first_section string)
(declare-const port_line string)
(declare-const host_line string)
(declare-const db_section string)

(assert (= first_section (str.split_at ini_content "\n" 0)))
(assert (= port_line (str.split_at ini_content "\n" 1)))
(assert (= host_line (str.split_at ini_content "\n" 2)))
(assert (= db_section (str.split_at ini_content "\n" 3)))

; ; Validate section headers
(assert (str.prefixof "[" first_section))
(assert (str.suffixof "]" first_section))
(assert (str.prefixof "[" db_section))
(assert (str.suffixof "]" db_section))

; Process port configuration line
(declare-const port_key string)
(declare-const port_value string)
(assert (= (str.num_splits port_line "=") 2))
(assert (= port_key (str.split_at port_line "=" 0)))
(assert (= port_value (str.split_at port_line "=" 1)))
(assert (= port_key "port"))
(assert (= port_value "8080"))

; Process host configuration line
(declare-const host_key string)
(declare-const host_value string)
(assert (= (str.num_splits host_line "=") 2))
(assert (= host_key (str.split_at host_line "=" 0)))
(assert (= host_value (str.split_at host_line "=" 1)))
(assert (= host_key "host"))
(assert (= host_value "127.0.0.1"))

; Alternative colon delimiter handling
(declare-const colon_config string)
(declare-const colon_key string)
(declare-const colon_value string)
(assert (= colon_config "timeout:30"))
(assert (= (str.num_splits colon_config ":") 2))
(assert (= colon_key (str.split_at colon_config ":" 0)))
(assert (= colon_value (str.split_at colon_config ":" 1)))
(assert (= colon_key "timeout"))
(assert (= colon_value "30"))

; Complex configuration with multiple sections
(assert (= full_config "[web]\nport=80\nssl=true\n[cache]\nttl=3600\nsize=1024"))

; ; Extract remaining content after first section
(declare-const remaining_after_web string)
(assert (= remaining_after_web (str.split_rest full_config "\n" 3)))
(assert (str.contains remaining_after_web "[cache]"))
(assert (str.contains remaining_after_web "ttl=3600"))

; Key validation constraints for complex keys
(declare-const complex_key string)
(assert (= complex_key "database_connection_pool_size"))
(assert (> (str.len complex_key) 5))
(assert (not (str.contains complex_key "=")))
(assert (not (str.contains complex_key ":")))
(assert (not (str.contains complex_key "[")))
(assert (not (str.contains complex_key "]")))

; Section name validation
(declare-const valid_section string)
(assert (= valid_section "application_settings"))
(assert (> (str.len valid_section) 0))
(assert (not (str.contains valid_section "[")))
(assert (not (str.contains valid_section "]")))
(assert (not (str.contains valid_section "\n")))
(assert (not (str.contains valid_section "=")))

; Invalid configuration detection
(declare-const invalid_line string)
(assert (= invalid_line "malformed_line_without_delimiter"))
(assert (= (str.num_splits invalid_line "=") 1))
(assert (= (str.num_splits invalid_line ":") 1))

; Ensure proper key-value structure
(declare-const valid_kv_line string)
(assert (= valid_kv_line "max_connections=100"))
(assert (> (str.num_splits valid_kv_line "=") 1))

; ; Extract configuration remainder for processing
(declare-const config_remainder string)
(assert (= config_remainder (str.split_rest full_config "\n" 1)))
(assert (str.contains config_remainder "port=80"))
(assert (str.contains config_remainder "ssl=true"))

(check-sat)
(exit)