; SMT-LIB2 script for configuration file parsing with key-value pairs and INI sections
; ; Focuses on key validation, value extraction, and section handling
(set-logic ALL)
(set-option :produce-models true)

; Declare string constants for delimiters
(declare-const eq-delim String) ; '=' for key-value pairs
(declare-const colon-delim String) ; ':' alternative delimiter
(declare-const newline String) ; '\n' for line separation
(declare-const sec-open String) ; '[' for section opening
(declare-const sec-close String) ; ']' for section closing

(assert (= eq-delim "="))
(assert (= colon-delim ":"))
(assert (= newline "\n"))
(assert (= sec-open "["))
(assert (= sec-close "]"))

; Sample configuration content
(declare-const config1 String)
(declare-const config2 String)
(declare-const config3 String)

; Config1: Simple key-value pairs
(assert (= config1 (str.++ "key1=value1" newline "key2:value2" newline "key3=value3")))

; Config2: INI-style with sections
(assert (= config2 (str.++ "[database]" newline "host=localhost" newline "port=5432" newline 
 "[user]" newline "name=admin" newline "password=secret")))

; Config3: Mixed format (invalid case)
(assert (= config3 (str.++ "key1=value1" newline "[section" newline "key2=value2")))

; Key validation function constraints
(declare-fun valid_key (String) Bool)
(assert (forall ((k String)) 
 (= (valid_key k) 
 (and (not (str.contains k " ")) 
 (not (str.contains k eq-delim))
 (not (str.contains k colon-delim))
 (not (str.contains k newline))
 (not (str.contains k sec-open))
 (not (str.contains k sec-close))
 (> (str.len k) 0)))))

; Test key validation
(declare-const test_key1 String)
(declare-const test_key2 String)
(assert (= test_key1 "valid_key"))
(assert (= test_key2 "invalid key"))
(assert (valid_key test_key1))
(assert (not (valid_key test_key2)))

; ; Extract first key-value pair from config1
(declare-const first_line String)
(assert (= first_line (str.split_at config1 newline 0)))

(declare-const first_key String)
(declare-const first_val String)
(assert (or (= first_key (str.split_at first_line eq-delim 0))
 (= first_key (str.split_at first_line colon-delim 0))))
(assert (or (= first_val (str.split_at first_line eq-delim 1))
 (= first_val (str.split_at first_line colon-delim 1))))

; ; Verify the extracted key is valid
(assert (valid_key first_key))

; Section handling constraints
(declare-fun is_section_header (String) Bool)
(assert (forall ((line String))
 (= (is_section_header line)
 (and (str.prefixof sec-open line)
 (str.suffixof sec-close line)
 (> (str.len line) 2)))))

; Test section header detection
(declare-const section_test1 String)
(declare-const section_test2 String)
(assert (= section_test1 "[valid_section]"))
(assert (= section_test2 "invalid_section"))
(assert (is_section_header section_test1))
(assert (not (is_section_header section_test2)))

; ; Extract all sections from config2
(declare-const db_section String)
(declare-const user_section String)
(assert (= db_section (str.split_at config2 newline 0)))
(assert (= user_section (str.split_at config2 newline 4)))

; Verify sections are properly formatted
(assert (is_section_header db_section))
(assert (is_section_header user_section))

; ; Check for malformed section in config3
(declare-const malformed_section String)
(assert (= malformed_section (str.split_at config3 newline 1)))
(assert (not (is_section_header malformed_section)))

; Count total lines in each config
(declare-const config1_lines Int)
(declare-const config2_lines Int)
(assert (= config1_lines (str.num_splits config1 newline)))
(assert (= config2_lines (str.num_splits config2 newline)))
(assert (= config1_lines 3))
(assert (= config2_lines 6))

; ; Check if config3 has any valid sections
(assert (not (exists ((i Int)) 
 (and (>= i 0) 
 (< i (str.num_splits config3 newline))
 (is_section_header (str.split_at config3 newline i))))))

; ; Final checks
(check-sat)
(exit)