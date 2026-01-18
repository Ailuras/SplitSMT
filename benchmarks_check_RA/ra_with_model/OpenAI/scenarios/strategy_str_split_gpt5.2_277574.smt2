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

; Uninterpreted interface operations for str_split

; -------------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Example intended structure:
;   YYYY-MM-DD HH:MM:SS LEVEL: component: message
; -------------------------------

; ===== SAT instance =====
(declare-const log_line_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const ts_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const msg_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const year_sat String)
(declare-const month_sat String)
(declare-const day_sat String)
(declare-const lvl_prefix_sat String)

; Split by spaces: [date] [time] [LEVEL:] [rest...]
(assert (= ts_date_sat (split_at log_line_sat " " 0)))
(assert (= ts_time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= lvl_prefix_sat (split_rest log_line_sat " " 2)))
(assert (>= (num_splits log_line_sat " ") 4))

; Timestamp components: date and time formats
(assert (= ts_sat (str.++ ts_date_sat " " ts_time_sat)))
(assert (str.in_re ts_date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ts_time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

; Further validate ranges using numeric conversion of fixed-width fields
(assert (= year_sat (str.substr ts_date_sat 0 4)))
(assert (= month_sat (str.substr ts_date_sat 5 2)))
(assert (= day_sat (str.substr ts_date_sat 8 2)))
(assert (= hour_sat (str.substr ts_time_sat 0 2)))
(assert (= minute_sat (str.substr ts_time_sat 3 2)))
(assert (= second_sat (str.substr ts_time_sat 6 2)))

; Enforce numeric ranges
(assert (and (>= (str.to_int month_sat) 1) (<= (str.to_int month_sat) 12)))
(assert (and (>= (str.to_int day_sat) 1) (<= (str.to_int day_sat) 31)))
(assert (and (>= (str.to_int hour_sat) 0) (<= (str.to_int hour_sat) 23)))
(assert (and (>= (str.to_int minute_sat) 0) (<= (str.to_int minute_sat) 59)))
(assert (and (>= (str.to_int second_sat) 0) (<= (str.to_int second_sat) 59)))

; Extract level from "LEVEL:" by splitting at ':'
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (>= (num_splits level_colon_sat ":") 2))

; Allow typical log levels
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Extract component and message from remainder after the level token
; After splitting by spaces: token 3 is expected to be "component:" and rest is message
(assert (= component_sat (split_at log_line_sat " " 3)))
(assert (= msg_sat (split_rest log_line_sat " " 4)))
(assert (>= (str.len msg_sat) 1))

; component token should contain ':' and component name should be non-empty
(assert (str.contains component_sat ":"))
(assert (>= (str.len (split_at component_sat ":" 0)) 1))

; Constrain to a plausible concrete example while still using parsing constraints
(assert (= log_line_sat "2025-01-07 13:45:59 INFO: auth: login ok"))


; ===== UNSAT instance =====
; Same structure, but conflicting constraints: timestamp claims hour=25 (invalid) and also fixed string.
(declare-const log_line_unsat String)
(declare-const ts_date_unsat String)
(declare-const ts_time_unsat String)
(declare-const hour_unsat String)
(declare-const minute_unsat String)
(declare-const second_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (= ts_date_unsat (split_at log_line_unsat " " 0)))
(assert (= ts_time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 4))

(assert (str.in_re ts_date_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9") (str.to_re "-") (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ts_time_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9") (str.to_re ":") (re.range "0" "9") (re.range "0" "9"))))

(assert (= hour_unsat (str.substr ts_time_unsat 0 2)))
(assert (= minute_unsat (str.substr ts_time_unsat 3 2)))
(assert (= second_unsat (str.substr ts_time_unsat 6 2)))

; Range constraints (hour must be within 0..23)
(assert (and (>= (str.to_int hour_unsat) 0) (<= (str.to_int hour_unsat) 23)))
(assert (and (>= (str.to_int minute_unsat) 0) (<= (str.to_int minute_unsat) 59)))
(assert (and (>= (str.to_int second_unsat) 0) (<= (str.to_int second_unsat) 59)))

; Extract level and require it to be one of allowed
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

; Fix log line to an invalid hour 25 -> should contradict hour range
(assert (= log_line_unsat "2025-01-07 25:00:00 ERROR: db: connection failed"))



; [GENERATION STATUS: SUCCESS]
(assert (= level_unsat "INFO"))
(assert (= second_unsat "20"))
(assert (= hour_sat "20"))
(assert (= ts_time_unsat "20:00:20"))
(assert (= msg_sat "C"))
(assert (= ts_time_sat "20:20:00"))
(assert (= hour_unsat "20"))
(assert (= ts_date_unsat "0000-00-00"))
(assert (= month_sat "10"))
(assert (= ts_sat "0000-10-10 20:20:00"))
(assert (= component_sat ":"))
(assert (= minute_sat "20"))
(assert (= lvl_prefix_sat "C"))
(assert (= year_sat "0000"))
(assert (= level_colon_sat "5"))
(assert (= minute_unsat "00"))
(assert (= day_sat "10"))
(assert (= level_sat "WARN"))
(assert (= ts_date_sat "0000-10-10"))
(assert (= second_sat "00"))
(assert (= level_colon_unsat "-"))
(assert (= log_line_sat "2025-01-07 13:45:59 INFO: auth: login ok"))
(assert (= log_line_unsat "2025-01-07 25:00:00 ERROR: db: connection failed"))
(check-sat)
(exit)
