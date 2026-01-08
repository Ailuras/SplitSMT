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

; Uninterpreted interface for string split constraints

; Seed variables retained
(declare-const var_7 String)
(declare-const var_8 String)

; Log analysis specific variables
(declare-const log_entry String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const date_part String)
(declare-const time_part String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const rest_after_level String)
(declare-const host String)

; --- Mutated/extended seed core constraints ---
(assert (str.in_re (str.++ var_7 "z" var_8)
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                           (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))
(assert (str.in_re var_8 (re.* (re.range "a" "u"))))
(assert (str.in_re var_7 (re.* (re.range "a" "u"))))
(assert (<= 0 (str.len var_8)))

; Connect seed vars into the log entry to preserve core structure while changing scenario
; Use var_7 and var_8 as a constrained "host" token appearing later in the log.
(assert (= host (str.++ var_7 "z" var_8)))

; --- Log parsing via split operations ---
; Expected format (space-separated tokens):
;   <timestamp> <level>: <message> host=<host>
(assert (= ts (split_at log_entry " " 0)))
(assert (= level (split_at log_entry " " 1)))
(assert (= rest_after_level (split_rest log_entry " " 2)))
(assert (>= (num_splits log_entry " ") 3))

; level token ends with ':' and is one of INFO/WARN/ERROR/DEBUG
(assert (str.in_re level (re.union (str.to_re "INFO:")
                           (re.union (str.to_re "WARN:")
                           (re.union (str.to_re "ERROR:")
                                    (str.to_re "DEBUG:"))))))

; message is the rest after the first two tokens
(assert (= message rest_after_level))
(assert (>= (str.len message) 1))

; Require that the message contains the host marker and that it uses the seed-derived host
(assert (str.contains message "host="))
(assert (str.contains message (str.++ "host=" host)))

; --- Timestamp format validation ---
; Timestamp expected: YYYY-MM-DD:HH:MM:SS
(assert (= date_part (split_at ts ":" 0)))
(assert (= time_part (split_rest ts ":" 1)))
(assert (= year (split_at date_part "-" 0)))
(assert (= month (split_at date_part "-" 1)))
(assert (= day (split_at date_part "-" 2)))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))

(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; Digits-only constraints for timestamp components
(assert (str.in_re year (re.++ (re.range "0" "9")
                               (re.++ (re.range "0" "9")
                                      (re.++ (re.range "0" "9")
                                             (re.range "0" "9"))))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; Colons check: exactly 3 segments when splitting timestamp by ':'
(assert (= (num_splits ts ":") 4))

; Additional sanity: timestamp must not contain spaces
(assert (not (str.contains ts " ")))

; --- Create an UNSAT core by contradicting timestamp delimiter expectations ---
; If date_part is derived by splitting on ':', it must not itself contain ':'
(assert (not (str.contains date_part ":")))
; Contradiction: force date_part to contain ':'
(assert (str.contains date_part ":"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
