; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare string variables representing an INI configuration line and section
(declare-fun config_line () String)
(declare-fun section_header () String)
(declare-fun key () String)
(declare-fun value () String)
(declare-fun section_name () String)

; ; Example: config_line could be "user_name=admin"
; section_header could be "[General]"

; ; Key validation: extract the key as the part before the first '=' or ':'
; ; Value extraction: extract the value as the part after the first '=' or ':'
; Section handling: parse the section name from the header

; ; Extract key and value using '=' delimiter
(assert (= key (str.split_at config_line "=" 0)))
(assert (= value (str.split_at config_line "=" 1)))

; Ensure that the config_line actually contains '=' delimiter (i.e., is a valid assignment)
(assert (> (str.num_splits config_line "=") 1))

; Key validation: key must not be empty and must not contain whitespace
(assert (not (= key "")))
(assert (= (str.contains key " ") false))

; ; Value extraction: value must not be empty
(assert (not (= value "")))

; Section header must be in the form "[section_name]"
; ; Extract section name between '[' and ']'
; section_header = "[" ++ section_name ++ "]"
(assert (= (str.at section_header 0) "["))
(assert (= (str.at section_header (- (str.len section_header) 1)) "]"))
(assert (= section_name (str.split_at (str.split_at section_header "[" 1) "]" 0)))

; Section name must not be empty and must not contain '[' or ']'
(assert (not (= section_name "")))
(assert (= (str.contains section_name "[") false))
(assert (= (str.contains section_name "]") false))

; Demonstrate split_rest usage: get the value and everything after the first '='
(assert (= (str.split_rest config_line "=" 1) (str.++ "=" value)))

; Satisfiable scenario: config_line has a valid key, value, and section header
(assert (= config_line "user_name=admin"))
(assert (= section_header "[General]"))

; Unsatisfiable scenario: try to force the key to be empty while requiring config_line to have a valid assignment
(push)
 (assert (= key ""))
 (check-sat)
(pop)

; Unsatisfiable scenario: section name includes an illegal character
(push)
 (assert (= section_header "[Inv@lid]"))
 (assert (= (str.contains section_name "@") false))
 (check-sat)
(pop)

; Satisfiable scenario: config_line with colon as delimiter, e.g., "port:8080"
(push)
 (assert (= config_line "port:8080"))
 (assert (= key (str.split_at config_line ":" 0)))
 (assert (= value (str.split_at config_line ":" 1)))
 (assert (> (str.num_splits config_line ":") 1))
 (check-sat)
(pop)

; Unsatisfiable scenario: value is empty, but config_line is an assignment
(push)
 (assert (= config_line "timeout="))
 (assert (= value ""))
 (check-sat)
(pop)

(check-sat)
(exit)