(set-logic ALL)

; Uninterpreted interface: str_split
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

; Scenario: Log Analysis
; Format (intended): "YYYY-MM-DD HH:MM:SS LEVEL: message"

; Shared inputs
(declare-const log_entry String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_and_msg String)
(declare-const level_part String)
(declare-const msg_part String)

; Additional extracted fields
(declare-const year_s String)
(declare-const month_s String)
(declare-const day_s String)
(declare-const hour_s String)
(declare-const min_s String)
(declare-const sec_s String)

; Integer interpretations for range checks
(declare-const year Int)
(declare-const month Int)
(declare-const day Int)
(declare-const hour Int)
(declare-const minute Int)
(declare-const second Int)

; A second independent log entry to create an UNSAT instance
(declare-const bad_log_entry String)
(declare-const bad_level_part String)

; Basic split by spaces: [date] [time] [LEVEL:] [rest...]
(assert (>= (num_splits log_entry " ") 3))
(assert (= date_part (split_at log_entry " " 0)))
(assert (= time_part (split_at log_entry " " 1)))
(assert (= level_and_msg (split_rest log_entry " " 2)))

; Split level_and_msg by single space into "LEVEL:" and message prefix (message may contain spaces)
(assert (>= (num_splits level_and_msg " ") 1))
(assert (= level_part (split_at level_and_msg " " 0)))
(assert (= msg_part (split_rest level_and_msg " " 1)))

; Extract level token before ':' (LEVEL:)
(assert (>= (num_splits level_part ":") 1))
(assert (= (split_at level_part ":" 0) (split_at level_part ":" 0)))

; Constrain exact level format: must end with ':' and be one of INFO/WARN/ERROR/DEBUG
(assert (str.suffixof ":" level_part))
(assert (or (= (split_at level_part ":" 0) "INFO")
            (= (split_at level_part ":" 0) "WARN")
            (= (split_at level_part ":" 0) "ERROR")
            (= (split_at level_part ":" 0) "DEBUG")))

; Message should be non-empty and should not start with a space (since split_rest from 1)
(assert (>= (str.len msg_part) 1))
(assert (not (= (str.at msg_part 0) " ")))

; Timestamp structure checks using regex
; Date: YYYY-MM-DD
(assert (str.in_re date_part (re.++ (re.loop (str.to_re "0") 0 0) (str.to_re "") )))
; The above is a no-op placeholder avoidance is not needed, so provide the real constraint below
(assert (str.in_re date_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 4 4)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Time: HH:MM:SS
(assert (str.in_re time_part
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re ":")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Further split date and time by '-' and ':' and interpret as integers
(assert (>= (num_splits date_part "-") 3))
(assert (= year_s (split_at date_part "-" 0)))
(assert (= month_s (split_at date_part "-" 1)))
(assert (= day_s (split_at date_part "-" 2)))

(assert (>= (num_splits time_part ":") 3))
(assert (= hour_s (split_at time_part ":" 0)))
(assert (= min_s (split_at time_part ":" 1)))
(assert (= sec_s (split_at time_part ":" 2)))

(assert (= year (str.to_int year_s)))
(assert (= month (str.to_int month_s)))
(assert (= day (str.to_int day_s)))
(assert (= hour (str.to_int hour_s)))
(assert (= minute (str.to_int min_s)))
(assert (= second (str.to_int sec_s)))

; Numeric range checks (simple validation)
(assert (and (>= year 1970) (<= year 2099)))
(assert (and (>= month 1) (<= month 12)))
(assert (and (>= day 1) (<= day 31)))
(assert (and (>= hour 0) (<= hour 23)))
(assert (and (>= minute 0) (<= minute 59)))
(assert (and (>= second 0) (<= second 59)))

; Cross-check that delimiter usage is plausible
(assert (>= (num_splits log_entry " ") 3))
(assert (= (str.len (split_at log_entry " " 0)) 10))
(assert (= (str.len (split_at log_entry " " 1)) 8))

; Ensure level_part has exactly one ':' at the end: i.e., splitting by ':' yields 2 segments and second is empty
(assert (= (num_splits level_part ":") 2))
(assert (= (split_at level_part ":" 1) ""))

; --- SAT instance anchoring: provide a concrete satisfiable example for log_entry ---
(assert (= log_entry "2024-01-09 13:45:07 INFO: service started"))

; --- UNSAT instance: an incompatible constraint set for bad_log_entry ---
; Intended: it claims to have level ERROR but also forces it to be INFO.
(assert (= bad_log_entry "2024-01-09 13:45:07 ERROR: something failed"))
(assert (>= (num_splits bad_log_entry " ") 3))
(assert (= bad_level_part (split_at (split_rest bad_log_entry " " 2) " " 0)))
(assert (str.suffixof ":" bad_level_part))
(assert (= (split_at bad_level_part ":" 0) "ERROR"))
(assert (= (split_at bad_level_part ":" 0) "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
