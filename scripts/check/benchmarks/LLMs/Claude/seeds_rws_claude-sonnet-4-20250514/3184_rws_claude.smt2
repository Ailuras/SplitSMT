(set-logic QF_SLIA)
(set-info :source |Configuration Parsing: Key-value pair and INI file processing|)
(set-info :status unknown)

; Declare string variables for configuration parsing
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

; ; Configuration line examples with key-value pairs
(assert (= config_line1 "database_host=localhost"))
(assert (= config_line2 "port:8080"))
(assert (= config_line3 "timeout=30"))

; ; INI section example
(assert (= ini_section "[database]\nhost=localhost\nport=5432\n[server]\nport=8080\ntimeout=30"))

; Multi-line configuration
(assert (= full_config "debug=true\nlog_level:info\n[database]\nhost=localhost\nport=5432"))

; ; Key validation: Extract keys from key-value pairs using '=' delimiter
(assert (= key1 (str.split_at config_line1 "=" 0)))
(assert (= value1 (str.split_at config_line1 "=" 1)))

; ; Key validation: Extract keys from key-value pairs using ':' delimiter
(assert (= key2 (str.split_at config_line2 ":" 0)))
(assert (= value2 (str.split_at config_line2 ":" 1)))

; Key validation constraints: keys must be non-empty and contain valid characters
(assert (> (str.len key1) 0))
(assert (> (str.len key2) 0))
(assert (not (str.contains key1 " ")))
(assert (not (str.contains key2 " ")))

; ; Value extraction: values must be non-empty after trimming
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; ; Section handling: Extract section name from INI format
(assert (str.contains ini_section "[database]"))
(assert (= (str.num_splits ini_section "[") 2))

; ; Extract section name by finding content between brackets
(assert (let ((bracket_split (str.split_at ini_section "[" 1)))
 (= section_name (str.split_at bracket_split "]" 0))))

; ; Section content extraction after section header
(assert (let ((after_section (str.split_at ini_section "]" 1)))
 (= section_content (str.split_at after_section "\n" 1))))

; ; Validate section name is non-empty
(assert (> (str.len section_name) 0))
(assert (= section_name "database"))

; Multi-line configuration parsing
(assert (= (str.num_splits full_config "\n") 4))

; ; Extract first configuration line
(assert (let ((first_line (str.split_at full_config "\n" 0)))
 (and (str.contains first_line "=")
 (= (str.split_at first_line "=" 0) "debug")
 (= (str.split_at first_line "=" 1) "true"))))

; ; Extract second configuration line with colon delimiter
(assert (let ((second_line (str.split_at full_config "\n" 1)))
 (and (str.contains second_line ":")
 (= (str.split_at second_line ":" 0) "log_level")
 (= (str.split_at second_line ":" 1) "info"))))

; Section validation in multi-line config
(assert (let ((section_line (str.split_at full_config "\n" 2)))
 (and (str.contains section_line "[")
 (str.contains section_line "]")
 (= (str.split_at (str.split_at section_line "[" 1) "]" 0) "database"))))

; Key-value pair validation within sections
(assert (let ((db_host_line (str.split_at full_config "\n" 3)))
 (and (str.contains db_host_line "=")
 (= (str.split_at db_host_line "=" 0) "host")
 (= (str.split_at db_host_line "=" 1) "localhost"))))

; ; Constraint: Port values must be numeric strings
(assert (let ((port_line (str.split_at full_config "\n" 4)))
 (and (str.contains port_line "=")
 (= (str.split_at port_line "=" 0) "port")
 (let ((port_val (str.split_at port_line "=" 1)))
 (and (> (str.len port_val) 0)
 (str.is_digit (str.at port_val 0)))))))

; Section boundary validation: content after section header
(assert (let ((remaining_after_db (str.split_rest ini_section "\n" 2)))
 (str.contains remaining_after_db "host=localhost")))

; Key uniqueness within sections (conflicting constraint for unsatisfiability test)
(assert (let ((all_keys (str.split_at (str.replace ini_section "=" "\n") "\n" 0)))
 (not (= all_keys all_keys))))

; Invalid section format detection
(assert (not (str.contains config_line1 "[")))
(assert (not (str.contains config_line2 "]")))

; Configuration validation: ensure proper delimiter usage
(assert (or (str.contains config_line1 "=") (str.contains config_line1 ":")))
(assert (or (str.contains config_line2 "=") (str.contains config_line2 ":")))

; Complex section parsing with multiple delimiters
(assert (let ((section_parts (str.num_splits ini_section "]")))
 (>= section_parts 2)))

(check-sat)
(exit)