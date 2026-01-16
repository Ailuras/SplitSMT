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

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Uninterpreted split interface

; Core input log line
(declare-const X String)

; Derived fields via space splitting
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)

(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= component (split_at X " " 2)))
(assert (= message (split_rest X " " 3)))

; Must have at least: <timestamp> <LEVEL> <component> <message...>
(assert (>= (num_splits X " ") 4))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
(assert (str.in_re ts
  (re.++
    ((_ re.loop 4 4) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "-")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re "T")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (str.to_re ":")
    ((_ re.loop 2 2) (re.range "0" "9")))))

; Additional sanity checks using colon splitting over timestamp
(declare-const ts_date String)
(declare-const ts_time String)
(assert (= ts_date (split_at ts "T" 0)))
(assert (= ts_time (split_at ts "T" 1)))
(assert (= 2 (num_splits ts "T")))
(assert (= 3 (num_splits ts_time ":")))

; Log level extraction constraints
(assert (str.in_re level (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; Component format: letters/digits/underscore, length >= 3
(assert (>= (str.len component) 3))
(assert (str.in_re component (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_")))))

; Message must contain a key:value pair like "user:..." somewhere
(assert (str.contains message "user:"))

; Preserve some structural flavor from the seed via unrelated regex constraints,
; but adapted to be log-like and not HTML.
(assert (not (str.contains X "<img ")))
(assert (not (str.in_re X (re.++ (str.to_re "//{#") (re.+ (re.union (str.to_re "/") (str.to_re "{") (str.to_re "}"))) (str.to_re "}") (re.opt (str.to_re ".action")) (re.opt (str.to_re "/")) (str.to_re "/miU\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "//") ((_ re.loop 42 42) (re.union (re.range "0" "9") (re.range "A" "F"))) (str.to_re "/Um\u{a}")))))

; SAT instance: require message to contain a request id field, but do not overconstrain it.
(assert (str.contains message "req_id:"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
