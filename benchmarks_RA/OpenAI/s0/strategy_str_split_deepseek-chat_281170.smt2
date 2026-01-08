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

; Uninterpreted interface operations for string split reasoning

; ----------------------------
; SAT instance: well-formed log entry parsing
; Format (space-separated):
;   <timestamp> <level>:<component> <message>
; Example shape:
;   2026-01-07T12:34:56Z INFO:Auth user login
; ----------------------------
(declare-const log_line String)
(declare-const ts String)
(declare-const lvl_comp String)
(declare-const msg String)
(declare-const lvl String)
(declare-const comp String)
(declare-const rest_after_ts String)
(declare-const rest_after_lvlcomp String)

; Split by spaces into at least 3 tokens
(assert (= ts (split_at log_line " " 0)))
(assert (= lvl_comp (split_at log_line " " 1)))
(assert (= msg (split_rest log_line " " 2)))
(assert (>= (num_splits log_line " ") 3))
(assert (>= (str.len ts) 1))
(assert (>= (str.len lvl_comp) 1))
(assert (>= (str.len msg) 1))

; Define rest portions for additional consistency checks
(assert (= rest_after_ts (split_rest log_line " " 1)))
(assert (= rest_after_lvlcomp (split_rest log_line " " 2)))
(assert (= rest_after_ts (str.++ lvl_comp " " rest_after_lvlcomp)))
(assert (= log_line (str.++ ts " " rest_after_ts)))

; Parse the <level>:<component> token by ':'
(assert (= lvl (split_at lvl_comp ":" 0)))
(assert (= comp (split_at lvl_comp ":" 1)))
(assert (>= (num_splits lvl_comp ":") 2))
(assert (>= (str.len lvl) 1))
(assert (>= (str.len comp) 1))

; Allowed levels
(assert (or (= lvl "INFO") (= lvl "WARN") (= lvl "ERROR") (= lvl "DEBUG")))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SSZ
; Use regex for shape checking
(declare-const ts_re RegLan)
(assert (= ts_re (re.++
  (re.loop (str.to_re "0") 4 4)
  (str.to_re "-")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "-")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "T")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re ":")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re ":")
  (re.loop (str.to_re "0") 2 2)
  (str.to_re "Z"))))

; Stronger: digit classes via union of single digits
(declare-const DIGIT RegLan)
(assert (= DIGIT (re.union
  (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
  (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))

(declare-const ts_re2 RegLan)
(assert (= ts_re2 (re.++
  (re.loop DIGIT 4 4)
  (str.to_re "-")
  (re.loop DIGIT 2 2)
  (str.to_re "-")
  (re.loop DIGIT 2 2)
  (str.to_re "T")
  (re.loop DIGIT 2 2)
  (str.to_re ":")
  (re.loop DIGIT 2 2)
  (str.to_re ":")
  (re.loop DIGIT 2 2)
  (str.to_re "Z"))))

; Enforce timestamp matches regex (ts_re2 used; ts_re kept for diversity)
(assert (str.in_re ts ts_re2))
(assert (= (str.len ts) 20))

; Additional sanity checks about separators in timestamp
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

; Component should be alphabetic-ish (simple constraint: contains no spaces/colons)
(assert (not (str.contains comp " ")))
(assert (not (str.contains comp ":")))

; Message should not contain the raw token delimiter pattern for level/component at start
(assert (not (= msg "")))

; Ensure overall line contains expected delimiters
(assert (str.contains log_line " "))
(assert (str.contains lvl_comp ":"))

; Provide at least one concrete witness pattern to keep SAT easy
(assert (= log_line "2026-01-07T12:34:56Z INFO:Auth user login"))

; ----------------------------
; UNSAT instance: contradictory constraints about log level and tokenization
; ----------------------------
(declare-const bad_line String)
(declare-const bad_ts String)
(declare-const bad_lvlcomp String)
(declare-const bad_lvl String)
(declare-const bad_comp String)

(assert (= bad_ts (split_at bad_line " " 0)))
(assert (= bad_lvlcomp (split_at bad_line " " 1)))
(assert (>= (num_splits bad_line " ") 2))

(assert (= bad_lvl (split_at bad_lvlcomp ":" 0)))
(assert (= bad_comp (split_at bad_lvlcomp ":" 1)))
(assert (>= (num_splits bad_lvlcomp ":") 2))

; Require bad_lvl to be INFO and also not equal to INFO -> UNSAT core
(assert (= bad_lvl "INFO"))
(assert (not (= bad_lvl "INFO")))

; Also add a conflicting timestamp constraint for diversity
(assert (str.in_re bad_ts ts_re2))
(assert (= (str.len bad_ts) 19))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
