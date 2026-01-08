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

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; We model extraction via the provided str_split interface (uninterpreted functions).


(declare-const logline String)
(declare-const timestamp String)
(declare-const level_and_msg String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const yyyy String)
(declare-const mm String)
(declare-const dd String)
(declare-const hh String)
(declare-const mi String)
(declare-const ss String)

; Core structure: first token is timestamp, rest contains LEVEL: message
(assert (= timestamp (split_at logline " " 0)))
(assert (= level_and_msg (split_rest logline " " 1)))
(assert (>= (num_splits logline " ") 2))

; Parse LEVEL:message from the rest (delimiter ":")
(assert (= level (split_at level_and_msg ":" 0)))
(assert (= msg (split_rest level_and_msg ":" 1)))
(assert (>= (num_splits level_and_msg ":") 2))

; Timestamp is of form "YYYY-MM-DDTHH:MM:SS" (19 chars)
(assert (= (str.len timestamp) 19))
(assert (= (str.at timestamp 4) "-"))
(assert (= (str.at timestamp 7) "-"))
(assert (= (str.at timestamp 10) "T"))
(assert (= (str.at timestamp 13) ":"))
(assert (= (str.at timestamp 16) ":"))

; Split timestamp into date and time parts
(assert (= date (split_at timestamp "T" 0)))
(assert (= time (split_at timestamp "T" 1)))
(assert (= (str.len date) 10))
(assert (= (str.len time) 8))

; Split date/time further by '-' and ':'
(assert (= yyyy (split_at date "-" 0)))
(assert (= mm   (split_at date "-" 1)))
(assert (= dd   (split_at date "-" 2)))
(assert (>= (num_splits date "-") 3))

(assert (= hh (split_at time ":" 0)))
(assert (= mi (split_at time ":" 1)))
(assert (= ss (split_at time ":" 2)))
(assert (>= (num_splits time ":") 3))

; Regex validation for numeric fields
(define-fun DIGIT () RegLan (re.range "0" "9"))
(define-fun D2 () RegLan ((_ re.loop 2 2) DIGIT))
(define-fun D4 () RegLan ((_ re.loop 4 4) DIGIT))

(assert (str.in_re yyyy D4))
(assert (str.in_re mm D2))
(assert (str.in_re dd D2))
(assert (str.in_re hh D2))
(assert (str.in_re mi D2))
(assert (str.in_re ss D2))

; Log level extraction: constrain to common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message constraints: non-empty and must not start with a space after colon
(assert (> (str.len msg) 0))
(assert (not (= (str.at msg 0) " ")))

; Preserve seed's core negated regex-style constraint, mutated to fit logline: disallow a specific unrelated pattern.
(assert (not (str.in_re logline (re.++ ((_ re.loop 4 4) (re.union (re.range "A" "Z") (str.to_re "|") (re.range "a" "z"))) (str.to_re "0") ((_ re.loop 6 6) (re.range "0" "9")) (str.to_re "\u{a}")))))

; UNSAT twist: additionally require the log level to be simultaneously INFO and ERROR
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
