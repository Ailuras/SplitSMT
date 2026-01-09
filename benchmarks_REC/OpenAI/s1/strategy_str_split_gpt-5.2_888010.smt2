(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks: timestamp format validation and log level extraction.

(declare-const X String)
(declare-const delim_space String)
(declare-const delim_colon String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_full String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const rest_after_ts String)
(declare-const rest_after_level String)
(declare-const rest_after_component String)

; str_split interface
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

(assert (= delim_space " "))
(assert (= delim_colon ":"))

; Core structure preserved: keep the seed-style negative regex constraint, but adapt to log context
(assert (not (str.in_re X
  (re.++ (str.to_re "ConnectionUser-Agent:")
         (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
         (str.to_re "www.fast-finder.com\u{a}")))))

; Split by spaces: expect at least 4 fields: timestamp, level, component:, message...
(assert (>= (num_splits X delim_space) 4))
(assert (= ts_full (split_at X delim_space 0)))
(assert (= level (split_at X delim_space 1)))
(assert (= component (split_at X delim_space 2)))
(assert (= msg (split_rest X delim_space 3)))

; Timestamp structured as YYYY-MM-DDTHH:MM:SSZ (no spaces)
(assert (= ts_date (split_at ts_full "T" 0)))
(assert (= ts_time (split_at ts_full "T" 1)))
(assert (= (num_splits ts_full "T") 2))
(assert (= (str.len ts_date) 10))
(assert (= (str.at ts_date 4) "-"))
(assert (= (str.at ts_date 7) "-"))

; Validate date digits where expected
(assert (str.in_re (str.substr ts_date 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_date 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_date 8 2) (re.+ (re.range "0" "9"))))

; Time part: HH:MM:SSZ
(assert (= (str.len ts_time) 9))
(assert (= (str.at ts_time 2) ":"))
(assert (= (str.at ts_time 5) ":"))
(assert (= (str.at ts_time 8) "Z"))
(assert (str.in_re (str.substr ts_time 0 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_time 3 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr ts_time 6 2) (re.+ (re.range "0" "9"))))

; Log level extraction: must be one of common levels
(assert (str.in_re level (re.union (str.to_re "INFO")
                                  (re.union (str.to_re "WARN")
                                            (re.union (str.to_re "ERROR")
                                                      (str.to_re "DEBUG"))))))

; Component expected to end with ':' and have non-empty name before it
(assert (>= (str.len component) 2))
(assert (= (str.at component (- (str.len component) 1)) ":"))
(assert (not (= (str.substr component 0 (- (str.len component) 1)) "")))

; Message should not be empty and should not contain a newline
(assert (> (str.len msg) 0))
(assert (not (str.contains msg "\n")))

; Additional derived parsing: split rest by ':' to see if msg includes key:value pairs
(assert (= rest_after_ts (split_rest X delim_space 1)))
(assert (= rest_after_level (split_rest X delim_space 2)))
(assert (= rest_after_component (split_rest X delim_space 3)))

; Ensure the remainder after timestamp still contains the level and component token
(assert (str.contains rest_after_ts level))
(assert (str.contains rest_after_level component))

; Make a small UNSAT branch controlled by an explicit contradiction on log level length
; This forces an UNSAT instance when level is constrained to both INFO and ERROR.
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat (and (= level "INFO") (= level "ERROR"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
