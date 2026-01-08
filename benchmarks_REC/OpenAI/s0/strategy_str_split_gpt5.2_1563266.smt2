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

; Uninterpreted interface for string splitting

; ------------ SAT instance: structured log parsing ------------
(declare-const log_line_sat String)
(declare-const ts_sat String)
(declare-const lvl_sat String)
(declare-const rest_sat String)
(declare-const hour_sat String)
(declare-const minute_sat String)
(declare-const second_sat String)
(declare-const msg_sat String)

; Tokenize by spaces: "<timestamp> <level> <message...>"
(assert (>= (num_splits log_line_sat " ") 3))
(assert (= ts_sat   (split_at log_line_sat " " 0)))
(assert (= lvl_sat  (split_at log_line_sat " " 1)))
(assert (= rest_sat (split_rest log_line_sat " " 2)))

; Message should be non-empty and not contain newline
(assert (> (str.len rest_sat) 0))
(assert (not (str.contains rest_sat "\n")))

; Restrict log level
(assert (or (= lvl_sat "INFO") (= lvl_sat "WARN") (= lvl_sat "ERROR") (= lvl_sat "DEBUG")))

; Timestamp format validation: HH:MM:SS (very common in logs)
(assert (>= (num_splits ts_sat ":") 3))
(assert (= hour_sat   (split_at ts_sat ":" 0)))
(assert (= minute_sat (split_at ts_sat ":" 1)))
(assert (= second_sat (split_at ts_sat ":" 2)))

; Enforce exact two digits for each field
(assert (= (str.len hour_sat) 2))
(assert (= (str.len minute_sat) 2))
(assert (= (str.len second_sat) 2))

; Digit regex
(define-fun is2digits ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (is2digits hour_sat))
(assert (is2digits minute_sat))
(assert (is2digits second_sat))

; Additionally constrain minute and second to be 00-59 using regex
; 00-59 = [0-5][0-9]
(define-fun is00to59 ((s String)) Bool
  (str.in_re s (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (is00to59 minute_sat))
(assert (is00to59 second_sat))

; Constrain hour to be 00-23 using a union of 0[0-9],1[0-9],2[0-3]
(define-fun is00to23 ((s String)) Bool
  (str.in_re s (re.union
                 (re.++ (str.to_re "0") (re.range "0" "9"))
                 (re.++ (str.to_re "1") (re.range "0" "9"))
                 (re.++ (str.to_re "2") (re.range "0" "3")))))
(assert (is00to23 hour_sat))

; Build a more specific message structure: "user:<id> action:<word>"
; Split by spaces inside rest
(assert (>= (num_splits rest_sat " ") 2))
(assert (= msg_sat rest_sat))
(declare-const kv1_sat String)
(declare-const kv2_sat String)
(assert (= kv1_sat (split_at msg_sat " " 0)))
(assert (= kv2_sat (split_at msg_sat " " 1)))

; Each kv is key:value using colon
(declare-const key1_sat String)
(declare-const val1_sat String)
(declare-const key2_sat String)
(declare-const val2_sat String)
(assert (>= (num_splits kv1_sat ":") 2))
(assert (>= (num_splits kv2_sat ":") 2))
(assert (= key1_sat (split_at kv1_sat ":" 0)))
(assert (= val1_sat (split_at kv1_sat ":" 1)))
(assert (= key2_sat (split_at kv2_sat ":" 0)))
(assert (= val2_sat (split_at kv2_sat ":" 1)))

(assert (= key1_sat "user"))
(assert (= key2_sat "action"))
(assert (> (str.len val1_sat) 0))
(assert (> (str.len val2_sat) 0))

; user id is alphanumeric+underscore
(assert (str.in_re val1_sat (re.+ (re.union (re.range "a" "z")
                                         (re.range "A" "Z")
                                         (re.range "0" "9")
                                         (str.to_re "_")))))

; action is lowercase letters
(assert (str.in_re val2_sat (re.+ (re.range "a" "z"))))

; Ensure the overall line is consistent with the split (weak consistency check)
; Enforce that log_line_sat begins with ts_sat + space + lvl_sat + space
(assert (str.prefixof (str.++ ts_sat " " lvl_sat " ") log_line_sat))

; ------------ UNSAT instance: contradicting timestamp checks ------------
(declare-const log_line_unsat String)
(declare-const ts_unsat String)
(declare-const lvl_unsat String)
(declare-const hour_unsat String)
(declare-const minute_unsat String)
(declare-const second_unsat String)

(assert (>= (num_splits log_line_unsat " ") 2))
(assert (= ts_unsat (split_at log_line_unsat " " 0)))
(assert (= lvl_unsat (split_at log_line_unsat " " 1)))
(assert (or (= lvl_unsat "INFO") (= lvl_unsat "ERROR")))

(assert (>= (num_splits ts_unsat ":") 3))
(assert (= hour_unsat   (split_at ts_unsat ":" 0)))
(assert (= minute_unsat (split_at ts_unsat ":" 1)))
(assert (= second_unsat (split_at ts_unsat ":" 2)))

(assert (= (str.len hour_unsat) 2))
(assert (= (str.len minute_unsat) 2))
(assert (= (str.len second_unsat) 2))

; Force minute to be in 00-59
(assert (is00to59 minute_unsat))

; Contradiction: also require minute to be "60"
(assert (= minute_unsat "60"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
