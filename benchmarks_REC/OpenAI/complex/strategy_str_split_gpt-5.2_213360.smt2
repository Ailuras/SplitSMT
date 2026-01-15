(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; --- str_split interface (uninterpreted) ---
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

; --- Variables ---
(declare-const log_line String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const ts_h String)
(declare-const ts_m String)
(declare-const ts_s String)
(declare-const level String)
(declare-const message String)

; --- Core structure: keep a seed-like regex nucleus but adapt to logs ---
; Require the full log line to contain at least one "00" pair (retains seed flavor).
(assert (str.in_re log_line (re.* (re.++ (re.* re.allchar) (re.++ (str.to_re "00") (re.* re.allchar))))))

; Split by spaces: "YYYY-MM-DD" "HH:MM:SS" "LEVEL:" rest...
(assert (>= (num_splits log_line " ") 4))
(assert (= ts_date (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level   (split_at log_line " " 2)))
(assert (= message (split_rest log_line " " 3)))

; Split time by ':' into HH MM SS
(assert (>= (num_splits ts_time ":") 3))
(assert (= ts_h (split_at ts_time ":" 0)))
(assert (= ts_m (split_at ts_time ":" 1)))
(assert (= ts_s (split_at ts_time ":" 2)))

; Timestamp format checks: fixed widths
(assert (= (str.len ts_date) 10))
(assert (= (str.len ts_time) 8))
(assert (= (str.len ts_h) 2))
(assert (= (str.len ts_m) 2))
(assert (= (str.len ts_s) 2))

; Date regex: YYYY-MM-DD where Y/M/D are digits
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun TWO_DIGITS () RegLan (re.++ DIGIT DIGIT))
(define-fun FOUR_DIGITS () RegLan (re.++ TWO_DIGITS TWO_DIGITS))
(define-fun DATE_RE () RegLan (re.++ FOUR_DIGITS (re.++ (str.to_re "-") (re.++ TWO_DIGITS (re.++ (str.to_re "-") TWO_DIGITS)))))
(assert (str.in_re ts_date DATE_RE))

; Time regex: HH:MM:SS with digits and colons
(define-fun TIME_RE () RegLan (re.++ TWO_DIGITS (re.++ (str.to_re ":") (re.++ TWO_DIGITS (re.++ (str.to_re ":") TWO_DIGITS)))))
(assert (str.in_re ts_time TIME_RE))

; Log level extraction: expect a trailing ':' like "INFO:" or "ERROR:"
(assert (str.in_re level (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (re.union (str.to_re "ERROR:") (str.to_re "DEBUG:"))))))

; Message sanity: must be non-empty and contain a colon-separated key:value somewhere
(assert (> (str.len message) 0))
(assert (str.contains message ":"))

; --- Create diversity: add a SAT branch plus an explicit UNSAT core guarded by a flag ---
(declare-const make_unsat Bool)

; SAT-friendly constraint: if not forcing UNSAT, forbid the message from containing "panic"
(assert (=> (not make_unsat) (not (str.contains message "panic"))))

; UNSAT block: if make_unsat then require incompatible regex conditions on log_line
; 1) log_line must be composed only of '0' and '1'
; 2) log_line must contain a '-' (from date), impossible under (1)
(assert (=> make_unsat (str.in_re log_line (re.* (re.union (str.to_re "0") (str.to_re "1"))))))
(assert (=> make_unsat (str.contains log_line "-")))

; Additionally retain a seed-like negated regex, but adapted to log_line:
; If make_unsat then forbid any occurrence of "000" or "1" in a star-language (makes it even tighter)
(assert (=> make_unsat (not (str.in_re log_line (re.* (re.union (str.to_re "000") (str.to_re "1")))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
