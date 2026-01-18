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

; Uninterpreted interface for string split (as provided)

; --------- SAT instance: plausible log parsing/validation ---------
(declare-const log_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const hour_sat String)
(declare-const min_sat String)
(declare-const sec_sat String)

; Split on spaces: "<timestamp> <level>: <message>"
(assert (>= (num_splits log_sat " ") 3))
(assert (= ts_sat (split_at log_sat " " 0)))
(assert (= lvl_sat (split_at log_sat " " 1)))
(assert (= msg_sat (split_rest log_sat " " 2)))

; Level token ends with ':' and is one of common levels
(assert (str.in_re lvl_sat (re.union (str.to_re "INFO:")
                                     (str.to_re "WARN:")
                                     (str.to_re "ERROR:")
                                     (str.to_re "DEBUG:"))))

; Timestamp token: "YYYY-MM-DD:HH:MM:SS" validated via both splitting and regex
(assert (>= (num_splits ts_sat ":") 4))
(assert (= date_sat (split_at ts_sat ":" 0)))
(assert (= time_sat (str.++ (split_at ts_sat ":" 1)
                            ":" (split_at ts_sat ":" 2)
                            ":" (split_at ts_sat ":" 3))))

(assert (>= (num_splits time_sat ":") 3))
(assert (= hour_sat (split_at time_sat ":" 0)))
(assert (= min_sat (split_at time_sat ":" 1)))
(assert (= sec_sat (split_at time_sat ":" 2)))

; Ensure fixed widths
(assert (= (str.len hour_sat) 2))
(assert (= (str.len min_sat) 2))
(assert (= (str.len sec_sat) 2))
(assert (= (str.len date_sat) 10))

; Regex for timestamp: 4 digits '-' 2 digits '-' 2 digits ':' 2 ':' 2 ':' 2 digits
(define-fun Digit () RegLan (re.range "0" "9"))
(define-fun TwoDigits () RegLan (re.++ Digit Digit))
(define-fun FourDigits () RegLan (re.++ Digit Digit Digit Digit))
(define-fun DateRE () RegLan (re.++ FourDigits (str.to_re "-") TwoDigits (str.to_re "-") TwoDigits))
(define-fun TimeRE () RegLan (re.++ TwoDigits (str.to_re ":") TwoDigits (str.to_re ":") TwoDigits))
(define-fun TsRE () RegLan (re.++ DateRE (str.to_re ":") TimeRE))
(assert (str.in_re ts_sat TsRE))

; Message constraints: non-empty and contains at least one alphabetic character
(define-fun Alpha () RegLan (re.union (re.range "a" "z") (re.range "A" "Z")))
(assert (>= (str.len msg_sat) 1))
(assert (str.in_re msg_sat (re.++ (re.* re.allchar) Alpha (re.* re.allchar))))

; Provide a concrete satisfying witness (still consistent with above constraints)
(assert (= log_sat "2025-01-09:13:07:59 INFO: Started worker"))

; --------- UNSAT instance: contradictory requirements on extracted log level ---------
(declare-const log_unsat String)
(declare-const lvl_unsat String)
(declare-const ts_unsat String)

(assert (>= (num_splits log_unsat " ") 2))
(assert (= ts_unsat (split_at log_unsat " " 0)))
(assert (= lvl_unsat (split_at log_unsat " " 1)))

; Force a concrete log where the second token is "INFO:" ...
(assert (= log_unsat "2025-01-09:13:07:59 INFO: Something happened"))

; ...but also require it to be "ERROR:" (contradiction)
(assert (= lvl_unsat "ERROR:"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
