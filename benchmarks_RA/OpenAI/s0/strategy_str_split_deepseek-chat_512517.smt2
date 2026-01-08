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

; Uninterpreted split interface (provided)

; Uninterpreted helpers for log parsing
(declare-fun is_valid_timestamp (String) Bool)
(declare-fun is_valid_ipv4 (String) Bool)
(declare-fun is_log_level (String) Bool)

; -----------------------------
; SAT instance: consistent log analysis constraints
; Format (typical): "YYYY-MM-DD HH:MM:SS LEVEL: component: message"
; -----------------------------
(declare-const log_line_sat String)
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const level_colon_sat String)
(declare-const level_sat String)
(declare-const remainder_sat String)
(declare-const component_sat String)
(declare-const message_sat String)

(assert (= date_sat (split_at log_line_sat " " 0)))
(assert (= time_sat (split_at log_line_sat " " 1)))
(assert (= level_colon_sat (split_at log_line_sat " " 2)))
(assert (= remainder_sat (split_rest log_line_sat " " 3)))
(assert (>= (num_splits log_line_sat " ") 4))

; Enforce timestamp structure via regex plus a semantic predicate
(assert (str.in_re date_sat (re.++ (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (re.range "0" "9") (str.to_re "-")
                                  (re.range "0" "9") (re.range "0" "9") (str.to_re "-")
                                  (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re time_sat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                  (re.range "0" "9") (re.range "0" "9"))))
(assert (is_valid_timestamp (str.++ date_sat " " time_sat)))

; Extract log level token before ':' by splitting the 3rd field by ':'
(assert (= level_sat (split_at level_colon_sat ":" 0)))
(assert (>= (num_splits level_colon_sat ":") 2))
(assert (str.in_re level_sat (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))
(assert (is_log_level level_sat))

; Parse component and message from remainder: "component: message..."
(assert (= component_sat (split_at remainder_sat ":" 0)))
(assert (= message_sat (split_rest remainder_sat ":" 1)))
(assert (>= (num_splits remainder_sat ":") 2))

; Component is non-empty and alphanumeric/underscore/dash
(assert (>= (str.len component_sat) 1))
(assert (str.in_re component_sat (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))
                                      (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))))))

; Message constraints: must mention a keyword and have minimum length
(assert (>= (str.len message_sat) 10))
(assert (str.contains message_sat "request"))

; Concretize a satisfying example (still consistent with above constraints)
(assert (= log_line_sat "2025-01-07 13:45:02 INFO: auth: request accepted"))

; -----------------------------
; UNSAT instance: conflicting constraints for a malformed entry
; -----------------------------
(declare-const log_line_unsat String)
(declare-const date_unsat String)
(declare-const time_unsat String)
(declare-const level_colon_unsat String)
(declare-const level_unsat String)

(assert (= date_unsat (split_at log_line_unsat " " 0)))
(assert (= time_unsat (split_at log_line_unsat " " 1)))
(assert (= level_colon_unsat (split_at log_line_unsat " " 2)))
(assert (>= (num_splits log_line_unsat " ") 3))

; Require a valid-looking time, but also force an impossible length
(assert (str.in_re time_unsat (re.++ (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9") (str.to_re ":")
                                    (re.range "0" "9") (re.range "0" "9"))))
(assert (= (str.len time_unsat) 7))

; Force extraction of level, but also force it to be non-level
(assert (= level_unsat (split_at level_colon_unsat ":" 0)))
(assert (str.in_re level_unsat (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))
(assert (not (is_log_level level_unsat)))

; Concretize a line that otherwise looks plausible
(assert (= log_line_unsat "2025-01-07 13:45:02 ERROR: db: request failed"))

; -----------------------------
; Additional SAT instance: log entry with IPv4 in message and colon-separated kv
; -----------------------------
(declare-const log_line2 String)
(declare-const date2 String)
(declare-const time2 String)
(declare-const level_colon2 String)
(declare-const level2 String)
(declare-const rest2 String)
(declare-const msg2 String)
(declare-const ip2 String)
(declare-const kv2 String)
(declare-const key2 String)
(declare-const val2 String)

(assert (= date2 (split_at log_line2 " " 0)))
(assert (= time2 (split_at log_line2 " " 1)))
(assert (= level_colon2 (split_at log_line2 " " 2)))
(assert (= rest2 (split_rest log_line2 " " 3)))
(assert (>= (num_splits log_line2 " ") 4))

(assert (is_valid_timestamp (str.++ date2 " " time2)))
(assert (= level2 (split_at level_colon2 ":" 0)))
(assert (is_log_level level2))

; Message part contains an IP and a kv token like "user:alice"
(assert (= msg2 rest2))
(assert (str.contains msg2 "ip="))
(assert (str.contains msg2 "user:"))

; Extract ip after "ip=" by splitting message on "ip=" then take first space token
(assert (= ip2 (split_at (split_rest msg2 "ip=" 1) " " 0)))
(assert (is_valid_ipv4 ip2))

; Extract first kv token after a space before "user:" occurrence (relaxed)
(assert (= kv2 (split_at (split_rest msg2 " " 1) " " 0)))
(assert (>= (num_splits kv2 ":") 2))
(assert (= key2 (split_at kv2 ":" 0)))
(assert (= val2 (split_at kv2 ":" 1)))
(assert (= key2 "user"))
(assert (>= (str.len val2) 1))

(assert (= log_line2 "2025-01-07 13:45:03 WARN: net: ip=192.168.0.10 user:alice request slow"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
