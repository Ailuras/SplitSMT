(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; ---------- SAT instance: well-formed log analysis ----------
(declare-const log_line String)
(declare-const timestamp String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const level_bracketed String)
(declare-const level String)
(declare-const module_tag String)
(declare-const message String)
(declare-const colon_after_level String)
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const HH String)
(declare-const MM String)
(declare-const SS String)
(declare-const dot_ms String)
(declare-const ms String)
(declare-const rest_after_module String)
(declare-const forced_example_level String)

; Structure: "<timestamp> <LEVEL>:<MODULE> <message...>"
(assert (>= (num_splits log_line " ") 3))
(assert (= timestamp (split_at log_line " " 0)))
(assert (= level_bracketed (split_at log_line " " 1)))
(assert (= module_tag (split_at log_line " " 2)))
(assert (= rest_after_module (split_rest log_line " " 3)))

; Message is everything after the third token, can be empty but typically present
(assert (= message rest_after_module))

; Timestamp: "YYYY-MM-DD HH:MM:SS.mmm" (space-separated date and time)
(assert (>= (num_splits timestamp " ") 2))
(assert (= date_part (split_at timestamp " " 0)))
(assert (= time_part (split_at timestamp " " 1)))

; Date: YYYY-MM-DD
(assert (= (str.len date_part) 10))
(assert (= yyyy (str.substr date_part 0 4)))
(assert (= mm (str.substr date_part 5 2)))
(assert (= dd (str.substr date_part 8 2)))
(assert (= (str.at date_part 4) "-"))
(assert (= (str.at date_part 7) "-"))
(assert (str.in_re yyyy (re.+ (re.range "0" "9"))))
(assert (= (str.len yyyy) 4))
(assert (str.in_re mm (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "3") (re.range "0" "9"))))

; Time: HH:MM:SS.mmm
(assert (= (str.len time_part) 12))
(assert (= HH (str.substr time_part 0 2)))
(assert (= MM (str.substr time_part 3 2)))
(assert (= SS (str.substr time_part 6 2)))
(assert (= dot_ms (str.substr time_part 8 4)))
(assert (= (str.at time_part 2) ":"))
(assert (= (str.at time_part 5) ":"))
(assert (= (str.at time_part 8) "."))
(assert (str.in_re HH (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re MM (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re SS (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (= ms (str.substr time_part 9 3)))
(assert (str.in_re ms (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9")))))

; Level extraction: token like "INFO:" or "ERROR:" (colon terminated)
(assert (>= (str.len level_bracketed) 2))
(assert (= colon_after_level (str.at level_bracketed (- (str.len level_bracketed) 1))))
(assert (= colon_after_level ":"))
(assert (= level (str.substr level_bracketed 0 (- (str.len level_bracketed) 1))))
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Module tag basic sanity: must not contain ':' and not be empty
(assert (>= (str.len module_tag) 1))
(assert (not (str.contains module_tag ":")))

; Additional SAT anchoring: make a concrete example consistent with constraints
(assert (= log_line "2025-01-09 13:45:27.123 INFO:auth User login success"))

; ---------- UNSAT instance: contradictory checks on another log line ----------
(declare-const bad_log_line String)
(declare-const bad_timestamp String)
(declare-const bad_level_token String)
(declare-const bad_level String)
(declare-const bad_time_part String)
(declare-const bad_date_part String)
(declare-const bad_colon_last String)

(assert (>= (num_splits bad_log_line " ") 2))
(assert (= bad_timestamp (split_at bad_log_line " " 0)))
(assert (= bad_level_token (split_at bad_log_line " " 1)))

; Force a specific bad line
(assert (= bad_log_line "2025-01-09 13:45:27.123 INFO:auth Something happened"))

; Extract timestamp components as above
(assert (>= (num_splits bad_timestamp " ") 2))
(assert (= bad_date_part (split_at bad_timestamp " " 0)))
(assert (= bad_time_part (split_at bad_timestamp " " 1)))

; Contradiction 1: require the time separator at position 2 to be '-' but also enforce it is ':'
(assert (= (str.at bad_time_part 2) ":"))
(assert (= (str.at bad_time_part 2) "-"))

; Contradiction 2: require level token to not end with ':' but also to end with ':'
(assert (>= (str.len bad_level_token) 2))
(assert (= bad_colon_last (str.at bad_level_token (- (str.len bad_level_token) 1))))
(assert (= bad_colon_last ":"))
(assert (not (= bad_colon_last ":")))

; Contradiction 3: enforce extracted level equals "INFO" but also "ERROR"
(assert (= bad_level (str.substr bad_level_token 0 (- (str.len bad_level_token) 1))))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
