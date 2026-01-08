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

; Uninterpreted interface operations (str_split)

; ------------------------------
; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; We create both SAT and UNSAT instances within one file.
; ------------------------------

; ---------- SAT instance ----------
(declare-const log_line_sat String)
(declare-const ts_sat String)          ; timestamp token
(declare-const level_sat String)       ; log level token
(declare-const remainder_sat String)   ; remaining message
(declare-const date_sat String)
(declare-const time_sat String)
(declare-const yyyy_sat String)
(declare-const mm_sat String)
(declare-const dd_sat String)
(declare-const HH_sat String)
(declare-const MI_sat String)
(declare-const SS_sat String)
(declare-const msg_sat String)

; Tokenization by spaces: "<timestamp> <level>: <message...>"
(assert (= ts_sat (split_at log_line_sat " " 0)))
(assert (= level_sat (split_at log_line_sat " " 1)))
(assert (= remainder_sat (split_rest log_line_sat " " 2)))
(assert (>= (num_splits log_line_sat " ") 3))

; Timestamp shape validation: "YYYY-MM-DDTHH:MI:SS" (length 19)
(assert (= 19 (str.len ts_sat)))
(assert (= date_sat (split_at ts_sat "T" 0)))
(assert (= time_sat (split_at ts_sat "T" 1)))
(assert (= 2 (num_splits ts_sat "T")))

(assert (= yyyy_sat (split_at date_sat "-" 0)))
(assert (= mm_sat   (split_at date_sat "-" 1)))
(assert (= dd_sat   (split_at date_sat "-" 2)))
(assert (= 3 (num_splits date_sat "-")))
(assert (= 4 (str.len yyyy_sat)))
(assert (= 2 (str.len mm_sat)))
(assert (= 2 (str.len dd_sat)))

(assert (= HH_sat (split_at time_sat ":" 0)))
(assert (= MI_sat (split_at time_sat ":" 1)))
(assert (= SS_sat (split_at time_sat ":" 2)))
(assert (= 3 (num_splits time_sat ":")))
(assert (= 2 (str.len HH_sat)))
(assert (= 2 (str.len MI_sat)))
(assert (= 2 (str.len SS_sat)))

; Constrain timestamp components to be digits using regex (SLIA)
(assert (str.in_re yyyy_sat (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mm_sat   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd_sat   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re HH_sat   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re MI_sat   (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re SS_sat   (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Ensure exact separators at fixed positions in timestamp token
(assert (= (str.at ts_sat 4) "-"))
(assert (= (str.at ts_sat 7) "-"))
(assert (= (str.at ts_sat 10) "T"))
(assert (= (str.at ts_sat 13) ":"))
(assert (= (str.at ts_sat 16) ":"))

; Log level extraction: token has form "LEVEL:" and should be one of known levels
(assert (str.in_re level_sat (re.union (str.to_re "INFO:") (re.union (str.to_re "WARN:") (re.union (str.to_re "ERROR:") (str.to_re "DEBUG:"))))))

; Remainder must start with a space-separated message, and include "user=" key somewhere
(assert (>= (str.len remainder_sat) 1))
(assert (str.contains remainder_sat "user="))

; Provide a concrete satisfying shape for additional diversity
(assert (str.contains remainder_sat " action="))
(assert (str.contains remainder_sat "status="))

; A concrete message can be constrained via split on ":" for the level token
; Example: "INFO:" has one ':' at end, so splitting by ':' yields ["INFO", ""]
(declare-const level_name_sat String)
(declare-const level_suffix_sat String)
(assert (= level_name_sat (split_at level_sat ":" 0)))
(assert (= level_suffix_sat (split_at level_sat ":" 1)))
(assert (= 2 (num_splits level_sat ":")))
(assert (= level_suffix_sat ""))
(assert (str.in_re level_name_sat (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Force a specific plausible log line prefix structure without fixing the entire message
(assert (= log_line_sat (str.++ ts_sat (str.++ " " (str.++ level_sat (str.++ " " remainder_sat))))))

; ---------- UNSAT instance ----------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const level_unsat String)

; Tokenization by spaces
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= level_unsat (split_at log_line_unsat " " 1)))
(assert (>= (num_splits log_line_unsat " ") 2))

; Contradictory timestamp requirements: length forced to 19 but also equal to a 10-char string
(assert (= 19 (str.len ts_unsat)))
(assert (= ts_unsat "2025-01-07"))

; Contradictory log level requirements: must be "INFO:" and also "ERROR:"
(assert (= level_unsat "INFO:"))
(assert (= level_unsat "ERROR:"))

; ---------- Combined satisfiability check ----------
; Because the UNSAT block is included, the whole file is UNSAT.
(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
