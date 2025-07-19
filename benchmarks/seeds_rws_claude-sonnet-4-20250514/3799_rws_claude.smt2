(set-info :status unknown)
(set-logic QF_SLIA)

; Configuration Parsing: Key-value pair and INI file processing
; Delimiters: =, :, \n, [, ]
; ; Focus: key validation, value extraction, section handling

; Declare string variables for configuration content
(declare-const config_line string)
(declare-const ini_content string)
(declare-const section_header string)
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
(declare-const line_count int)

; Configuration line parsing with equals delimiter
(assert (= config_line "database_host=localhost"))
(assert (= num_equals_splits (str.num_splits config_line "=")))
(assert (= num_equals_splits 2))

; ; Extract key and value from equals-separated pair
(assert (= extracted_key (str.split_at config_line "=" 0)))
(assert (= extracted_value (str.split_at config_line "=" 1)))
(assert (= extracted_key "database_host"))
(assert (= extracted_value "localhost"))

; Key validation constraints
(assert (> (str.len extracted_key) 0))
(assert (not (str.contains extracted_key " ")))
(assert (not (str.contains extracted_key "\t")))
(assert (not (str.prefixof "=" extracted_key)))
(assert (not (str.suffixof "=" extracted_key)))

; Alternative colon-separated configuration
(assert (= key_value_pair "port: 5432"))
(assert (= num_colon_splits (str.num_splits key_value_pair ":")))
(assert (= num_colon_splits 2))

; ; Extract from colon-separated format
(declare-const colon_key string)
(declare-const colon_value string)
(assert (= colon_key (str.split_at key_value_pair ":" 0)))
(assert (= colon_value (str.split_at key_value_pair ":" 1)))
(assert (= colon_key "port"))
(assert (str.prefixof " " colon_value))

; Section header parsing
(assert (= section_header "[database]"))
(assert (= num_bracket_splits (str.num_splits section_header "[")))
(assert (= num_bracket_splits 2))

; ; Extract section name between brackets
(declare-const after_open_bracket string)
(assert (= after_open_bracket (str.split_at section_header "[" 1)))
(declare-const bracket_close_splits int)
(assert (= bracket_close_splits (str.num_splits after_open_bracket "]")))
(assert (= bracket_close_splits 2))
(assert (= section_name (str.split_at after_open_bracket "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n\n[database]\nhost=db.example.com\nport=5432"))
(assert (= line_count (str.num_splits ini_content "\n")))
(assert (= line_count 7))

; ; Extract specific lines
(declare-const first_line string)
(declare-const second_line string)
(declare-const third_line string)
(assert (= first_line (str.split_at ini_content "\n" 0)))
(assert (= second_line (str.split_at ini_content "\n" 1)))
(assert (= third_line (str.split_at ini_content "\n" 2)))
(assert (= first_line "[server]"))
(assert (= second_line "host=example.com"))
(assert (= third_line "port=8080"))

; ; Validate section header format
(assert (str.prefixof "[" first_line))
(assert (str.suffixof "]" first_line))

; ; Extract and validate key-value from second line
(declare-const line2_key string)
(declare-const line2_value string)
(declare-const line2_splits int)
(assert (= line2_splits (str.num_splits second_line "=")))
(assert (= line2_splits 2))
(assert (= line2_key (str.split_at second_line "=" 0)))
(assert (= line2_value (str.split_at second_line "=" 1)))
(assert (= line2_key "host"))
(assert (= line2_value "example.com"))

; ; Key validation for extracted key
(assert (> (str.len line2_key) 0))
(assert (not (str.contains line2_key "=")))
(assert (not (str.contains line2_key "[")))
(assert (not (str.contains line2_key "]")))

; ; Value extraction validation
(assert (> (str.len line2_value) 0))
(assert (not (str.contains line2_value "\n")))

; Complex configuration with multiple sections
(declare-const complex_config string)
(assert (= complex_config "[app]\nname=MyApp\nversion=1.0\n[logging]\nlevel=INFO\nfile=app.log"))

; Count sections by counting opening brackets
(declare-const section_count int)
(assert (= section_count (str.num_splits complex_config "[")))
(assert (= section_count 3))

; ; Extract configuration remainder after first section
(declare-const config_rest string)
(assert (= config_rest (str.split_rest complex_config "[" 1)))
(assert (str.contains config_rest "app]\nname=MyApp\nversion=1.0\n[logging]\nlevel=INFO\nfile=app.log"))

; ; Validate no empty keys in configuration
(declare-const empty_key_config string)
(assert (= empty_key_config "=invalid"))
(declare-const empty_key_splits int)
(assert (= empty_key_splits (str.num_splits empty_key_config "=")))
(assert (= empty_key_splits 2))
(declare-const empty_key string)
(assert (= empty_key (str.split_at empty_key_config "=" 0)))
(assert (= (str.len empty_key) 0))

; This should make the configuration invalid
(assert (> (str.len empty_key) 0))

; Additional validation for proper section nesting
(declare-const nested_check string)
(assert (= nested_check "[section1]\nkey1=value1\n[section2]\nkey2=value2"))
(declare-const nested_lines int)
(assert (= nested_lines (str.num_splits nested_check "\n")))
(assert (= nested_lines 5))

; Ensure sections are properly formatted
(declare-const section1_line string)
(declare-const section2_line string)
(assert (= section1_line (str.split_at nested_check "\n" 0)))
(assert (= section2_line (str.split_at nested_check "\n" 2)))
(assert (str.prefixof "[" section1_line))
(assert (str.suffixof "]" section1_line))
(assert (str.prefixof "[" section2_line))
(assert (str.suffixof "]" section2_line))

(check-sat)
(exit)