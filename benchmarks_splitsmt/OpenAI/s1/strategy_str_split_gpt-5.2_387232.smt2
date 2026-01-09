(set-logic ALL)

; Uninterpreted split interface

; Seed variables (preserve core structure)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101935 () String)

; Additional variables for log analysis
(declare-const logline String)
(declare-const timestamp String)
(declare-const level String)
(declare-const component_and_message String)
(declare-const component_field String)
(declare-const msg_field String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hour_str String)
(declare-const min_str String)
(declare-const sec_str String)
(declare-const component_name String)
(declare-const message String)

; Core seed constraint: input must be non-empty
(assert (= T_1 (not (= "" var_0xINPUT_101935))))
(assert T_1)

; Tie seed input to the log line under analysis
(assert (= logline var_0xINPUT_101935))

; Log structure: "<timestamp> <level> <component>: <message>"
(assert (= timestamp (str.split_at logline " " 0)))
(assert (= level (str.split_at logline " " 1)))
(assert (= component_and_message (str.split_rest logline " " 2)))
(assert (>= (str.num_splits logline " ") 4))

; Component/message separated by ": "
(assert (>= (str.num_splits component_and_message ": ") 2))
(assert (= component_field (str.split_at component_and_message ": " 0)))
(assert (= msg_field (str.split_rest component_and_message ": " 1)))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SS"
(assert (>= (str.len timestamp) 19))
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

(assert (= date_part (str.substr timestamp 0 10)))
(assert (= time_part (str.substr timestamp 11 8)))

; Date digits: YYYY-MM-DD
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.+ (re.range "0" "9"))))

; Time digits: HH:MM:SS
(assert (= hour_str (str.substr time_part 0 2)))
(assert (= min_str (str.substr time_part 3 2)))
(assert (= sec_str (str.substr time_part 6 2)))
(assert (str.in_re hour_str (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re min_str (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec_str (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction and allowed set
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Component must be non-empty and contain only letters, digits, underscore, hyphen
(assert (not (= component_field "")))
(assert (str.in_re component_field (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message must be non-empty
(assert (not (= msg_field "")))

; Additional parsing: component_field may be like "svc/module"; split at "/" to get component_name
(assert (= component_name (str.split_at component_field "/" 0)))
(assert (>= (str.num_splits component_field "/") 1))

; Ensure overall logline contains the level token somewhere after first space
(assert (str.contains (str.split_rest logline " " 1) level))

; Make it satisfiable by providing one concrete example logline
(assert (= logline "2026-01-09T12:34:56 INFO auth_service: user login ok"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
