; SMT-LIB2 file for Configuration Parsing: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'
; ; Focus: key validation, value extraction, section handling

(set-logic ALL)

; Declare string variables representing lines and sections in the INI file
(declare-fun line1 () String)
(declare-fun line2 () String)
(declare-fun section_header () String)
(declare-fun section_name () String)
(declare-fun key () String)
(declare-fun value () String)
(declare-fun kv_line () String)

; ; Example: Section header is of the form "[section]"
; ; We want to extract 'section' from '[section]'
(assert (= section_header (str.++ "[" section_name "]")))

; ; Use str.split_at to extract the section name from section_header
; Split section_header at '[' and get segment 1: section name plus ']'
(assert (= (str.split_at section_header "[" 1) (str.++ section_name "]")))

; Further split at ']' to get the section name alone
(assert (= (str.split_at (str.++ section_name "]") "]" 0) section_name))

; ; Example key-value line: "user=admin"
(assert (= kv_line (str.++ key "=" value)))

; ; Split kv_line at '=' to extract key and value
(assert (= (str.split_at kv_line "=" 0) key))
(assert (= (str.split_at kv_line "=" 1) value))

; Key validation: keys must not contain '=', ':', '[', ']', or '\n'
(assert (not (str.contains key "=")))
(assert (not (str.contains key ":")))
(assert (not (str.contains key "["))
)
(assert (not (str.contains key "]")))
(assert (not (str.contains key "\n")))

; Value can contain anything except line breaks
(assert (not (str.contains value "\n")))

; Suppose line1 is a key-value line with ':' delimiter, e.g. "path:/usr/bin"
(assert (= line1 (str.++ "path" ":" "/usr/bin")))

; ; Extract key and value from line1 using ':' delimiter
(assert (= (str.split_at line1 ":" 0) "path"))
(assert (= (str.split_at line1 ":" 1) "/usr/bin"))

; Suppose line2 is a key-value line with '=', e.g. "timeout=30"
(assert (= line2 (str.++ "timeout" "=" "30")))

; ; Extract number of splits for line2 at '=' should be 2 (key and value)
(assert (= (str.num_splits line2 "=") 2))

; Section handling: suppose section_header = "[main]"
(assert (= section_header "[main]"))
(assert (= section_name "main"))

; ; Extract key and value from kv_line: e.g. "user=admin"
(assert (= kv_line "user=admin"))
(assert (= key "user"))
(assert (= value "admin"))

; ; Now, an unsatisfiable constraint: key should not contain 'e', but in this example, key is "user"
(assert (not (str.contains key "e")))

; ; Satisfiable constraint: value is "admin", does not contain "\n"
(assert (not (str.contains value "\n")))

; Section name must not be empty
(assert (not (= section_name "")))

; ; Example using str.split_rest: get the rest of line1 after the key (i.e. ":/usr/bin")
(assert (= (str.split_rest line1 ":" 1) ":/usr/bin"))

; Unsatisfiable: value must be both "admin" and "root"
(assert (= value "root"))

(check-sat)
(exit)