(set-logic ALL)

; Log Analysis scenario: parsing structured server log entries separated by spaces and colons
; We create both SAT and UNSAT instances by asserting a disjunction of two cases.

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
(declare-const ts String)
(declare-const lvl String)
(declare-const msg String)

; Additional extracted timestamp fields
(declare-const date String)
(declare-const time String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Regex helpers
(declare-const re2 (RegLan String))
(declare-const re4 (RegLan String))
(declare-const reDate (RegLan String))
(declare-const reTime (RegLan String))
(declare-const reTS (RegLan String))

; --- Regex definitions for timestamp format YYYY-MM-DD:HH:MM:SS ---
(assert (= re2 (re.loop (re.range "0" "9") 2 2)))
(assert (= re4 (re.loop (re.range "0" "9") 4 4)))
(assert (= reDate (re.++ re4 (str.to_re "-") re2 (str.to_re "-") re2)))
(assert (= reTime (re.++ re2 (str.to_re ":") re2 (str.to_re ":") re2)))
(assert (= reTS (re.++ reDate (str.to_re ":") reTime)))

; --- Common parsing constraints (apply in both SAT and UNSAT branches) ---
; log format: "<timestamp> <level> <message...>"
(assert (= ts (split_at log_line " " 0)))
(assert (= lvl (split_at log_line " " 1)))
(assert (= msg (split_rest log_line " " 2)))

; require at least 3 segments when splitting on space: ts, lvl, msg (msg may contain spaces)
(assert (>= (num_splits log_line " ") 3))

; Timestamp must match strict format
(assert (str.in_re ts reTS))

; Further split timestamp into date and time around the middle ':' between date and time
(assert (= date (split_at ts ":" 0)))
(assert (= time (split_at ts ":" 1)))
(assert (>= (num_splits ts ":") 2))

; Split date into year-month-day
(assert (= year (split_at date "-" 0)))
(assert (= month (split_at date "-" 1)))
(assert (= day (split_at date "-" 2)))
(assert (= (num_splits date "-") 3))

; Split time into hour:minute:second
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (= (num_splits time ":") 3))

; Basic length checks derived from the regex
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Log level should be one of common levels
(assert (or (= lvl "INFO") (= lvl "WARN") (= lvl "ERROR") (= lvl "DEBUG")))

; Message should be non-empty
(assert (> (str.len msg) 0))

; --- Create both SAT and UNSAT instances via branching ---
; SAT branch: concrete well-formed entry with consistent parsing
; UNSAT branch: forces a contradiction on timestamp length while keeping in_re constraint
(assert
  (or
    (and
      (= log_line "2025-12-31:23:59:58 INFO service:started")
      (str.contains msg "service")
      (not (str.contains msg "panic"))
      (<= (str.len msg) 64)
      (= lvl "INFO"))
    (and
      (= log_line "2025-01-02:03:04:05 ERROR bad:format")
      (= lvl "ERROR")
      ; Contradiction: valid timestamp regex implies length 19, but we assert it is 18
      (= (str.len ts) 18)
      (str.contains msg ":"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
