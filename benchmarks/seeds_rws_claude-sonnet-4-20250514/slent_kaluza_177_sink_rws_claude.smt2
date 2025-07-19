(set-logic QF_S)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :category "industrial")

; Declare string variables for configuration content
(declare-fun config_line1 () String)
(declare-fun config_line2 () String)
(declare-fun config_line3 () String)
(declare-fun ini_section () String)
(declare-fun full_config () String)

; ; Declare variables for extracted components
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun key2 () String)
(declare-fun value2 () String)
(declare-fun section_name () String)
(declare-fun section_content () String)

; Declare helper variables for split operations
(declare-fun temp_key () String)
(declare-fun temp_value () String)
(declare-fun cleaned_section () String)

; ; Configuration line examples
(assert (= config_line1 "database_host=localhost"))
(assert (= config_line2 "port:8080"))
(assert (= config_line3 "debug=true"))

; ; INI section example
(assert (= ini_section "[database]\nhost=localhost\nport=5432"))

; Full configuration with multiple sections
(assert (= full_config "[server]\nhost=0.0.0.0\nport=8080\n[database]\nhost=localhost\nport=5432"))

; ; Key-value extraction using equals delimiter
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))

; ; Key-value extraction using colon delimiter
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))

; ; Constraint: Keys must be non-empty and contain only valid characters
(assert (> (str.len key1) 0))
(assert (> (str.len key2) 0))
(assert (not (str.contains key1 " ")))
(assert (not (str.contains key2 " ")))

; ; Constraint: Values must be non-empty after extraction
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; ; Section name extraction from INI format
(assert (= temp_key (str.split_at ini_section "[" 1)))
(assert (= section_name (str.split_at temp_key "]" 0)))
(assert (= section_content (str.split_at ini_section "]" 1)))

; ; Constraint: Section name must be valid
(assert (> (str.len section_name) 0))
(assert (= section_name "database"))

; Split section content by newlines to get individual settings
(assert (= (str.num_splits section_content "\n") 3))

; ; Extract first setting from section content
(assert (= temp_key (str.split_at section_content "\n" 1)))
(assert (= (str.split_at temp_key "=" 0) "host"))
(assert (= (str.split_at temp_key "=" 1) "localhost"))

; ; Extract second setting from section content
(assert (= temp_value (str.split_at section_content "\n" 2)))
(assert (= (str.split_at temp_value "=" 0) "port"))
(assert (= (str.split_at temp_value "=" 1) "5432"))

; Validation constraints for configuration format
(assert (str.contains config_line1 "="))
(assert (str.contains config_line2 ":"))
(assert (= (str.num_splits config_line1 "=") 2))
(assert (= (str.num_splits config_line2 ":") 2))

; Section validation constraints
(assert (str.contains ini_section "["))
(assert (str.contains ini_section "]"))
(assert (= (str.num_splits ini_section "[") 2))
(assert (= (str.num_splits ini_section "]") 2))

; Multi-section configuration processing
(assert (= (str.num_splits full_config "[") 3))

; ; Extract server section
(assert (= temp_key (str.split_at full_config "[" 1)))
(assert (= (str.split_at temp_key "]" 0) "server"))

; ; Extract database section
(assert (= temp_value (str.split_at full_config "[" 2)))
(assert (= (str.split_at temp_value "]" 0) "database"))

; ; Constraint: Configuration lines must have proper structure
(assert (or (str.contains config_line1 "=") (str.contains config_line1 ":")))
(assert (or (str.contains config_line2 "=") (str.contains config_line2 ":")))

; Key validation: must not start with special characters
(assert (not (str.prefixof "[" key1)))
(assert (not (str.prefixof "]" key1)))
(assert (not (str.prefixof "=" key1)))
(assert (not (str.prefixof ":" key1)))

; Value validation: must not be empty or whitespace only
(assert (not (= value1 "")))
(assert (not (= value2 "")))
(assert (not (= value1 " ")))
(assert (not (= value2 " ")))

; Section content must contain valid key-value pairs
(assert (str.contains section_content "="))
(assert (> (str.num_splits section_content "=") 1))

; ; Constraint: Each line in section should be a valid assignment
(assert (let ((line1 (str.split_at section_content "\n" 1)))
 (and (str.contains line1 "=")
 (> (str.len (str.split_at line1 "=" 0)) 0)
 (> (str.len (str.split_at line1 "=" 1)) 0))))

; ; Constraint: Section names must be unique identifiers
(assert (and (not (= section_name ""))
 (not (str.contains section_name "="))
 (not (str.contains section_name ":"))
 (not (str.contains section_name "\n"))))

; Additional validation for full configuration structure
(assert (> (str.len full_config) 0))
(assert (str.contains full_config "\n"))

; Ensure proper section boundaries
(assert (= (str.num_splits full_config "]") 3))

; ; Extract remaining content after first section
(assert (= cleaned_section (str.split_rest full_config "[" 2)))
(assert (str.contains cleaned_section "database"))

(check-sat)
(exit)