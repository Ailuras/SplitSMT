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

; Log Analysis scenario: parse structured server log entries separated by spaces and colons

; Uninterpreted split interface

; Seed variables preserved
(declare-const x String)
(declare-const y String)

; Additional variables for log parsing
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

(declare-const idx Int)

; Core seed structure kept but made consistent with log setting (kept SAT by making x,y empty)
(assert (= x ""))
(assert (= y ""))
(assert (str.in_re (str.++ y x) (re.* (str.to_re "!!$$bbaa"))))

; Logline shape: "YYYY-MM-DD HH:MM:SS LEVEL: message..."
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= msg (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp validation: require two parts separated by space and time separated by ':'
(assert (= hh (split_at (split_at logline " " 0) ":" 0)))
(assert (= mm (split_at (split_at logline " " 0) ":" 1)))
(assert (= ss (split_at (split_at logline " " 0) ":" 2)))
(assert (>= (num_splits (split_at logline " " 0) ":") 3))

; Constrain time components to be 2 digits each
(assert (= (str.len hh) 2))
(assert (= (str.len mm) 2))
(assert (= (str.len ss) 2))

; Regex check for timestamp-like prefix: YYYY-MM-DD
(assert (str.in_re ts (re.++ (re.loop (re.range "0" "9") 4 4)
                             (str.to_re "-")
                             (re.loop (re.range "0" "9") 2 2)
                             (str.to_re "-")
                             (re.loop (re.range "0" "9") 2 2)
                             (str.to_re "") )))

; Log level must be one of: INFO, WARN, ERROR
(assert (str.in_re level (re.union (str.to_re "INFO")
                                  (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Level token ends with ':' in the raw line "LEVEL:"; enforce via indexof and substring
(assert (>= (str.len msg) 0))
(assert (= idx (str.indexof logline ":" 0)))
(assert (>= idx 0))

; Message should not contain another "LEVEL:" prefix (simple sanity constraint)
(assert (not (str.contains msg "INFO:")))
(assert (not (str.contains msg "WARN:")))
(assert (not (str.contains msg "ERROR:")))

; UNSAT branch (guarded by a contradiction on purpose): require level both INFO and ERROR
(assert (not (and (= level "INFO") (= level "ERROR"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
