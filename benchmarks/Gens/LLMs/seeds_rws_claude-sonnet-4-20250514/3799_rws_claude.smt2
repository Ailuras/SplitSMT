(set-info :status unknown)
(set-logic QF_SLIA)

; Configuration Parsing: Key-value pair and INI file processing
; Delimiters: =, :, \n, [, ]
; ; Focus: key validation, value extraction, section handling

; Declare string variables for configuration content
(declare-fun config_line () String)
(declare-fun ini_content () String)
(declare-fun section_header () String)
(declare-fun key_value_pair () String)
(declare-fun extracted_key () String)
(declare-fun extracted_value () String)
(declare-fun section_name () String)
(declare-fun full_config () String)

; Declare integer variables for split operations
(declare-const num_equals_splits Int)
(declare-const num_colon_splits Int)
(declare-const num_newline_splits Int)
(declare-const num_bracket_splits Int)
(declare-const line_count Int)

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
(declare-fun colon_key () String)
(declare-fun colon_value () String)
(assert (= colon_key (str.split_at key_value_pair ":" 0)))
(assert (= colon_value (str.split_at key_value_pair ":" 1)))
(assert (= colon_key "port"))
(assert (str.prefixof " " colon_value))

; Section header parsing
(assert (= section_header "[database]"))
(assert (= num_bracket_splits (str.num_splits section_header "[")))
(assert (= num_bracket_splits 2))

; ; Extract section name between brackets
(declare-fun after_open_bracket () String)
(assert (= after_open_bracket (str.split_at section_header "[" 1)))
(declare-const bracket_close_splits Int)
(assert (= bracket_close_splits (str.num_splits after_open_bracket "]")))
(assert (= bracket_close_splits 2))
(assert (= section_name (str.split_at after_open_bracket "]" 0)))
(assert (= section_name "database"))

; Multi-line INI content processing
(assert (= ini_content "[server]\nhost=example.com\nport=8080\n\n[database]\nhost=db.example.com\nport=5432"))
(assert (= line_count (str.num_splits ini_content "\n")))
(assert (= line_count 7))

; ; Extract specific lines
(declare-fun first_line () String)
(declare-fun second_line () String)
(declare-fun third_line () String)
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
(declare-const line2_key () String)
(declare-const line2_value () String)
(declare-const line2_splits Int)
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
(declare-fun complex_config () String)
(assert (= complex_config "[app]\nname=MyApp\nversion=1.0\n[logging]\nlevel=INFO\nfile=app.log"))

; Count sections by counting opening brackets
(declare-const section_count Int)
(assert (= section_count (str.num_splits complex_config "[")))
(assert (= section_count 3))

; ; Extract configuration remainder after first section
(declare-fun config_rest () String)
(assert (= config_rest (str.split_rest complex_config "[" 1)))
(assert (str.contains config_rest "app]\nname=MyApp\nversion=1.0\n[logging]\nlevel=INFO\nfile=app.log"))

; ; Validate no empty keys in configuration
(declare-fun empty_key_config () String)
(assert (= empty_key_config "=invalid"))
(declare-const empty_key_splits Int)
(assert (= empty_key_splits (str.num_splits empty_key_config "=")))
(assert (= empty_key_splits 2))
(declare-fun empty_key () String)
(assert (= empty_key (str.split_at empty_key_config "=" 0)))
(assert (= (str.len empty_key) 0))

; This should make the configuration invalid
(assert (> (str.len empty_key) 0))

; Additional validation for proper section nesting
(declare-fun nested_check () String)
(assert (= nested_check "[section1]\nkey1=value1\n[section2]\nkey2=value2"))
(declare-const nested_lines Int)
(assert (= nested_lines (str.num_splits nested_check "\n")))
(assert (= nested_lines 5))

; Ensure sections are properly formatted
(declare-fun section1_line () String)
(declare-fun section2_line () String)
(assert (= section1_line (str.split_at nested_check "\n" 0)))
(assert (= section2_line (str.split_at nested_check "\n" 2)))
(assert (str.prefixof "[" section1_line))
(assert (str.suffixof "]" section1_line))
(assert (str.prefixof "[" section2_line))
(assert (str.suffixof "]" section2_line))

(check-sat)
(exit)