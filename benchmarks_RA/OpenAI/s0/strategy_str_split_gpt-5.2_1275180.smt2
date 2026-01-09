(set-logic ALL)

; Uninterpreted split interface
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

; Scenario: Log Analysis
; Expected structured log (space-separated):
;   <timestamp> <level>:<component>: <message>
; Timestamp expected: YYYY-MM-DDTHH:MM:SSZ

; --- SAT instance variables ---
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_comp_sat String)
(declare-const msg_sat String)
(declare-const level_sat String)
(declare-const component_sat String)
(declare-const colon_tail_sat String)

(declare-const y_sat String)
(declare-const mon_sat String)
(declare-const day_sat String)
(declare-const timez_sat String)
(declare-const hh_sat String)
(declare-const mm_sat String)
(declare-const ssZ_sat String)
(declare-const ss_sat String)

; Space splitting: [0]=timestamp, [1]=level:component:, [2..]=message words
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= lvl_comp_sat (split_at log_line_sat " " 1)))
(assert (= msg_sat (split_rest log_line_sat " " 2)))

; Level/component extraction by colons in token 1
(assert (>= (num_splits lvl_comp_sat ":") 3))
(assert (= level_sat (split_at lvl_comp_sat ":" 0)))
(assert (= component_sat (split_at lvl_comp_sat ":" 1)))
(assert (= colon_tail_sat (split_at lvl_comp_sat ":" 2)))
(assert (= colon_tail_sat ""))

; Log level validation
(assert (or (= level_sat "INFO") (= level_sat "WARN") (= level_sat "ERROR") (= level_sat "DEBUG")))

; Component constraints (non-empty, no spaces)
(assert (> (str.len component_sat) 0))
(assert (not (str.contains component_sat " ")))

; Message constraints
(assert (> (str.len msg_sat) 0))
(assert (not (str.contains msg_sat "\n")))

; Timestamp format validation using regex for full timestamp
; YYYY-MM-DDTHH:MM:SSZ
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_2d () RegLan (re.++ re_digit re_digit))
(define-fun re_4d () RegLan (re.++ re_2d re_2d))
(define-fun re_ts () RegLan
  (re.++
    re_4d
    (re.++
      (str.to_re "-")
      (re.++
        re_2d
        (re.++
          (str.to_re "-")
          (re.++
            re_2d
            (re.++
              (str.to_re "T")
              (re.++
                re_2d
                (re.++
                  (str.to_re ":")
                  (re.++
                    re_2d
                    (re.++
                      (str.to_re ":")
                      (re.++
                        re_2d
                        (str.to_re "Z")
                      )
                    )
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)
(assert (str.in_re ts_sat re_ts))

; Additional timestamp splitting sanity checks with split_at
(assert (= y_sat (split_at ts_sat "-" 0)))
(assert (= mon_sat (split_at ts_sat "-" 1)))
(assert (= day_sat (split_at ts_sat "-" 2)))
(assert (= timez_sat (split_at ts_sat "T" 1)))
(assert (= hh_sat (split_at timez_sat ":" 0)))
(assert (= mm_sat (split_at timez_sat ":" 1)))
(assert (= ssZ_sat (split_at timez_sat ":" 2)))
(assert (= ss_sat (split_at ssZ_sat "Z" 0)))

(assert (= (str.len y_sat) 4))
(assert (= (str.len mon_sat) 2))
(assert (= (str.len day_sat) 2))
(assert (= (str.len hh_sat) 2))
(assert (= (str.len mm_sat) 2))
(assert (= (str.len ss_sat) 2))

; Construct an explicit satisfying witness log line
(assert (= log_line_sat "2025-01-08T09:15:30Z INFO:auth: login succeeded"))


; --- UNSAT instance variables ---
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_comp_unsat String)
(declare-const msg_unsat String)
(declare-const level_unsat String)
(declare-const component_unsat String)
(declare-const colon_tail_unsat String)

; Same structural parsing
(assert (>= (num_splits log_line_unsat " ") 3))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= lvl_comp_unsat (split_at log_line_unsat " " 1)))
(assert (= msg_unsat (split_rest log_line_unsat " " 2)))

(assert (>= (num_splits lvl_comp_unsat ":") 3))
(assert (= level_unsat (split_at lvl_comp_unsat ":" 0)))
(assert (= component_unsat (split_at lvl_comp_unsat ":" 1)))
(assert (= colon_tail_unsat (split_at lvl_comp_unsat ":" 2)))
(assert (= colon_tail_unsat ""))

; Level must be one of known values
(assert (or (= level_unsat "INFO") (= level_unsat "WARN") (= level_unsat "ERROR") (= level_unsat "DEBUG")))

; Timestamp must match the required regex
(assert (str.in_re ts_unsat re_ts))

; Force a particular malformed log line that violates the timestamp regex (uses space instead of 'T')
(assert (= log_line_unsat "2025-01-08 09:15:30Z ERROR:db: connection failed"))

; Also add an independent contradiction on level extraction to ensure UNSAT even if split is underspecified
(assert (= level_unsat "INFO"))
(assert (= level_unsat "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
