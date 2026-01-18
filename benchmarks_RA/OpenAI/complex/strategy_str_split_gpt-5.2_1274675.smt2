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

; Uninterpreted interface for str_split

; Log analysis variables
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const datepart String)
(declare-const timepart String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const kvpart String)
(declare-const key1 String)
(declare-const val1 String)

; Preserve seed-like structure with regex constraints (mutated)
(declare-const x String)
(declare-const y String)
(assert (str.in_re x (re.* (re.++ (str.to_re "b") (re.* (str.to_re "a"))))))
(assert (str.in_re y (re.* (re.++ (str.to_re "b") (str.to_re "a")))))

; Core structure: parse structured server log entry separated by spaces
; Expected shape: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp format validation via splitting on '-' and ':'
(assert (= datepart (split_at ts " " 0)))
(assert (= timepart (split_at ts " " 1)))
(assert (= year (split_at datepart "-" 0)))
(assert (= month (split_at datepart "-" 1)))
(assert (= day (split_at datepart "-" 2)))
(assert (= hour (split_at timepart ":" 0)))
(assert (= minute (split_at timepart ":" 1)))
(assert (= second (split_at timepart ":" 2)))
(assert (= (num_splits datepart "-") 3))
(assert (= (num_splits timepart ":") 3))

; Regex helpers
(define-fun digit () RegLan (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9")))))))))))
(define-fun two_digits () RegLan (re.++ digit digit))
(define-fun four_digits () RegLan (re.++ digit (re.++ digit (re.++ digit digit))))

; Enforce exact numeric widths
(assert (str.in_re year four_digits))
(assert (str.in_re month two_digits))
(assert (str.in_re day two_digits))
(assert (str.in_re hour two_digits))
(assert (str.in_re minute two_digits))
(assert (str.in_re second two_digits))

; Level extraction: LEVEL must end with ':' and be one of INFO/WARN/ERROR/DEBUG
(assert (or (= level "INFO:") (= level "WARN:") (= level "ERROR:") (= level "DEBUG:")))

; Message must be non-empty and contain a key-value pair token separated by '=' somewhere
(assert (> (str.len message) 0))
(assert (str.contains message "="))

; Parse first key-value token from message by splitting on space, then '='
(assert (= kvpart (split_at message " " 0)))
(assert (= key1 (split_at kvpart "=" 0)))
(assert (= val1 (split_at kvpart "=" 1)))
(assert (>= (num_splits kvpart "=") 2))

; Key must be alphabetic-ish (simple over-approx): starts with 'b' then any number of 'a' (seed-themed)
(assert (str.in_re key1 (re.++ (str.to_re "b") (re.* (str.to_re "a")))))

; SAT branch constraints
  ; Concrete exemplifying constraints to ensure satisfiable instance exists
  (assert (= year "2024"))
  (assert (= month "01"))
  (assert (= day "09"))
  (assert (= hour "13"))
  (assert (= minute "37"))
  (assert (= second "42"))
  (assert (= level "INFO:"))
  (assert (= key1 "baaa"))
  (assert (= val1 "ok"))
  ; Tie together a consistent logline (not enforcing exact reconstruction due to uninterpreted split)
  (assert (>= (str.len logline) 10))
(check-sat)
(exit)
