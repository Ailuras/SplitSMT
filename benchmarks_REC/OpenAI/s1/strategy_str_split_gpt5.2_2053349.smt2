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

; Uninterpreted interface: string split operations

; Scenario: Log Analysis
; Structured server log entry: "YYYY-MM-DD:HH:MM:SS LEVEL message..."

(declare-const log_entry String)
(declare-const ts_field String)
(declare-const level_field String)
(declare-const msg_field String)

; Keep seed-like variables to preserve core structure and mutate it for logs
(declare-const key2 String)
(declare-const value2 String)

; Core parsing via spaces and colons
(assert (= ts_field (split_at log_entry " " 0)))
(assert (= level_field (split_at log_entry " " 1)))
(assert (= msg_field (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; Model the seed's key/value flavor as extracting a synthetic key=value from the level/message
(assert (= key2 "level"))
(assert (= value2 (str.++ key2 "=" level_field "," msg_field)))

; Basic sanity: entry and fields non-empty
(assert (> (str.len log_entry) 0))
(assert (> (str.len ts_field) 0))
(assert (> (str.len level_field) 0))

; Level must be one of common log levels
(assert (or (= level_field "INFO") (= level_field "WARN") (= level_field "ERROR") (= level_field "DEBUG")))

; Timestamp must contain at least 4 colon-separated pieces: YYYY-MM-DD:HH:MM:SS
(assert (>= (num_splits ts_field ":") 4))

; Enforce exact timestamp length: "YYYY-MM-DD:HH:MM:SS" = 19
(assert (= (str.len ts_field) 19))

; Validate fixed separators at expected positions: 4 and 7 are '-', 10 is ':', 13 is ':', 16 is ':'
(assert (= (str.at ts_field 4) "-"))
(assert (= (str.at ts_field 7) "-"))
(assert (= (str.at ts_field 10) ":"))
(assert (= (str.at ts_field 13) ":"))
(assert (= (str.at ts_field 16) ":"))

; Validate digits using regex for each chunk
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const min String)
(declare-const sec String)

(assert (= yyyy (split_at ts_field ":" 0)))
(assert (= hh (split_at ts_field ":" 1)))
(assert (= min (split_at ts_field ":" 2)))
(assert (= sec (split_at ts_field ":" 3)))

; yyyy contains "YYYY-MM-DD"; split by '-'
(declare-const year String)
(declare-const month String)
(declare-const day String)
(assert (>= (num_splits yyyy "-") 3))
(assert (= year (split_at yyyy "-" 0)))
(assert (= month (split_at yyyy "-" 1)))
(assert (= day (split_at yyyy "-" 2)))

; Length constraints
(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hh) 2))
(assert (= (str.len min) 2))
(assert (= (str.len sec) 2))

; Regex: all digits for each numeric component
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_2digits () RegLan (re.++ re_digit re_digit))
(define-fun re_4digits () RegLan (re.++ re_digit (re.++ re_digit (re.++ re_digit re_digit))))
(assert (str.in_re year re_4digits))
(assert (str.in_re month re_2digits))
(assert (str.in_re day re_2digits))
(assert (str.in_re hh re_2digits))
(assert (str.in_re min re_2digits))
(assert (str.in_re sec re_2digits))

; Convert some fields to Int for range checks
(declare-const month_i Int)
(declare-const day_i Int)
(declare-const hh_i Int)
(declare-const min_i Int)
(declare-const sec_i Int)
(assert (= month_i (str.to_int month)))
(assert (= day_i (str.to_int day)))
(assert (= hh_i (str.to_int hh)))
(assert (= min_i (str.to_int min)))
(assert (= sec_i (str.to_int sec)))

; Ranges (conservative)
(assert (and (>= month_i 1) (<= month_i 12)))
(assert (and (>= day_i 1) (<= day_i 31)))
(assert (and (>= hh_i 0) (<= hh_i 23)))
(assert (and (>= min_i 0) (<= min_i 59)))
(assert (and (>= sec_i 0) (<= sec_i 59)))

; Mutated seed-like constraints about delimiters and forbidden leading whitespace/newlines
(assert (not (= (str.at log_entry 0) " ")))
(assert (not (= (str.at log_entry 0) "\u{9}")))
(assert (not (= (str.at log_entry 0) "\u{a}")))

; Require the synthetic key/value to contain both '=' and ',' similar to the seed
(assert (not (= (str.indexof value2 "=" 0) (- 1))))
(assert (str.contains value2 ","))

; --- UNSAT core addition (intentional contradiction for diversity) ---
; If level is ERROR then require it to be INFO simultaneously.
(assert (=> (= level_field "ERROR") (= level_field "INFO")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
