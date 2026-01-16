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

; Uninterpreted split interface

; Seed variables (preserve core structure)
(declare-fun T_1 () Bool)
(declare-fun var_0xINPUT_101935 () String)

; Additional variables for log analysis
(declare-const logline String)
(declare-const timestamp String)
(declare-const level String)
(declare-const component_and_message String)
(declare-const component_field String)
(declare-const msg_field String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const hour_str String)
(declare-const min_str String)
(declare-const sec_str String)
(declare-const component_name String)
(declare-const message String)

; Core seed constraint: input must be non-empty
(assert (= T_1 (not (= "" var_0xINPUT_101935))))
(assert T_1)

; Tie seed input to the log line under analysis
(assert (= logline var_0xINPUT_101935))

; Log structure: "<timestamp> <level> <component>: <message>"
(assert (= timestamp (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= component_and_message (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 4))

; Component/message separated by ": "
(assert (>= (num_splits component_and_message ": ") 2))
(assert (= component_field (split_at component_and_message ": " 0)))
(assert (= msg_field (split_rest component_and_message ": " 1)))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SS"
(assert (>= (str.len timestamp) 19))
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

(assert (= date_part (str.substr timestamp 0 10)))
(assert (= time_part (str.substr timestamp 11 8)))

; Date digits: YYYY-MM-DD
(assert (str.in_re (str.substr date_part 0 4) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 5 2) (re.+ (re.range "0" "9"))))
(assert (str.in_re (str.substr date_part 8 2) (re.+ (re.range "0" "9"))))

; Time digits: HH:MM:SS
(assert (= hour_str (str.substr time_part 0 2)))
(assert (= min_str (str.substr time_part 3 2)))
(assert (= sec_str (str.substr time_part 6 2)))
(assert (str.in_re hour_str (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re min_str (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re sec_str (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction and allowed set
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Component must be non-empty and contain only letters, digits, underscore, hyphen
(assert (not (= component_field "")))
(assert (str.in_re component_field (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "_") (str.to_re "-"))))))))

; Message must be non-empty
(assert (not (= msg_field "")))

; Additional parsing: component_field may be like "svc/module"; split at "/" to get component_name
(assert (= component_name (split_at component_field "/" 0)))
(assert (>= (num_splits component_field "/") 1))

; Ensure overall logline contains the level token somewhere after first space
(assert (str.contains (split_rest logline " " 1) level))

; Make it satisfiable by providing one concrete example logline
(assert (= logline "2026-01-09T12:34:56 INFO auth_service: user login ok"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
