
; SMT-LIB2 script for configuration parsing
; Focus: Key-value pair and INI file processing
; Delimiters: '=', ':', '\n', '[', ']'

(set-logic QF_SLIA) ; Quantifier-free strings
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const eq_delimiter String)
(assert (= eq_delimiter "="))
(declare-const colon_delimiter String)
(assert (= colon_delimiter ":"))
(declare-const newline String)
(assert (= newline "\n"))
(declare-const section_open String)
(assert (= section_open "["))
(declare-const section_close String)
(assert (= section_close "]"))

; ; Example configuration content
(declare-const config_content String)
(assert (= config_content (str.++ 
 "[database]\n"
 "host=localhost\n"
 "port:3306\n"
 "\n"
 "[server]\n"
 "address=127.0.0.1\n"
 "timeout=30\n")))

; Key validation constraints
(declare-const valid_key_chars String)
(assert (= valid_key_chars "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_-"))

(define-fun is_valid_key ((k String)) Bool
 (and
 (> (str.len k) 0)
 (forall ((i Int))
 (=> (and (>= i 0) (< i (str.len k)))
 (contains valid_key_chars (str.at k i))))))

; Section handling
(declare-const section_header String)
(assert (= section_header (str.split_at config_content newline 0)))

(assert (str.prefixof section_open section_header)) ; First line should be section
(assert (str.suffixof section_close section_header))

(declare-const section_name String)
(assert (= section_name 
 (str.substr section_header 1 (- (str.len section_header) 2))))

(assert (is_valid_key section_name)) ; Section name must be valid key

; ; Extract database section content
(declare-const db_section String)
(assert (= db_section 
 (str.split_rest config_content newline 1))) ; Skip section header

(declare-const db_section_lines String)
(assert (= db_section_lines 
 (str.split_at db_section (str.++ newline newline) 0))) ; Until empty line

; Parse host setting
(declare-const host_line String)
(assert (= host_line (str.split_at db_section_lines newline 0)))

(assert (or
 (str.contains host_line eq_delimiter)
 (str.contains host_line colon_delimiter)))

(declare-const host_key String)
(assert (= host_key 
 (str.split_at host_line eq_delimiter 0)))

(assert (is_valid_key host_key)) ; Validate host key
(assert (= host_key "host")) ; Expected key name

(declare-const host_value String)
(assert (= host_value 
 (str.split_at host_line eq_delimiter 1)))

(assert (= host_value "localhost")) ; Expected value

; Parse port setting
(declare-const port_line String)
(assert (= port_line (str.split_at db_section_lines newline 1)))

(assert (or
 (str.contains port_line eq_delimiter)
 (str.contains port_line colon_delimiter)))

(declare-const port_key String)
(assert (= port_key 
 (str.split_at port_line colon_delimiter 0)))

(assert (is_valid_key port_key)) ; Validate port key
(assert (= port_key "port")) ; Expected key name

(declare-const port_value String)
(assert (= port_value 
 (str.split_at port_line colon_delimiter 1)))

(assert (= port_value "3306")) ; Expected value

; Test unsatisfiable case - invalid section name
(declare-const invalid_section String)
(assert (= invalid_section "[invalid section]"))

(assert (not (is_valid_key 
 (str.substr invalid_section 1 (- (str.len invalid_section) 2)))))

; ; Test value extraction from rest of config
(declare-const server_section String)
(assert (= server_section 
 (str.split_rest config_content (str.++ newline newline) 1)))

(declare-const timeout_line String)
(assert (= timeout_line 
 (str.split_at (str.split_at server_section newline 2) newline 0)))

(declare-const timeout_value String)
(assert (= timeout_value 
 (str.split_at timeout_line eq_delimiter 1)))

(assert (str.is_digit timeout_value)) ; Timeout must be numeric
(assert (not (= timeout_value ""))) ; Must not be empty

(check-sat)
(exit)
