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

; Uninterpreted interface for string split methodology

; =========================
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Example shape (conceptual):
;   YYYY-MM-DD HH:MM:SS:LEVEL message...
; =========================

; ---------- SAT instance ----------
(declare-const log_line String)
(declare-const token0 String) ; date
(declare-const token1 String) ; time:level
(declare-const token2 String) ; message remainder (first word)
(declare-const rest_after2 String)

(declare-const date String)
(declare-const time_level String)
(declare-const time_str String)
(declare-const level_str String)
(declare-const message_str String)

; Split by spaces: require at least 3 tokens: date, time:level, message...
(assert (>= (num_splits log_line " ") 3))
(assert (= token0 (split_at log_line " " 0)))
(assert (= token1 (split_at log_line " " 1)))
(assert (= token2 (split_at log_line " " 2)))
(assert (= rest_after2 (split_rest log_line " " 2)))

; token0 is the date
(assert (= date token0))

; token1 is "HH:MM:SS:LEVEL" split by ':'
(assert (= time_level token1))
(assert (>= (num_splits time_level ":") 4))
(assert (= time_str (str.++ (split_at time_level ":" 0) ":" (split_at time_level ":" 1) ":" (split_at time_level ":" 2))))
(assert (= level_str (split_at time_level ":" 3)))

; message starts at token2 and continues
(assert (= message_str rest_after2))

; Date format validation: YYYY-MM-DD
(assert (= (str.len date) 10))
(assert (= (str.at date 4) "-"))
(assert (= (str.at date 7) "-"))
(assert (str.in_re date (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; Time format validation: HH:MM:SS (basic digits/colons + ranges on HH, MM, SS)
(assert (= (str.len time_str) 8))
(assert (= (str.at time_str 2) ":"))
(assert (= (str.at time_str 5) ":"))
(assert (str.in_re time_str (re.++ (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re ":")
                                   (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re ":")
                                   (re.loop (re.range "0" "9") 2 2))))

; Tighten time ranges (without numeric conversion):
; HH in 00-23
(assert (or (= (str.at time_str 0) "0")
            (= (str.at time_str 0) "1")
            (= (str.at time_str 0) "2")))
(assert (or (and (= (str.at time_str 0) "2") (or (= (str.at time_str 1) "0")
                                                  (= (str.at time_str 1) "1")
                                                  (= (str.at time_str 1) "2")
                                                  (= (str.at time_str 1) "3")))
            (and (or (= (str.at time_str 0) "0") (= (str.at time_str 0) "1"))
                 (str.in_re (str.at time_str 1) (re.range "0" "9")))))

; MM and SS in 00-59
(assert (or (= (str.at time_str 3) "0")
            (= (str.at time_str 3) "1")
            (= (str.at time_str 3) "2")
            (= (str.at time_str 3) "3")
            (= (str.at time_str 3) "4")
            (= (str.at time_str 3) "5")))
(assert (or (= (str.at time_str 6) "0")
            (= (str.at time_str 6) "1")
            (= (str.at time_str 6) "2")
            (= (str.at time_str 6) "3")
            (= (str.at time_str 6) "4")
            (= (str.at time_str 6) "5")))
(assert (str.in_re (str.at time_str 4) (re.range "0" "9")))
(assert (str.in_re (str.at time_str 7) (re.range "0" "9")))

; Log level extraction: constrain to common levels
(assert (or (= level_str "INFO") (= level_str "WARN") (= level_str "ERROR") (= level_str "DEBUG")))

; Message must be non-empty and should not contain ':' in its first token (simple heuristic)
(assert (> (str.len message_str) 0))
(assert (not (str.contains token2 ":")))

; Provide a concrete satisfying structure (still leaves freedom for other parts)
(assert (str.prefixof "2025-01-" date))
(assert (= (str.at date 8) "0"))
(assert (= (str.at date 9) "7"))
(assert (= time_str "12:34:56"))
(assert (= level_str "INFO"))
(assert (str.contains message_str "request"))

; ---------- UNSAT instance (separate set of vars) ----------
(declare-const bad_log_line String)
(declare-const bad_date String)
(declare-const bad_time_level String)
(declare-const bad_time_str String)
(declare-const bad_level_str String)

; Basic parsing constraints
(assert (>= (num_splits bad_log_line " ") 2))
(assert (= bad_date (split_at bad_log_line " " 0)))
(assert (= bad_time_level (split_at bad_log_line " " 1)))
(assert (>= (num_splits bad_time_level ":") 4))
(assert (= bad_time_str (str.++ (split_at bad_time_level ":" 0) ":" (split_at bad_time_level ":" 1) ":" (split_at bad_time_level ":" 2))))
(assert (= bad_level_str (split_at bad_time_level ":" 3)))

; Contradictory timestamp constraints: enforce both a strict date regex AND wrong fixed separators
(assert (= (str.len bad_date) 10))
(assert (= (str.at bad_date 4) "-")
)
(assert (= (str.at bad_date 7) "-"))
(assert (str.in_re bad_date (re.++ (re.loop (re.range "0" "9") 4 4)
                                   (str.to_re "-")
                                   (re.loop (re.range "0" "9") 2 2)
                                   (str.to_re "-")
                                   (re.loop (re.range "0" "9") 2 2))))
; Force an impossible character at a fixed digit position
(assert (= (str.at bad_date 0) "X"))

; Also add contradictory log-level constraints
(assert (or (= bad_level_str "INFO") (= bad_level_str "WARN")))
(assert (= bad_level_str "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
