(set-logic ALL)

; Uninterpreted interface for string split
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun count_matches ((s String)) Int
  (ite (= (str.len s) 0) 0
    (let ((len_s (str.len s))
          (len_removed (str.len (str.replace_all s delta ""))))
      (- len_s len_removed))))

(define-fun-rec nth_match_start ((s String) (n Int) (from Int)) Int
  (ite (<= n 0) (- 1)
    (let ((p (str.indexof s delta from)))
      (ite (= n 1) p
        (nth_match_start s (- n 1) (+ p (str.len delta)))))))

(define-fun split_at ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun-rec replace_iter ((s String) (sep String) (i Int)) String
  (ite (<= i 0) s
    (replace_iter (str.replace s sep delta) sep (- i 1))))

(define-fun split_rest ((s String) (sep String) (k Int)) String
  (ite (or (< k 0) (= (str.len sep) 0)) ""
    (let ((tmp (convert_for_split s sep)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter s sep k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits ((s String) (sep String)) Int
  (let ((tmp (convert_for_split s sep)))
    (+ 1 (count_matches tmp))))

(define-fun convert_for_split_re ((s String) (r (RegEx String))) String
  (str.replace_re_all s r delta))

(define-fun-rec replace_iter_re ((s String) (r (RegEx String)) (i Int)) String
  (ite (<= i 0) s
    (replace_iter_re (str.replace_re s r delta) r (- i 1))))

(define-fun split_at_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (+ 1 (count_matches tmp))))
        (ite (>= k num) ""
          (let ((start_match_k (nth_match_start tmp k 0)))
            (let ((start_k (ite (= k 0) (- 1) start_match_k)))
              (let ((start_match_next (nth_match_start tmp (+ k 1) 0)))
                (let ((end_k (ite (= start_match_next (- 1))
                                  (str.len tmp)
                                  start_match_next)))
                  (ite (< end_k start_k)
                    (str.substr tmp (+ start_k 1) (- (str.len tmp) start_k 1))
                    (str.substr tmp (+ start_k 1) (- end_k start_k 1))))))))))))

(define-fun split_rest_re ((s String) (r (RegEx String)) (k Int)) String
  (ite (< k 0) ""
    (let ((tmp (convert_for_split_re s r)))
      (let ((num (count_matches tmp)))
        (ite (< num k) ""
          (let ((s_iter (replace_iter_re s r k)))
            (let ((start_match_k (nth_match_start s_iter k 0)))
              (let ((lens (str.len s_iter)))
                (ite (< start_match_k 0) s
                  (str.substr s_iter (+ start_match_k 1)
                              (- lens start_match_k 1)))))))))))

(define-fun num_splits_re ((s String) (r (RegEx String))) Int
  (let ((tmp (convert_for_split_re s r)))
    (+ 1 (count_matches tmp))))

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
