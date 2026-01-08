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

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

(declare-const log String)
(declare-const timestamp String)
(declare-const level String)
(declare-const module String)
(declare-const message String)
(declare-const time_part String)
(declare-const date_part String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

(declare-const log_bad String)
(declare-const bad_timestamp String)
(declare-const bad_level String)

; str_split interface

; Core structure: split by spaces and colons
(assert (>= (num_splits log " ") 4))
(assert (= timestamp (split_at log " " 0)))
(assert (= level (split_at log " " 1)))
(assert (= module (split_at log " " 2)))
(assert (= message (split_rest log " " 3)))

; Module is of the form "name:" and message continues after it
(assert (str.suffixof ":" module))

; Timestamp split: "YYYY-MM-DDTHH:MM:SS"
(assert (= 19 (str.len timestamp)))
(assert (= "T" (str.substr timestamp 10 1)))
(assert (= "-" (str.substr timestamp 4 1)))
(assert (= "-" (str.substr timestamp 7 1)))
(assert (= ":" (str.substr timestamp 13 1)))
(assert (= ":" (str.substr timestamp 16 1)))

; Validate timestamp digits via regex
(assert (str.in_re timestamp (re.++
  (re.loop (re.range "0" "9") 4 4)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "T")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2))))

; Extract time part via split_at on 'T' then ':'
(assert (= date_part (split_at timestamp "T" 0)))
(assert (= time_part (split_at timestamp "T" 1)))
(assert (>= (num_splits timestamp "T") 2))
(assert (>= (num_splits time_part ":") 3))
(assert (= hour (split_at time_part ":" 0)))
(assert (= minute (split_at time_part ":" 1)))
(assert (= second (split_at time_part ":" 2)))
(assert (= 2 (str.len hour)))
(assert (= 2 (str.len minute)))
(assert (= 2 (str.len second)))

; Log level extraction: constrain to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message non-empty and should not start with a space (since split_rest uses original spacing)
(assert (>= (str.len message) 1))
(assert (not (= (str.at message 0) " ")))

; Also add a simple seed-mutation-like constraint relating content
; Ensure module (without colon) appears somewhere in message, by requiring module prefix before ':' is contained.
(declare-const module_name String)
(assert (= module_name (str.substr module 0 (- (str.len module) 1))))
(assert (str.contains message module_name))

; Second instance: deliberately UNSAT by contradicting level constraints
(assert (>= (num_splits log_bad " ") 4))
(assert (= bad_timestamp (split_at log_bad " " 0)))
(assert (= bad_level (split_at log_bad " " 1)))
(assert (= bad_level "INFO"))
(assert (= bad_level "ERROR"))

; Still keep timestamp-looking constraints for bad_timestamp
(assert (= 19 (str.len bad_timestamp)))
(assert (str.in_re bad_timestamp (re.++
  (re.loop (re.range "0" "9") 4 4)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "-")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re "T")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2)
  (str.to_re ":")
  (re.loop (re.range "0" "9") 2 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
