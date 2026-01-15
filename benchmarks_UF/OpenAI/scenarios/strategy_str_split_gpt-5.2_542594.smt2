(set-logic ALL)

; Uninterpreted interface for string split
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; -------- Instance A (intended SAT): well-formed log line --------
(declare-const log_line_a String)
(declare-const token0_a String)
(declare-const token1_a String)
(declare-const token2_a String)
(declare-const rest_a String)
(declare-const ts_date_a String)
(declare-const ts_time_a String)
(declare-const year_a String)
(declare-const mon_a String)
(declare-const day_a String)
(declare-const hour_a String)
(declare-const min_a String)
(declare-const sec_a String)
(declare-const level_a String)
(declare-const msg_a String)
(declare-const posT_a Int)

(assert (= token0_a (split_at log_line_a " " 0)))
(assert (= token1_a (split_at log_line_a " " 1)))
(assert (= token2_a (split_at log_line_a " " 2)))
(assert (= rest_a   (split_rest log_line_a " " 3)))
(assert (>= (num_splits log_line_a " ") 4))

; Timestamp is first token: YYYY-MM-DDTHH:MM:SS (no timezone)
(assert (= posT_a (str.indexof token0_a "T" 0)))
(assert (= posT_a 10))
(assert (= ts_date_a (str.substr token0_a 0 10)))
(assert (= ts_time_a (str.substr token0_a 11 8)))

(assert (= year_a (split_at ts_date_a "-" 0)))
(assert (= mon_a  (split_at ts_date_a "-" 1)))
(assert (= day_a  (split_at ts_date_a "-" 2)))
(assert (= (num_splits ts_date_a "-") 3))
(assert (= (str.len year_a) 4))
(assert (= (str.len mon_a) 2))
(assert (= (str.len day_a) 2))

(assert (= hour_a (split_at ts_time_a ":" 0)))
(assert (= min_a  (split_at ts_time_a ":" 1)))
(assert (= sec_a  (split_at ts_time_a ":" 2)))
(assert (= (num_splits ts_time_a ":") 3))
(assert (= (str.len hour_a) 2))
(assert (= (str.len min_a) 2))
(assert (= (str.len sec_a) 2))

; Regex validation for digits and fixed timestamp shape
(assert (str.in_re year_a (re.+ (re.range "0" "9"))))
(assert (str.in_re mon_a  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day_a  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour_a (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re min_a  (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re sec_a  (re.++ (re.range "0" "9") (re.range "0" "9"))))

(assert (str.in_re token0_a
  (re.++
    (re.++
      (re.++
        (re.++
          (re.++
            (re.++
              (re.++
                (re.++
                  (re.++
                    (re.++
                      (re.++
                        (re.++
                          (re.++
                            (re.++
                              (re.++
                                (re.++
                                  (re.++
                                    (re.range "0" "9") (re.range "0" "9"))
                                  (re.range "0" "9"))
                                (re.range "0" "9"))
                              (str.to_re "-"))
                            (re.range "0" "9"))
                          (re.range "0" "9"))
                        (str.to_re "-"))
                      (re.range "0" "9"))
                    (re.range "0" "9"))
                  (str.to_re "T"))
                (re.range "0" "9"))
              (re.range "0" "9"))
            (str.to_re ":"))
          (re.range "0" "9"))
        (re.range "0" "9"))
      (str.to_re ":"))
    (re.range "0" "9"))))

; Second token should be LEVEL: (extract before ':'), third token is module, rest is message
(assert (= level_a (split_at token1_a ":" 0)))
(assert (>= (num_splits token1_a ":") 2))
(assert (or (= level_a "INFO") (= level_a "WARN") (= level_a "ERROR") (= level_a "DEBUG")))
(assert (not (str.contains token1_a "::")))

(assert (= msg_a rest_a))
(assert (>= (str.len msg_a) 1))
(assert (not (str.contains msg_a "\n")))

; Concrete satisfiable example
(assert (= log_line_a "2025-01-09T13:45:27 INFO: auth login_success user=alice"))


; -------- Instance B (intended UNSAT): contradictory timestamp/level constraints --------
(declare-const log_line_b String)
(declare-const token0_b String)
(declare-const token1_b String)
(declare-const ts_time_b String)
(declare-const hour_b String)
(declare-const min_b String)
(declare-const sec_b String)
(declare-const level_b String)
(declare-const posT_b Int)

(assert (= token0_b (split_at log_line_b " " 0)))
(assert (= token1_b (split_at log_line_b " " 1)))
(assert (>= (num_splits log_line_b " ") 3))

(assert (= posT_b (str.indexof token0_b "T" 0)))
(assert (= posT_b 10))
(assert (= ts_time_b (str.substr token0_b 11 8)))

(assert (= hour_b (split_at ts_time_b ":" 0)))
(assert (= min_b  (split_at ts_time_b ":" 1)))
(assert (= sec_b  (split_at ts_time_b ":" 2)))
(assert (= (num_splits ts_time_b ":") 3))

; Require minutes to be exactly "45"
(assert (= min_b "45"))

; But also fix the whole log line with minutes "44" -> contradiction
(assert (= log_line_b "2025-01-09T13:44:27 ERROR: core panic"))

; Level extraction and contradiction: token1_b is "ERROR:" here, but force level to INFO
(assert (= level_b (split_at token1_b ":" 0)))
(assert (= level_b "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
