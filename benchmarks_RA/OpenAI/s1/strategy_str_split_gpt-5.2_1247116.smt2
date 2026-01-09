(set-logic ALL)

; Uninterpreted interface for split operations
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
; Format target (example): "2026-01-09T12:34:56Z INFO: service: message"
(declare-const log_entry String)
(declare-const timestamp String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const payload String)
(declare-const service String)
(declare-const message String)

; Core structure preserved: use indexof/substr/contains and many nested boolean/ite checks
(declare-const ts_end Int)
(declare-const t_part String)

(assert (and
  ; basic presence checks (space-separated fields and colon markers)
  (not (= (ite (str.contains log_entry " ") 1 0) 0))
  (not (= (ite (str.contains log_entry ":") 1 0) 0))
  (not (not (= (ite (= (str.len log_entry) 0) 1 0) 0)))

  ; define split-derived pieces (uninterpreted but constrained)
  (= timestamp (split_at log_entry " " 0))
  (= level_with_colon (split_at log_entry " " 1))
  (= payload (split_rest log_entry " " 2))
  (>= (num_splits log_entry " ") 3)

  ; level_with_colon must end with ':' and level is level_with_colon without trailing ':'
  (>= (str.len level_with_colon) 2)
  (= (str.at level_with_colon (- (str.len level_with_colon) 1)) ":")
  (= level (str.substr level_with_colon 0 (- (str.len level_with_colon) 1)))

  ; level is one of common levels
  (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG"))

  ; payload must contain a service prefix followed by ':'
  (not (= (ite (str.contains payload ":") 1 0) 0))
  (= service (split_at payload ":" 0))
  (= message (split_rest payload ":" 1))
  (>= (num_splits payload ":") 2)
  (not (= (str.len service) 0))

  ; timestamp format validation using indexof/substr/at (YYYY-MM-DDThh:mm:ssZ)
  (= ts_end (str.len timestamp))
  (= t_part (str.substr timestamp 0 ts_end))
  (>= ts_end 20)
  (= (str.at t_part 4) "-")
  (= (str.at t_part 7) "-")
  (= (str.at t_part 10) "T")
  (= (str.at t_part 13) ":")
  (= (str.at t_part 16) ":")
  (= (str.at t_part 19) "Z")

  ; Ensure timestamp has no spaces and does not contain a colon prefix marker like "["
  (not (= (ite (str.contains timestamp " ") 1 0) 1))
  (not (not (= (ite (= (str.at timestamp 0) "[") 1 0) 0)))

  ; Mutated seed-like nested block: require timestamp to NOT contain any uppercase A..Q
  ; (keeps the "many nested (not (not (= (ite (str.contains ...) ...)))" structure)
  (and
    (not (not (= (ite (str.contains t_part "Q") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "P") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "O") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "N") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "M") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "L") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "K") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "J") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "I") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "H") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "G") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "F") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "E") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "D") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "C") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "B") 1 0) 0)))
    (not (not (= (ite (str.contains t_part "A") 1 0) 0)))
  )

  ; bounds similar to seed style, but adapted
  (>= ts_end 0)
  (>= (str.indexof log_entry " " 0) 0)
  (>= (str.indexof payload ":" 0) 0)
  (>= (str.len message) 0)
))

; Add a deliberate UNSAT branch gated by a constant (forces inconsistency)
; Here, we assert timestamp ends with 'Z' above, and also assert it ends with 'X'.
(assert (= (str.at timestamp 19) "X"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
