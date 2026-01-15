(set-logic ALL)

; Uninterpreted split interface

; Seed-preserved core
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_103698 String)
(assert (= T_1 (= "rAdAdKXaYb" var_0xINPUT_103698)))
(assert T_1)

; Log Analysis scenario: parsing structured server log entries
(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const yyyy String)
(declare-const mon String)
(declare-const dd String)
(declare-const payload String)

; Space-separated layout: "<timestamp> <level>:<message>"
(assert (= ts (str.split_at log_line " " 0)))
(assert (= payload (str.split_at log_line " " 1)))
(assert (= message (str.split_rest log_line " " 2)))
(assert (>= (str.num_splits log_line " ") 2))

; Level/message split on colon within payload
(assert (= level (str.split_at payload ":" 0)))
(assert (= message (str.split_rest payload ":" 1)))
(assert (>= (str.num_splits payload ":") 2))

; Timestamp split: "YYYY-MM-DDTHH:MM:SS"
(assert (= ts_date (str.split_at ts "T" 0)))
(assert (= ts_time (str.split_at ts "T" 1)))
(assert (= "" (str.split_rest ts "T" 2)))
(assert (= (str.num_splits ts "T") 2))

; Date split: "YYYY-MM-DD"
(assert (= yyyy (str.split_at ts_date "-" 0)))
(assert (= mon (str.split_at ts_date "-" 1)))
(assert (= dd (str.split_at ts_date "-" 2)))
(assert (= "" (str.split_rest ts_date "-" 3)))
(assert (= (str.num_splits ts_date "-") 3))

; Time split: "HH:MM:SS"
(assert (= hh (str.split_at ts_time ":" 0)))
(assert (= mm (str.split_at ts_time ":" 1)))
(assert (= ss (str.split_at ts_time ":" 2)))
(assert (= "" (str.split_rest ts_time ":" 3)))
(assert (= (str.num_splits ts_time ":") 3))

; Timestamp format validation via regexes
(assert (str.in_re yyyy (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction constraints
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message sanity checks
(assert (>= (str.len message) 1))
(assert (str.contains message "request"))

; Tie the scenario to the seed input by embedding it in the log line
(assert (str.contains log_line var_0xINPUT_103698))

; Concrete shape example to make the instance satisfiable
(assert (= log_line (str.++ ts (str.++ " " (str.++ level (str.++ ":" (str.++ message "")))))))
(assert (= ts "2025-01-09T12:34:56"))
(assert (= level "INFO"))
(assert (= message (str.++ "request id=" var_0xINPUT_103698)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
