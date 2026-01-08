(set-logic ALL)
(define-const delta String "\u{2FFFF}")

(define-fun convert_for_split ((s String) (sep String)) String
  (str.replace_all s sep delta))

(define-fun-rec count_matches_rec ((s String) (from Int)) Int
  (let ((pos (str.indexof s delta from)))
    (ite (= pos (- 0 1))
         0
         (+ 1 (count_matches_rec s (+ pos (str.len delta)))))))

(define-fun count_matches ((s String)) Int
  (count_matches_rec s 0))

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

; Uninterpreted interface operations for string splitting

; Core log strings (two different entries)
(declare-const log_line_sat String)
(declare-const log_line_unsat String)

; Common delimiter constants
(declare-const d_space String)
(declare-const d_colon String)

; Parsed fields for SAT instance
(declare-const sat_date String)
(declare-const sat_time String)
(declare-const sat_level String)
(declare-const sat_msg String)
(declare-const sat_time_h String)
(declare-const sat_time_m String)
(declare-const sat_time_s String)

; Parsed fields for UNSAT instance
(declare-const unsat_date String)
(declare-const unsat_time String)
(declare-const unsat_level String)
(declare-const unsat_msg String)
(declare-const unsat_time_h String)
(declare-const unsat_time_m String)
(declare-const unsat_time_s String)

; Basic delimiter setup
(assert (= d_space " "))
(assert (= d_colon ":"))

; -------------------------
; SAT instance: structured server log
; Format: YYYY-MM-DD HH:MM:SS LEVEL: message...
; Example: 2026-01-07 12:34:56 INFO: Started server
; -------------------------

; Ensure at least 4 space-separated segments: date, time, level:, rest-of-message
(assert (>= (num_splits log_line_sat d_space) 4))

(assert (= sat_date (split_at log_line_sat d_space 0)))
(assert (= sat_time (split_at log_line_sat d_space 1)))
(assert (= sat_level (split_at log_line_sat d_space 2)))
(assert (= sat_msg (split_rest log_line_sat d_space 3)))

; Timestamp date format YYYY-MM-DD using regex
(assert (str.in_re sat_date (re.++ (re.loop (str.to_re "0") 1 1) (re.loop (str.to_re "0") 0 0))))
; The above is intentionally weak; enforce exact shape with explicit digit ranges
(assert (str.in_re sat_date
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 4 4)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Time format HH:MM:SS by splitting on ':'
(assert (>= (num_splits sat_time d_colon) 3))
(assert (= sat_time_h (split_at sat_time d_colon 0)))
(assert (= sat_time_m (split_at sat_time d_colon 1)))
(assert (= sat_time_s (split_at sat_time d_colon 2)))

; Enforce exactly two digits per component
(assert (= (str.len sat_time_h) 2))
(assert (= (str.len sat_time_m) 2))
(assert (= (str.len sat_time_s) 2))

; Digits only for HH, MM, SS
(assert (str.in_re sat_time_h (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)))
(assert (str.in_re sat_time_m (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)))
(assert (str.in_re sat_time_s (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)))

; Log level extraction: third token should end with ':' and contain a known level prefix
(assert (str.contains sat_level ":"))
(assert (= (str.at sat_level (- (str.len sat_level) 1)) ":"))
(assert (or (= (str.substr sat_level 0 4) "INFO")
            (= (str.substr sat_level 0 5) "ERROR")
            (= (str.substr sat_level 0 4) "WARN")
            (= (str.substr sat_level 0 5) "DEBUG")))

; Message should be non-empty and not contain a newline
(assert (> (str.len sat_msg) 0))
(assert (not (str.contains sat_msg "\n")))

; Provide a concrete satisfying log line shape (keeps the instance SAT)
(assert (= log_line_sat "2026-01-07 12:34:56 INFO: Started server"))

; -------------------------
; UNSAT instance: contradictory constraints on parsed fields
; Same intended format, but impose an impossible log level and time component length
; -------------------------

(assert (>= (num_splits log_line_unsat d_space) 4))

(assert (= unsat_date (split_at log_line_unsat d_space 0)))
(assert (= unsat_time (split_at log_line_unsat d_space 1)))
(assert (= unsat_level (split_at log_line_unsat d_space 2)))
(assert (= unsat_msg (split_rest log_line_unsat d_space 3)))

; Date must be in correct YYYY-MM-DD shape
(assert (str.in_re unsat_date
  (re.++
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 4 4)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2)
    (str.to_re "-")
    (re.loop (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")) 2 2))))

; Time split
(assert (>= (num_splits unsat_time d_colon) 3))
(assert (= unsat_time_h (split_at unsat_time d_colon 0)))
(assert (= unsat_time_m (split_at unsat_time d_colon 1)))
(assert (= unsat_time_s (split_at unsat_time d_colon 2)))

; Contradiction: HH must be exactly 2 chars, but also exactly 3 chars
(assert (= (str.len unsat_time_h) 2))
(assert (= (str.len unsat_time_h) 3))

; Contradiction on log level: must start with INFO but also start with ERROR
(assert (= (str.at unsat_level (- (str.len unsat_level) 1)) ":"))
(assert (= (str.substr unsat_level 0 4) "INFO"))
(assert (= (str.substr unsat_level 0 5) "ERROR"))

; Provide a concrete-looking line (still UNSAT due to above contradictions)
(assert (= log_line_unsat "2026-01-07 12:34:56 INFO: Something happened"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
