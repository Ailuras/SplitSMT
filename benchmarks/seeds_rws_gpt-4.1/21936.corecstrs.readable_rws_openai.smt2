; SMT-LIB2 for INI Configuration Parsing: Key-Value and Section Handling
; Delimiters used: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare variables for two lines and a section header
(declare-fun kv_line1 () String) ; example: "username=admin"
(declare-fun kv_line2 () String) ; example: "password:secret"
(declare-fun section_line () String) ; example: "[general]"

; Split kv_line1 at '='
(define-fun key1 () String (str.split_at kv_line1 "=" 0))
(define-fun value1 () String (str.split_at kv_line1 "=" 1))
(define-fun splits1 () Int (str.num_splits kv_line1 "="))

; Split kv_line2 at ':'
(define-fun key2 () String (str.split_at kv_line2 ":" 0))
(define-fun value2 () String (str.split_at kv_line2 ":" 1))
(define-fun splits2 () Int (str.num_splits kv_line2 ":"))

; ; Section extraction: "[general]" => section name between '[' and ']'
(define-fun after_bracket () String (str.split_at section_line "[" 1)) ; "general]"
(define-fun section_name () String (str.split_at after_bracket "]" 0))
(define-fun section_splits () Int (str.num_splits section_line "["))

; --- Key-Value Assertions ---

; Assert kv_line1 contains exactly 1 '=' (produces 2 segments)
(assert (= splits1 2))
; Assert key1 is non-empty and its value is "username"
(assert (not (= key1 "")))
(assert (= key1 "username"))
; Assert value1 is non-empty and equal to "admin"
(assert (not (= value1 "")))
(assert (= value1 "admin"))

; Assert kv_line2 contains exactly 1 ':' (produces 2 segments)
(assert (= splits2 2))
; Assert key2 is non-empty and its value is "password"
(assert (not (= key2 "")))
(assert (= key2 "password"))
; Assert value2 is non-empty and equal to "secret"
(assert (not (= value2 "")))
(assert (= value2 "secret"))

; --- Section Handling Assertions ---

; Assert section_line starts with '[' and ends with ']'
(assert (str.prefixof "[" section_line))
(assert (str.suffixof "]" section_line))
; ; Assert section extraction produces exactly 2 splits with "["
(assert (= section_splits 2))
; ; Assert extracted section_name is non-empty and is "general"
(assert (not (= section_name "")))
(assert (= section_name "general"))

; ; --- Key Validation: Unsatisfiable Constraint Example ---
; Force contradiction: key1 is both "username" and "email"
(assert (= key1 "email"))

(check-sat)
(exit)