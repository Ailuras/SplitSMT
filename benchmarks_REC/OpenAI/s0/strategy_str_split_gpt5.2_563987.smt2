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

; Log Analysis: parsing structured server log entries separated by spaces and colons.
; We model split constraints using the provided str_split interface and add
; timestamp format validation plus log level extraction.

; --- str_split interface (uninterpreted) ---

; --- Shared regex building blocks ---
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.range "0" "9")))

(declare-const TWO_DIGITS_RE RegLan)
(assert (= TWO_DIGITS_RE (re.++ DIGIT_RE DIGIT_RE)))

(declare-const FOUR_DIGITS_RE RegLan)
(assert (= FOUR_DIGITS_RE (re.++ DIGIT_RE DIGIT_RE DIGIT_RE DIGIT_RE)))

; timestamp: YYYY-MM-DDTHH:MM:SSZ
(declare-const TS_RE RegLan)
(assert (= TS_RE
  (re.++ FOUR_DIGITS_RE (str.to_re "-") TWO_DIGITS_RE (str.to_re "-") TWO_DIGITS_RE
         (str.to_re "T") TWO_DIGITS_RE (str.to_re ":") TWO_DIGITS_RE (str.to_re ":") TWO_DIGITS_RE
         (str.to_re "Z"))))

; level: INFO|WARN|ERROR|DEBUG
(declare-const LEVEL_RE RegLan)
(assert (= LEVEL_RE
  (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; -----------------------------
; SAT instance: well-formed entry
; Format example:
;   2026-01-07T12:34:56Z INFO auth:user=jdoe action=login status:200
; We validate timestamp token and level token and parse colon-separated status.
; -----------------------------

(declare-const log_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const msg_sat String)
(declare-const status_field_sat String)
(declare-const status_code_sat String)

; Split by spaces: ts, level, remainder
(assert (= ts_sat (split_at log_sat " " 0)))
(assert (= lvl_sat (split_at log_sat " " 1)))
(assert (= msg_sat (split_rest log_sat " " 2)))
(assert (>= (num_splits log_sat " ") 3))

; Timestamp and level validation
(assert (str.in_re ts_sat TS_RE))
(assert (str.in_re lvl_sat LEVEL_RE))

; Ensure message contains a status field with a colon
(assert (str.contains msg_sat "status:"))
(assert (= status_field_sat (split_at msg_sat " " 2)))
(assert (str.contains status_field_sat "status:"))

; Parse status_field by colon: "status" ":" "200"
(assert (= (split_at status_field_sat ":" 0) "status"))
(assert (= status_code_sat (split_at status_field_sat ":" 1)))
(assert (>= (num_splits status_field_sat ":") 2))
(assert (str.in_re status_code_sat (re.++ DIGIT_RE DIGIT_RE DIGIT_RE)))

; Constrain the concrete log to witness satisfiable parsing
(assert (= log_sat "2026-01-07T12:34:56Z INFO auth:user=jdoe action=login status:200"))

; -----------------------------
; UNSAT instance: conflicting requirements
; We require the extracted level to be a valid level token, but also force it to be "VERBOSE".
; Additionally, we require the timestamp to match TS_RE, but force a malformed timestamp.
; -----------------------------

(declare-const log_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)

(assert (= ts_unsat (split_at log_unsat " " 0)))
(assert (= lvl_unsat (split_at log_unsat " " 1)))
(assert (>= (num_splits log_unsat " ") 2))

(assert (str.in_re ts_unsat TS_RE))
(assert (str.in_re lvl_unsat LEVEL_RE))

; Force contradictions
(assert (= lvl_unsat "VERBOSE"))
(assert (= ts_unsat "2026-1-07T12:34:56Z"))

; Also pin the overall log to be consistent with those first two tokens
(assert (= log_unsat (str.++ ts_unsat " " lvl_unsat " something:here")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
