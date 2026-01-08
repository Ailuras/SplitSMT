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

; Uninterpreted interface operations for split constraints

; Scenario: Log Analysis
; We model log lines like: "2026-01-07T12:34:56Z INFO: user=jdoe action=login"

; ---------- SAT instance ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const ts_date_sat String)
(declare-const ts_time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const msg_sat String)

; Split by spaces: [0]=timestamp, [1]=level:, [2..]=message
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_colon_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))
(assert (>= (num_splits log_line_sat " ") 3))

; Timestamp ISO-8601-ish validation: YYYY-MM-DDTHH:MM:SSZ
; Use regex for structure.
(assert (str.in_re ts_sat (str.to_re ""))) ; allow solver freedom with empty re base
(assert (str.in_re ts_sat
  (re.++
    (re.loop (re.range "0" "9") 4 4)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "T")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "Z"))))

; Further parse timestamp by 'T' to get date and timeZ
(assert (= ts_date_sat (split_at ts_sat "T" 0)))
(assert (= ts_time_sat (split_at ts_sat "T" 1)))
(assert (= (num_splits ts_sat "T") 2))

; Time part must end with Z and have length 9 (HH:MM:SSZ)
(assert (= (str.len ts_time_sat) 9))
(assert (= (str.at ts_time_sat 8) "Z"))
(assert (= (str.at ts_time_sat 2) ":"))
(assert (= (str.at ts_time_sat 5) ":"))

; Extract log level from "LEVEL:" token by splitting on ':'
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (= (split_at level_colon_sat ":" 1) ""))
(assert (= (num_splits level_colon_sat ":") 2))

; Log level must be one of common set
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Message checks: must include key=value and at least one space-separated token
(assert (str.contains msg_sat "="))
(assert (>= (num_splits msg_sat " ") 1))

; Constrain to a plausible concrete-ish example while leaving degrees of freedom
(assert (str.contains msg_sat "user="))
(assert (str.contains msg_sat "action="))

; ---------- UNSAT instance (in same file) ----------
; Here we force a malformed timestamp but also require it matches the strict regex.
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 2))

; Force an impossible timestamp shape while simultaneously requiring ISO form
(assert (= ts_unsat "2026-1-07T12:34:56Z")) ; month has 1 digit -> violates 2-digit requirement
(assert (str.in_re ts_unsat
  (re.++
    (re.loop (re.range "0" "9") 4 4)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "-")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "T")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re ":")
    (re.loop (re.range "0" "9") 2 2)
    (str.to_re "Z"))))

; Also parse log level token and constrain it well-formed
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (= (split_at level_colon_unsat ":" 1) ""))
(assert (= (num_splits level_colon_unsat ":") 2))
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
