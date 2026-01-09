(set-logic ALL)

; Uninterpreted interface for string split
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

; === SAT instance: structured log parsing ===
(declare-const log_line String)
(declare-const ts_token String)
(declare-const level_token String)
(declare-const component_token String)
(declare-const message_tail String)
(declare-const ts_date String)
(declare-const ts_time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const yyyy String)
(declare-const mon String)
(declare-const dd String)

; Split by spaces: "YYYY-MM-DD HH:MM:SS LEVEL component: message..."
(assert (>= (num_splits log_line " ") 5))
(assert (= ts_token (split_at log_line " " 0)))
(assert (= ts_time (split_at log_line " " 1)))
(assert (= level_token (split_at log_line " " 2)))
(assert (= component_token (split_at log_line " " 3)))
(assert (= message_tail (split_rest log_line " " 4)))

; Timestamp date validation: YYYY-MM-DD
(assert (= yyyy (split_at ts_token "-" 0)))
(assert (= mon (split_at ts_token "-" 1)))
(assert (= dd (split_at ts_token "-" 2)))
(assert (= 3 (num_splits ts_token "-")))
(assert (str.in_re yyyy (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mon (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re dd (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Timestamp time validation: HH:MM:SS
(assert (= hh (split_at ts_time ":" 0)))
(assert (= mm (split_at ts_time ":" 1)))
(assert (= ss (split_at ts_time ":" 2)))
(assert (= 3 (num_splits ts_time ":")))
(assert (str.in_re hh (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Log level extraction/validation
(assert (or (= level_token "INFO") (= level_token "WARN") (= level_token "ERROR") (= level_token "DEBUG")))

; Component token ends with ':' and is non-empty
(assert (>= (str.len component_token) 2))
(assert (= (str.at component_token (- (str.len component_token) 1)) ":"))

; Message should be non-empty and should not contain newline
(assert (> (str.len message_tail) 0))
(assert (not (str.contains message_tail "\n")))

; Provide one concrete witness shape to ensure SAT
(assert (= log_line "2025-01-09 12:34:56 INFO auth: user login ok"))

; === UNSAT instance: contradictory timestamp checks on a second line ===
(declare-const bad_log_line String)
(declare-const bad_ts_date String)
(declare-const bad_ts_time String)
(declare-const bad_level String)
(declare-const bad_component String)
(declare-const bad_msg String)
(declare-const bad_hh String)
(declare-const bad_mm String)
(declare-const bad_ss String)

(assert (>= (num_splits bad_log_line " ") 5))
(assert (= bad_ts_date (split_at bad_log_line " " 0)))
(assert (= bad_ts_time (split_at bad_log_line " " 1)))
(assert (= bad_level (split_at bad_log_line " " 2)))
(assert (= bad_component (split_at bad_log_line " " 3)))
(assert (= bad_msg (split_rest bad_log_line " " 4)))

; Force a specific shape that will clash with additional constraints
(assert (= bad_log_line "2025-01-09 00:00:00 ERROR db: fail"))

; Extract time fields
(assert (= bad_hh (split_at bad_ts_time ":" 0)))
(assert (= bad_mm (split_at bad_ts_time ":" 1)))
(assert (= bad_ss (split_at bad_ts_time ":" 2)))
(assert (= 3 (num_splits bad_ts_time ":")))

; Contradiction: require hour to be exactly "00" and also "23"
(assert (= bad_hh "00"))
(assert (= bad_hh "23"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
