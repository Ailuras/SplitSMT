; SMT-LIB2 file for Configuration Parsing: Key-Value Pair and INI File Processing
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic QF_S)

; Declare the configuration line variable (e.g., "user=admin")
(declare-fun config_line () String)

; Declare the section header variable (e.g., "[database]")
(declare-fun section_header () String)

; Declare the delimiter constants
(define-fun eq_delim () String "=")
(define-fun colon_delim () String ":")
(define-fun nl_delim () String "\n")
(define-fun lbracket () String "[")
(define-fun rbracket () String "]")

; ; Key-Value pair extraction
; ; For a config line "key=value", extract key and value segments
(define-fun key_part () String (str.split_at config_line eq_delim 0))
(define-fun value_part () String (str.split_at config_line eq_delim 1))

; ; Section extraction: extract section name from a header like "[section]"
(define-fun section_name () String (str.split_at (str.split_at section_header rbracket 0) lbracket 1))

; ; Example constraints for a configuration file

;------------------------------
; Satisfiable Scenario
;------------------------------
; ; Example: config_line = "user=admin"
(assert (= config_line "user=admin"))
; The key should be "user"
(assert (= key_part "user"))
; The value should be "admin"
(assert (= value_part "admin"))

; ; Example: section_header = "[database]"
(assert (= section_header "[database]"))
; The section_name should be "database"
(assert (= section_name "database"))

; Ensure that the config line contains exactly two segments when split by '='
(assert (= (str.num_splits config_line eq_delim) 2))

; Key validation: key should not be empty and should not contain '=' or ':'
(assert (and
 (> (str.len key_part) 0)
 (= (str.contains key_part eq_delim) false)
 (= (str.contains key_part colon_delim) false)
))

; ; Value extraction: value can be empty but should not contain a newline
(assert (= (str.contains value_part nl_delim) false))

; Section validation: section_name should not contain '[' or ']'
(assert (and
 (= (str.contains section_name lbracket) false)
 (= (str.contains section_name rbracket) false)
))

;------------------------------
; Unsatisfiable Scenario
;------------------------------
; ; Example: config_line must not contain an '=' in the key, but here it does
; Set up a situation that cannot be satisfied:

; New config line with an invalid key (contains '=')
(declare-fun invalid_config_line () String)
(assert (= invalid_config_line "foo=bar=baz"))

; ; Extract invalid key
(define-fun invalid_key_part () String (str.split_at invalid_config_line eq_delim 0))

; Enforce that key does NOT contain '=', but in this case it does (invalid_key_part = "foo")
; However, let's require that key equals "foo=bar", which is not the case
(assert (= invalid_key_part "foo=bar"))

;------------------------------
; Section Handling with Split Rest
;------------------------------
; ; Example: parsing all keys in a section split by newlines
(declare-fun section_block () String)
; ; Example: section_block = "user=admin\npassword=xyz\n"
(assert (= section_block "user=admin\npassword=xyz\n"))

; The first key-value line in section
(define-fun first_line () String (str.split_at section_block nl_delim 0))
; The rest of the block after the first line (including delimiter)
(define-fun rest_block () String (str.split_rest section_block nl_delim 1))

; Ensure the first line is "user=admin"
(assert (= first_line "user=admin"))

; Ensure the rest_block starts with "password=xyz"
(assert (str.prefixof "password=xyz" rest_block))

; Ensure there are exactly 3 segments (including the empty string after the last newline)
(assert (= (str.num_splits section_block nl_delim) 3))

(check-sat)
(exit)