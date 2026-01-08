(set-logic ALL)
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

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; We preserve the core skeleton (same variables and key equalities) and extend with str_split-based parsing.

; Seed declarations (kept)
(declare-fun I0_11 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_11 () String)
(declare-fun T1_10 () String)
(declare-fun T1_11 () String)
(declare-fun T1_16 () String)
(declare-fun T1_4 () String)
(declare-fun T1_7 () String)
(declare-fun T2_10 () String)
(declare-fun T2_11 () String)
(declare-fun T2_16 () String)
(declare-fun T2_4 () String)
(declare-fun T2_7 () String)
(declare-fun T3_11 () String)
(declare-fun T4_11 () String)
(declare-fun T5_11 () String)
(declare-fun T_1 () String)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () String)
(declare-fun T_5 () Bool)
(declare-fun T_6 () String)
(declare-fun T_8 () Bool)
(declare-fun T_9 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_a () String)
(declare-fun T_b () Bool)
(declare-fun var_0xINPUT_100651 () String)

; str_split interface (uninterpreted, as required)

; Additional variables for log parsing
(declare-const log_line String)
(declare-const ts_token String)
(declare-const level_token String)
(declare-const message_rest String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hour_str String)
(declare-const min_str String)
(declare-const sec_str String)
(declare-const year_str String)
(declare-const month_str String)
(declare-const day_str String)
(declare-const tag_token String)
(declare-const msg_after_colon String)
(declare-const is_level_ok Bool)
(declare-const is_ts_shape_ok Bool)
(declare-const is_time_shape_ok Bool)
(declare-const is_date_shape_ok Bool)

; --- Preserve core seed structure (mutated slightly for log setting but keeping same constraints) ---
(assert (= T_1 (str.++ T1_4 T2_4)))
(assert (= T2_4 var_0xINPUT_100651))
(assert (= T1_4 ""))
(assert (= T_2 (= "-" T_1)))
(assert (= T_3 (not T_2)))
(assert T_3)

(assert (= T_4 (str.++ T1_7 T2_7)))
(assert (= T2_7 var_0xINPUT_100651))
(assert (= T1_7 ""))
(assert (= T_5 (= "" T_4)))
(assert T_5)

(assert (= T_6 (str.++ T1_10 T2_10)))
(assert (= T2_10 var_0xINPUT_100651))
(assert (= T1_10 ""))

; Keep selection structure but repurpose the regex check to avoid embedding a forbidden token in the input.
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_11 0))
    (= T_6 (str.++ T0_11 T1_11))
    (= I0_11 (str.len T4_11))
    (= 0 (str.len T0_11))
    (= T1_11 (str.++ T2_11 T3_11))
    (= T2_11 (str.++ T4_11 T5_11))
    (= T5_11 "token=")
    ; do not allow the prefix to be exactly "token="
    (not (str.in_re T4_11 (re.++ (str.to_re "t") (str.to_re "o") (str.to_re "k") (str.to_re "e") (str.to_re "n") (str.to_re "="))))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= T_6 (str.++ T0_11 T1_11))
    (= 0 (str.len T0_11))
    (not (str.in_re T1_11 (re.++ (str.to_re "t") (str.to_re "o") (str.to_re "k") (str.to_re "e") (str.to_re "n") (str.to_re "="))))
  )
))

(assert (= T_8 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_9 (not T_8)))
(assert T_9)

(assert (= T_a (str.++ T1_16 T2_16)))
(assert (= T2_16 var_0xINPUT_100651))
(assert (= T1_16 ""))
(assert (= T_b (= "-" T_a)))
(assert T_b)

; --- Log-specific extensions ---

; Tie input to a concrete log line to enforce a realistic parse target.
; Core constraints already force var_0xINPUT_100651 = "" from T_5, and also var_0xINPUT_100651 = "-" from T_b,
; making the overall instance UNSAT. We keep that to create an UNSAT instance as requested.
(assert (= var_0xINPUT_100651 log_line))

; Split by spaces: [timestamp] [level] [tag:message...]
(assert (>= (num_splits log_line " ") 3))
(assert (= ts_token (split_at log_line " " 0)))
(assert (= level_token (split_at log_line " " 1)))
(assert (= message_rest (split_rest log_line " " 2)))

; Validate level extraction: allow common levels
(assert (= is_level_ok (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG"))))
(assert is_level_ok)

; Timestamp shape validation: "YYYY-MM-DDTHH:MM:SS"
(assert (= date_part (split_at ts_token "T" 0)))
(assert (= time_part (split_at ts_token "T" 1)))
(assert (>= (num_splits ts_token "T") 2))

(assert (= year_str (split_at date_part "-" 0)))
(assert (= month_str (split_at date_part "-" 1)))
(assert (= day_str (split_at date_part "-" 2)))
(assert (>= (num_splits date_part "-") 3))

(assert (= hour_str (split_at time_part ":" 0)))
(assert (= min_str (split_at time_part ":" 1)))
(assert (= sec_str (split_at time_part ":" 2)))
(assert (>= (num_splits time_part ":") 3))

(assert (= is_date_shape_ok (and (= (str.len year_str) 4) (= (str.len month_str) 2) (= (str.len day_str) 2))))
(assert (= is_time_shape_ok (and (= (str.len hour_str) 2) (= (str.len min_str) 2) (= (str.len sec_str) 2))))
(assert (= is_ts_shape_ok (and is_date_shape_ok is_time_shape_ok)))
(assert is_ts_shape_ok)

; Parse tag/message separated by colon (e.g., "auth: login failed")
(assert (>= (num_splits message_rest ":") 2))
(assert (= tag_token (split_at message_rest ":" 0)))
(assert (= msg_after_colon (split_rest message_rest ":" 1)))
(assert (not (= tag_token "")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
