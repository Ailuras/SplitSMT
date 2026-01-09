(set-logic ALL)

; Uninterpreted interface operations for str_split

; Seed structure preserved and extended for log analysis
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_193661 String)

; Additional boolean guards
(declare-fun T_ts_ok () Bool)
(declare-fun T_level_ok () Bool)
(declare-fun T_structure_ok () Bool)

; Log-field variables
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Maintain original core: input is not empty
(assert (= T_1 (= var_0xINPUT_193661 "")))
(assert (= T_2 (not T_1)))
(assert T_2)

; Basic structure: "<ts> <level> <msg...>" (split by single space)
(assert (= ts (str.split_at var_0xINPUT_193661 " " 0)))
(assert (= level (str.split_at var_0xINPUT_193661 " " 1)))
(assert (= msg (str.split_rest var_0xINPUT_193661 " " 2)))
(assert (>= (str.num_splits var_0xINPUT_193661 " ") 3))

; Timestamp sub-structure: "YYYY-MM-DDTHH:MM:SS" (split at 'T')
(assert (= date (str.split_at ts "T" 0)))
(assert (= time (str.split_at ts "T" 1)))
(assert (>= (str.num_splits ts "T") 2))

; Time sub-structure: "HH:MM:SS" (split at ':')
(assert (= hour (str.split_at time ":" 0)))
(assert (= minute (str.split_at time ":" 1)))
(assert (= second (str.split_at time ":" 2)))
(assert (= (str.num_splits time ":") 3))

; Timestamp format validation via regex: YYYY-MM-DDTHH:MM:SS
(assert (= T_ts_ok (str.in_re ts (re.++ (re.loop (re.range "0" "9") 4 4)
                                         (str.to_re "-")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re "-")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re "T")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re ":")
                                         (re.loop (re.range "0" "9") 2 2)
                                         (str.to_re ":")
                                         (re.loop (re.range "0" "9") 2 2)))))

; Log level extraction/validation
(assert (= T_level_ok (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))))

; Message must be non-empty and not contain newline
(assert (>= (str.len msg) 1))
(assert (not (str.contains msg "\n")))

; Combined structural check boolean
(assert (= T_structure_ok (and T_ts_ok T_level_ok)))
(assert T_structure_ok)

; Additional consistency checks on subfields lengths
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; UNSAT trigger: contradict the validated timestamp by forcing it to contain a space
; This preserves the scenario but makes the instance UNSAT deliberately.
(assert (str.contains ts " "))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
