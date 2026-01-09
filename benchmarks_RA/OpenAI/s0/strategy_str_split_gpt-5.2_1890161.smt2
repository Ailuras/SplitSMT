(set-logic ALL)

; Uninterpreted interface for string split constraints
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

; -------------------------
; SAT instance: structured log parsing
; Format idea (space-separated):
;   <timestamp> <level>:<component>: <message>
; Example:
;   2026-01-09T12:34:56Z INFO:auth: user logged in
; -------------------------
(declare-const log_line String)
(declare-const ts String)
(declare-const level_and_more String)
(declare-const level_and_component String)
(declare-const message String)
(declare-const level String)
(declare-const component String)
(declare-const rest_after_level String)
(declare-const ts_date String)
(declare-const ts_time String)

; Ensure at least 3 space-separated fields: timestamp, level:component:, message...
(assert (>= (num_splits log_line " ") 3))
(assert (= ts (split_at log_line " " 0)))
(assert (= level_and_more (split_rest log_line " " 1)))
(assert (= level_and_component (split_at level_and_more " " 0)))
(assert (= message (split_rest level_and_more " " 1)))

; Parse level_and_component by ':'
(assert (>= (num_splits level_and_component ":") 3))
(assert (= level (split_at level_and_component ":" 0)))
(assert (= component (split_at level_and_component ":" 1)))
(assert (= rest_after_level (split_rest level_and_component ":" 1)))

; Timestamp basic structure: YYYY-MM-DDTHH:MM:SSZ
(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

; Timestamp split into date and time parts around 'T'
(assert (>= (num_splits ts "T") 2))
(assert (= ts_date (split_at ts "T" 0)))
(assert (= ts_time (split_at ts "T" 1)))
(assert (= (str.len ts_date) 10))
(assert (= (str.len ts_time) 9))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))

; Regex validation for digits in date/time
(assert (str.in_re ts (re.++ (re.loop (str.to_re "0") 0 0) (str.to_re ""))))
; Use a direct digit regex to enforce timestamp well-formedness
(define-fun digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun two_digits () RegLan (re.++ digit digit))
(define-fun four_digits () RegLan (re.++ two_digits two_digits))
(define-fun date_re () RegLan (re.++ four_digits (re.++ (str.to_re "-") (re.++ two_digits (re.++ (str.to_re "-") two_digits)))))
(define-fun time_re () RegLan (re.++ two_digits (re.++ (str.to_re ":") (re.++ two_digits (re.++ (str.to_re ":") (re.++ two_digits (str.to_re "Z")))))))
(define-fun ts_re () RegLan (re.++ date_re (re.++ (str.to_re "T") time_re)))
(assert (str.in_re ts ts_re))

; Level extraction constraints
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Component and message sanity constraints
(assert (>= (str.len component) 1))
(assert (not (str.contains component " ")))
(assert (>= (str.len message) 1))

; Additional structural check: rest_after_level begins with component followed by ':'
(assert (str.contains rest_after_level (str.++ component ":")))

; Provide a concrete satisfying example to anchor SAT
(assert (= log_line "2026-01-09T12:34:56Z INFO:auth: user logged in"))

(check-sat)

; -------------------------
; UNSAT instance: conflicting timestamp and level constraints
; -------------------------
(declare-const bad_line String)
(declare-const bad_ts String)
(declare-const bad_level_field String)
(declare-const bad_level String)

(assert (>= (num_splits bad_line " ") 2))
(assert (= bad_ts (split_at bad_line " " 0)))
(assert (= bad_level_field (split_at bad_line " " 1)))
(assert (= bad_level (split_at bad_level_field ":" 0)))

; Force a concrete bad log line
(assert (= bad_line "2026-01-09T12:34:56 INFO:core: missing Z suffix"))

; Require timestamp to match the strict regex (needs trailing 'Z'), but bad_line timestamp omits it
(assert (str.in_re bad_ts ts_re))

; Contradictory level requirement: extracted level must be INFO, but also must be ERROR
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

(check-sat)
(exit)
