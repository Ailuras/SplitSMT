; SMT-LIB2 file for Configuration Parsing: Key-value pairs and INI file processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)
(set-option :produce-models true)

; Declare variables representing lines, keys, values, and sections
(declare-fun config_line () String)
(declare-fun key () String)
(declare-fun value () String)
(declare-fun section_header () String)
(declare-fun section_name () String)
(declare-fun ini_file () String)
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun line3 () String)

; ; Example 1: Key-value line using '=' as delimiter
(assert (= config_line "username=admin"))

; The key is the first part before '='
(assert (= key (str.split_at config_line "=" 0)))

; The value is the second part after '='
(assert (= value (str.split_at config_line "=" 1)))

; There should be exactly 2 splits for a well-formed key-value pair
(assert (= (str.num_splits config_line "=") 2))

; Key validation: keys must not be empty and must not contain spaces
(assert (and (not (= key "")) (= (str.indexof key " " 0) -1)))

; ; Value extraction: value is not empty
(assert (not (= value "")))

; ; Example 2: Section header parsing, e.g., [section]
(assert (= section_header "[server]"))

; Section name is the part between '[' and ']'
; First, remove the '[' by splitting at '[' and taking the rest
(assert (= (str.at section_header 0) "[")) ; Ensure header starts with '['
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Section name must not be empty
(assert (not (= section_name "")))

; ; Example 3: Full INI file with multiple lines
(assert (= ini_file "[server]\nusername=admin\npassword=secret"))

; Split the file into lines by '\n'
(assert (= (str.num_splits ini_file "\n") 3))
(assert (= line1 (str.split_at ini_file "\n" 0)))
(assert (= line2 (str.split_at ini_file "\n" 1)))
(assert (= line3 (str.split_at ini_file "\n" 2)))

; The first line is a section header
(assert (= line1 "[server]"))

; The second line is a key-value pair for username
(assert (= (str.split_at line2 "=" 0) "username"))
(assert (= (str.split_at line2 "=" 1) "admin"))

; The third line is a key-value pair for password
(assert (= (str.split_at line3 "=" 0) "password"))
(assert (= (str.split_at line3 "=" 1) "secret"))

; ; Unsatisfiable Example: Key contains a space (invalid)
(declare-fun bad_config_line () String)
(declare-fun bad_key () String)
(assert (= bad_config_line "user name:guest"))
(assert (= bad_key (str.split_at bad_config_line ":" 0)))
; This should be unsatisfiable: key contains a space
(assert (= (str.indexof bad_key " " 0) -1))

; ; Unsatisfiable Example: Malformed section (no closing ']')
(declare-fun bad_section_header () String)
(declare-fun bad_section_name () String)
(assert (= bad_section_header "[data"))
; ; Try to extract section name (will not work correctly)
(assert (= bad_section_name (str.split_at (str.split_at bad_section_header "[" 1) "]" 0)))
; Section header must end with ']'
(assert (= (str.at bad_section_header (- (str.len bad_section_header) 1)) "]"))

(check-sat)
(exit)