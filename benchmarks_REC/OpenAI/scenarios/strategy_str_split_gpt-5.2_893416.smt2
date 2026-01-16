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

; --- Uninterpreted interface functions for str_split ---

; --- Log analysis variables ---
(declare-const log_entry String)
(declare-const ts_token String)
(declare-const lvl_token String)
(declare-const component_token String)
(declare-const message_rest String)

(declare-const date_part String)
(declare-const time_part String)
(declare-const hour_part String)
(declare-const minute_part String)
(declare-const second_part String)

(declare-const sat_example Bool)
(declare-const unsat_example Bool)

; =========================================================
; SAT instance: well-formed log entry with timestamp + level
; Format: "YYYY-MM-DD HH:MM:SS LEVEL component: message..."
; =========================================================
(assert (= sat_example true))
(assert (= log_entry "2024-11-05 14:03:09 INFO auth: login ok"))

; Split by spaces: [0]=date, [1]=time, [2]=level, [3]=component:, [4..]=message...
(assert (= ts_token (split_at log_entry " " 0)))
(assert (= time_part (split_at log_entry " " 1)))
(assert (= lvl_token (split_at log_entry " " 2)))
(assert (= component_token (split_at log_entry " " 3)))
(assert (= message_rest (split_rest log_entry " " 4)))
(assert (>= (num_splits log_entry " ") 5))

; Timestamp date validation: YYYY-MM-DD
(assert (= date_part ts_token))
(assert (= (str.len date_part) 10))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= (str.len time_part) 8))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= hour_part (split_at time_part ":" 0)))
(assert (= minute_part (split_at time_part ":" 1)))
(assert (= second_part (split_at time_part ":" 2)))
(assert (= (num_splits time_part ":") 3))
(assert (= (str.len hour_part) 2))
(assert (= (str.len minute_part) 2))
(assert (= (str.len second_part) 2))
(assert (str.in_re hour_part (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re minute_part (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re second_part (re.++ (re.range "5" "5") (re.range "9" "9"))))

; Log level extraction/validation
(assert (or (= lvl_token "INFO") (= lvl_token "WARN") (= lvl_token "ERROR") (= lvl_token "DEBUG")))

; Component token ends with ':' and message contains a keyword
(assert (= (str.at component_token (- (str.len component_token) 1)) ":"))
(assert (str.contains message_rest "login"))

; =========================================================
; UNSAT instance: force contradictory timestamp/level constraints
; We reuse the same log_entry but require an impossible level
; and impossible time separator positions simultaneously.
; =========================================================
(assert (= unsat_example true))

; Contradiction: extracted level must be both INFO (by concrete log) and ERROR
(assert (= lvl_token "ERROR"))

; Contradiction: time token must have ':' at index 1 (but in "14:03:09" it's at 2)
(assert (= (str.at time_part 1) ":"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
