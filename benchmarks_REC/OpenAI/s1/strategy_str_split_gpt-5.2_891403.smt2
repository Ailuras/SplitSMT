(set-logic ALL)

; Scenario: Log Analysis
; Structured server log entries separated by spaces and colons.

; Core seed structure variables
(declare-const x String)
(declare-const y String)
(declare-const m String)
(declare-const n String)

; Log-specific variables
(declare-const log String)
(declare-const ts String)
(declare-const level String)
(declare-const rest String)
(declare-const timepart String)
(declare-const msg String)
(declare-const hourStr String)
(declare-const minStr String)
(declare-const secStr String)
(declare-const payload String)

; Interface: str_split
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

; Preserve core seed structure (mutated context: treat x and y as ts and rest)
(assert (= (str.++ x y) (str.++ m n)))

; Connect seed vars to log fields
(assert (= log (str.++ x y)))
(assert (= ts x))
(assert (= rest y))

; Log entry is: "<timestamp> <LEVEL>: <message>"
(assert (= ts (split_at log " " 0)))
(assert (= payload (split_rest log " " 1)))
(assert (= level (split_at payload ":" 0)))
(assert (= msg (split_rest payload ":" 1)))

; Basic split sanity constraints
(assert (>= (num_splits log " ") 2))
(assert (>= (num_splits payload ":") 2))
(assert (>= (str.len ts) 19))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SS
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))

; Constrain timestamp to digits in appropriate places (regex)
(assert (str.in_re ts
  (re.++
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

; Extract and bound HH, MM, SS using substrings and to_int
(assert (= timepart (str.substr ts 11 8)))
(assert (= hourStr (split_at timepart ":" 0)))
(assert (= minStr (split_at timepart ":" 1)))
(assert (= secStr (split_at timepart ":" 2)))
(assert (= (str.len hourStr) 2))
(assert (= (str.len minStr) 2))
(assert (= (str.len secStr) 2))
(assert (>= (num_splits timepart ":") 3))

(assert (and (>= (str.to_int hourStr) 0) (<= (str.to_int hourStr) 23)))
(assert (and (>= (str.to_int minStr) 0) (<= (str.to_int minStr) 59)))
(assert (and (>= (str.to_int secStr) 0) (<= (str.to_int secStr) 59)))

; Log level extraction checks
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Seed constraint retained but repurposed: constrain trailing part n to match a pattern
(assert (str.in_re n (re.* (str.to_re "a6]_"))))

; Numeric check from seed, anchored to timestamp/year and message length
(assert (= m ts))
(assert (> (str.to_int (str.substr ts 0 4)) (str.len m)))

; Ensure message has at least one character after colon (allow leading space)
(assert (> (str.len msg) 0))

; --- Additional UNSAT branch (disabled by default via guard) ---
; Set this to true to make the instance UNSAT (inconsistent log level vs regex)
(declare-const force_unsat Bool)
(assert (not force_unsat))
(assert (=> force_unsat (and (= level "TRACE") (str.in_re level (str.to_re "INFO")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
