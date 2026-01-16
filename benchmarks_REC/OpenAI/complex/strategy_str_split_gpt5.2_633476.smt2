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
; Key checks include timestamp format validation and log level extraction.

; --- str_split interface (uninterpreted) ---

; --- Variables ---
(declare-const log_line String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const message String)
(declare-const msg_tail String)

(declare-const k Int)

; --- Core structure: split by spaces, then split component: by ':' ---
(assert (= ts (split_at log_line " " 0)))
(assert (= level (split_at log_line " " 1)))
(assert (= component (split_at log_line " " 2)))
(assert (= msg_tail (split_rest log_line " " 3)))

(assert (>= (num_splits log_line " ") 4))
(assert (>= k 0))
(assert (<= k (str.len log_line)))

; component is like "service:" (trailing colon)
(assert (str.suffixof ":" component))
(assert (>= (num_splits component ":") 2))
(assert (= "" (split_at component ":" 1)))

; message is remainder; require non-empty, no leading spaces
(assert (= message msg_tail))
(assert (> (str.len message) 0))
(assert (not (str.prefixof " " message)))

; --- Timestamp format validation (mutated from seed) ---
; Accept: YYYY-MM-DDTHH:MM:SS or YYYY/MM/DD HH:MM:SS
(assert (str.in_re ts
  (re.++
    (str.to_re "20")
    ((_ re.loop 2 2) (re.range "0" "9"))
    (re.union (str.to_re "-") (str.to_re "/"))
    (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (str.to_re "1") (re.range "0" "2")))
    (re.union (str.to_re "-") (str.to_re "/"))
    (re.union (re.++ (str.to_re "0") (re.range "1" "9")) (re.++ (re.range "1" "2") (re.range "0" "9")) (re.++ (str.to_re "3") (re.range "0" "1")))
    (re.union (str.to_re "T") (str.to_re " "))
    (re.union (re.++ (re.range "0" "1") (re.range "0" "9")) (re.++ (str.to_re "2") (re.range "0" "3")))
    (str.to_re ":")
    (re.range "0" "5") (re.range "0" "9")
    (str.to_re ":")
    (re.range "0" "5") (re.range "0" "9")
  )
))

; Additional timestamp checks: fixed length 19, and no timezone suffix
(assert (= (str.len ts) 19))
(assert (not (str.contains ts "Z")))
(assert (not (str.contains ts "+")))

; --- Log level extraction and validation ---
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Ensure level token is exactly one of them (no brackets)
(assert (not (str.contains level "[")))
(assert (not (str.contains level "]")))

; --- Message constraints (basic log analysis properties) ---
; Must not contain newline, but may contain colons
(assert (not (str.contains message "\n")))
(assert (not (str.contains message "\r")))

; If level is ERROR then message must mention a keyword
(assert (=> (= level "ERROR") (str.contains message "exception")))

; --- Include an UNSAT branch to ensure diversity ---
; Contradiction: if level is DEBUG then it must be exactly "INFO".
(assert (=> (= level "DEBUG") (= level "INFO")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
