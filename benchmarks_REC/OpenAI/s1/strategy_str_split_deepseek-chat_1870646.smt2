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
; Parsing a structured server log entry: "YYYY-MM-DD HH:MM:SS LEVEL: message"

; Uninterpreted str_split interface

; Log entry and extracted fields
(declare-const log String)
(declare-const date String)
(declare-const time String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const message String)

; Auxiliary substrings for timestamp validation
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Split by spaces: date time LEVEL: message...
(assert (= date (split_at log " " 0)))
(assert (= time (split_at log " " 1)))
(assert (= level_with_colon (split_at log " " 2)))
(assert (= message (split_rest log " " 3)))
(assert (>= (num_splits log " ") 4))

; Split LEVEL: by colon to extract level
(assert (= level (split_at level_with_colon ":" 0)))
(assert (= "" (split_at level_with_colon ":" 1)))
(assert (= 2 (num_splits level_with_colon ":")))

; Timestamp format checks (structural, via lengths and fixed separators)
(assert (= 10 (str.len date)))
(assert (= "-" (str.at date 4)))
(assert (= "-" (str.at date 7)))
(assert (= yyyy (str.substr date 0 4)))
(assert (= mm   (str.substr date 5 2)))
(assert (= dd   (str.substr date 8 2)))

(assert (= 8 (str.len time)))
(assert (= ":" (str.at time 2)))
(assert (= ":" (str.at time 5)))
(assert (= hh (str.substr time 0 2)))
(assert (= mi (str.substr time 3 2)))
(assert (= ss (str.substr time 6 2)))

; Regex digit constraints for each numeric component
(define-fun Digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun TwoDigits () RegLan (re.++ Digit Digit))
(define-fun FourDigits () RegLan (re.++ TwoDigits TwoDigits))

(assert (str.in_re yyyy FourDigits))
(assert (str.in_re mm TwoDigits))
(assert (str.in_re dd TwoDigits))
(assert (str.in_re hh TwoDigits))
(assert (str.in_re mi TwoDigits))
(assert (str.in_re ss TwoDigits))

; Numeric range sanity checks
(assert (and (>= (str.to_int mm) 1) (<= (str.to_int mm) 12)))
(assert (and (>= (str.to_int dd) 1) (<= (str.to_int dd) 31)))
(assert (and (>= (str.to_int hh) 0) (<= (str.to_int hh) 23)))
(assert (and (>= (str.to_int mi) 0) (<= (str.to_int mi) 59)))
(assert (and (>= (str.to_int ss) 0) (<= (str.to_int ss) 59)))

; Log level extraction and validation
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))
(assert (>= (str.len message) 1))

; Keep a mutated core-style constraint from the seed: force a contradiction via x
(declare-const x String)
(assert (str.in_re x (re.+ (re.union (str.to_re "") (str.to_re "4")))))
(assert (= 2 (str.to_int x)))

; Force the log's year to be "4444" to tie in digit/seed flavor
(assert (= yyyy "4444"))

; UNSAT twist: enforce an impossible month while still requiring TwoDigits
(assert (= mm "00"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
