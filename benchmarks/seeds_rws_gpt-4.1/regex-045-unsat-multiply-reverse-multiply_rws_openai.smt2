; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic QF_SLIA)

; Declare string variables for an INI file line and section
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun section_header () String)

; ; Example 1: Key-value line using '=' delimiter, e.g., "user=admin"
; ; Extract key and value
(define-fun key1 () String (str.split_at line1 "=" 0))
(define-fun value1 () String (str.split_at line1 "=" 1))
(define-fun num_pairs1 () Int (str.num_splits line1 "="))

; Key validation: Key is not empty and does not contain '='
(assert (not (= key1 "")))
(assert (= (str.contains key1 "=") false))

; ; Value extraction: Value is not empty
(assert (not (= value1 "")))

; Ensure exactly 2 parts after splitting by '='
(assert (= num_pairs1 2))

; ; Example 2: Alternate key-value using ':' delimiter, e.g., "timeout:30"
(define-fun key2 () String (str.split_at line2 ":" 0))
(define-fun value2 () String (str.split_at line2 ":" 1))
(define-fun num_pairs2 () Int (str.num_splits line2 ":"))

; Key validation: Key is not empty and does not contain ':'
(assert (not (= key2 "")))
(assert (= (str.contains key2 ":") false))

; ; Value extraction: Value is not empty
(assert (not (= value2 "")))

; Ensure exactly 2 parts after splitting by ':'
(assert (= num_pairs2 2))

; ; Example 3: Section header handling, e.g., "[Database]"
; The section name is between '[' and ']'
; We assume section_header is of the form "[Database]"
(define-fun section_open () String (str.split_at section_header "[" 1))
(define-fun section_name () String (str.split_at section_open "]" 0))
(define-fun section_close () String (str.split_at section_open "]" 1))

; Section name is not empty and does not contain brackets
(assert (not (= section_name "")))
(assert (= (str.contains section_name "[") false))
(assert (= (str.contains section_name "]") false))

; Section header must start with '[' and end with ']'
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))

; ; Example 4: Multi-line INI content, extracting second line (value extraction)
(declare-fun ini_content () String)
; ini_content is a string like "[Database]\nuser=admin\ntimeout=30"
; ; Extract second line using split by '\n'
(define-fun second_line () String (str.split_at ini_content "\n" 1))
(define-fun second_key () String (str.split_at second_line "=" 0))
(define-fun second_value () String (str.split_at second_line "=" 1))

; The key in the second line is "user"
(assert (= second_key "user"))
; The value in the second line is "admin"
(assert (= second_value "admin"))

; ; Example 5: Section rest extraction: all lines after section header
(define-fun rest_after_section () String (str.split_rest ini_content "\n" 1))
; Should start with 'user='
(assert (str.prefixof "user=" rest_after_section))

; ; Unsatisfiable constraint: Key and value are the same in a key-value line with '='
(assert (not (= key1 value1)))
(assert (= key1 value1)) ; This creates contradiction for unsat

(check-sat)
(exit)