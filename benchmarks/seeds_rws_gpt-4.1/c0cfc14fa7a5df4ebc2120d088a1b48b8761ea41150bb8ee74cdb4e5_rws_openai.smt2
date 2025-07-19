; SMT-LIB2 file for Configuration Parsing: Key-value and INI file processing
; ; Focus: key validation, value extraction, section handling
; Delimiters used: '=', ':', '\n', '[', ']'

(set-logic QF_S)

; ; Declare the configuration string (an example INI segment)
(declare-fun cfg () String)

; Declare variables for key, value, and section names
(declare-fun key1 () String)
(declare-fun value1 () String)
(declare-fun section_name () String)

; ; Example: [section1]\nkey1=value1\nkey2:value2\n
; Constraints:
; 1. The configuration string starts with a section header
(assert (= (str.at cfg 0) "["))

; ; 2. Extract the section header
; The section name is between '[' and ']'
; Find the position of ']'
(declare-fun idx_close_bracket () Int)
(assert (= idx_close_bracket (str.indexof cfg "]" 0)))

; The section name is the first segment after splitting by '[' and then by ']'
(assert (= section_name (str.split_at (str.split_at cfg "[" 1) "]" 0)))

; The section name should not be empty (key validation)
(assert (not (= section_name "")))

; 3. There is at least one key-value pair after the section header
; Get the rest of the config after the first ']'
(declare-fun rest_cfg () String)
(assert (= rest_cfg (str.split_rest cfg "]" 1)))

; The first key-value line is after a newline (could be directly after ']' if no newline)
; We split rest_cfg by "\n"
(declare-fun kv_line1 () String)
(assert (= kv_line1 (str.split_at rest_cfg "\n" 0)))

; Key-value pairs can be separated by '=' or ':'
; ; We will check both possibilities for the first key-value line

; If '=' appears in kv_line1
(declare-fun idx_eq () Int)
(assert (= idx_eq (str.indexof kv_line1 "=" 0)))

; If ':' appears in kv_line1
(declare-fun idx_colon () Int)
(assert (= idx_colon (str.indexof kv_line1 ":" 0)))

; ; Satisfiable constraint: '=' is present before ':'
(assert (and (>= idx_eq 0)
 (or (< idx_eq idx_colon) (< idx_colon 0))))

; ; Extract key and value for '='-separated pair
(assert (= key1 (str.split_at kv_line1 "=" 0)))
(assert (= value1 (str.split_rest kv_line1 "=" 1)))

; Key must be valid: non-empty, only alphanumeric (simulate with no '[' or ']' or '=' or ':' or whitespace)
(assert (not (= key1 "")))
(assert (= (str.indexof key1 "[" 0) (- 1)))
(assert (= (str.indexof key1 "]" 0) (- 1)))
(assert (= (str.indexof key1 "=" 0) (- 1)))
(assert (= (str.indexof key1 ":" 0) (- 1)))
(assert (= (str.indexof key1 " " 0) (- 1)))
(assert (= (str.indexof key1 "\n" 0) (- 1)))

; Value can be any string except it should not contain a newline (simulate simple value)
(assert (= (str.indexof value1 "\n" 0) (- 1)))

; ; Satisfiable: Specific example
(assert (= cfg "[main]\nusername=admin\npassword:secret\n"))
; Now section_name = "main", key1 = "username", value1 = "admin"

; ; --- Unsatisfiable constraints example ---
; Now, add an unsatisfiable requirement: key1 must contain '['
(assert (not (= (str.indexof key1 "[" 0) (- 1))))

(check-sat)
(exit)