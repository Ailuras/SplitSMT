; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic QF_SLIA)

; ---------------------------
; Declarations
; ---------------------------

; ; Example configuration entries
(declare-fun config_line_eq () String) ; e.g., "username=admin"
(declare-fun config_line_colon () String) ; e.g., "port:8080"
(declare-fun section_header () String) ; e.g., "[database]"
(declare-fun section_body () String) ; e.g., "host=127.0.0.1\nport=3306"

; ---------------------------
; ; Key-value Extraction
; ---------------------------

; Split config_line_eq at '='
(define-fun key_eq () String (str.split_at config_line_eq "=" 0))
(define-fun val_eq () String (str.split_at config_line_eq "=" 1))

; Split config_line_colon at ':'
(define-fun key_colon () String (str.split_at config_line_colon ":" 0))
(define-fun val_colon () String (str.split_at config_line_colon ":" 1))

; ---------------------------
; Key Validation Constraints
; ---------------------------

; Keys must be non-empty and must not contain spaces or delimiters
(assert (and 
 (not (= key_eq "")) 
 (not (str.contains key_eq " "))
 (not (str.contains key_eq "="))
 (not (str.contains key_eq ":"))
 (not (str.contains key_eq "["))
 (not (str.contains key_eq "]"))
 (not (str.contains key_eq "\n"))
))

(assert (and 
 (not (= key_colon "")) 
 (not (str.contains key_colon " "))
 (not (str.contains key_colon "="))
 (not (str.contains key_colon ":"))
 (not (str.contains key_colon "["))
 (not (str.contains key_colon "]"))
 (not (str.contains key_colon "\n"))
))

; Values must be non-empty
(assert (not (= val_eq "")))
(assert (not (= val_colon "")))

; ---------------------------
; Section Header Handling
; ---------------------------

; Section header must start with '[' and end with ']'
(assert (str.prefixof "[" section_header))
(assert (str.suffixof "]" section_header))

; ; Extract section name between '[' and ']'
(define-fun section_inner () String (str.split_at section_header "[" 1))
(define-fun section_name () String (str.split_at section_inner "]" 0))

; Section name nonempty, no delimiters or spaces
(assert (and
 (not (= section_name ""))
 (not (str.contains section_name " "))
 (not (str.contains section_name "="))
 (not (str.contains section_name ":"))
 (not (str.contains section_name "["))
 (not (str.contains section_name "]"))
 (not (str.contains section_name "\n"))
))

; ---------------------------
; Section Body (multiple lines)
; ---------------------------

; Section body must contain at least two key-value pairs separated by '\n'
(assert (>= (str.num_splits section_body "\n") 2))

; ; Extract first assignment from section_body
(define-fun section_line0 () String (str.split_at section_body "\n" 0))
(define-fun section_line1 () String (str.split_at section_body "\n" 1))

; First line must contain '=' delimiter
(assert (str.contains section_line0 "="))

; ; Extract key and value from first line
(define-fun section_key0 () String (str.split_at section_line0 "=" 0))
(define-fun section_val0 () String (str.split_at section_line0 "=" 1))

; Key in first line must be non-empty, no spaces or delimiters
(assert (and
 (not (= section_key0 ""))
 (not (str.contains section_key0 " "))
 (not (str.contains section_key0 "="))
 (not (str.contains section_key0 ":"))
 (not (str.contains section_key0 "["))
 (not (str.contains section_key0 "]"))
 (not (str.contains section_key0 "\n"))
))

; Value in first line must be non-empty
(assert (not (= section_val0 "")))

; ---------------------------
; ; Satisfiable Example
; ---------------------------

(assert (= config_line_eq "username=admin"))
(assert (= config_line_colon "port:8080"))
(assert (= section_header "[database]"))
(assert (= section_body "host=127.0.0.1\nport=3306"))

; ---------------------------
; ; Unsatisfiable Example
; ---------------------------

; The section name is asserted to be both "database" and "server" which is impossible
(assert (= section_name "database"))
(assert (= section_name "server"))

(check-sat)
(exit)