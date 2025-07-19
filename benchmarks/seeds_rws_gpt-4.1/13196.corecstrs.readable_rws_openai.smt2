; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; ; Focus: key validation, value extraction, section handling
; Delimiters used: '=', ':', '\n', '[', ']'

(set-logic QF_S)

; Declare variables representing a configuration line and section
(declare-fun config_line () String)
(declare-fun section_header () String)

; ; Example: config_line could be "username=admin"
; section_header could be "[UserSettings]"

; Key validation: Ensure the key part of the config_line is non-empty and contains only alphanumerics
(define-fun key_part () String (str.trim (str.split_at config_line "=" 0)))
(define-fun value_part () String (str.split_rest config_line "=" 1))

; Assert that the delimiter '=' exists in the config_line
(assert (str.contains config_line "="))

; Assert that the key is non-empty
(assert (not (= key_part "")))

; ; Assert that the key contains only letters or digits (unsatisfiable constraint as example)
; For demonstration, let's require it is exactly "username" or "userid"
(assert (or (= key_part "username") (= key_part "userid")))

; ; Value extraction: value_part must not be empty
(assert (not (= value_part "")))

; ; Value extraction: value_part does not contain an '=' or ':' (simulate key-value split, value cannot further be split)
(assert (not (str.contains value_part "=")))
(assert (not (str.contains value_part ":")))

; Section handling: Ensure section_header properly delimited by '[' and ']'
; section_header could be "[UserSettings]"
(define-fun section_bracket_left () String (str.split_at section_header "[" 0))
(define-fun section_name () String (str.split_at (str.split_rest section_header "[" 1) "]" 0))
(define-fun section_bracket_right () String (str.split_rest (str.split_rest section_header "[" 1) "]" 1))

; section_header must start with '[' and end with ']'
(assert (= section_bracket_left ""))
(assert (= section_bracket_right ""))

; Section name must be non-empty and not contain '[' or ']'
(assert (not (= section_name "")))
(assert (not (str.contains section_name "[")))
(assert (not (str.contains section_name "]")))

; ; Satisfiable example: config_line is "username=admin", section_header is "[UserSettings]"
(assert (= config_line "username=admin"))
(assert (= section_header "[UserSettings]"))

; ; Unsatisfiable constraint: Try to force key_part to be "invalid key" (which violates earlier key validation)
(assert (= key_part "invalid key"))

(check-sat)
(exit)