(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.

; Core log line
(declare-const X String)

; Split interface (uninterpreted as per methodology)
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

; Derived fields
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const rest_after_ts String)
(declare-const lvl_and_msg String)
(declare-const x_contains_forbidden Bool)

; Seed constraint preserved (mutated: still forbids membership in a specific singleton regex)
(assert (not (str.in_re X (str.to_re "DmInf^\u{d}\u{a}\u{d}\u{a}Attached/bar_pl/chk.fcgi\u{a}"))))

; Basic structure: "<timestamp> <level>: <message>"
(assert (>= (num_splits X " ") 3))
(assert (= ts (split_at X " " 0)))
(assert (= level (split_at X " " 1)))
(assert (= rest_after_ts (split_rest X " " 1)))
(assert (= lvl_and_msg (split_rest X " " 1)))

; Expect at least one colon after the level (e.g., "INFO:")
(assert (>= (num_splits lvl_and_msg ":") 2))
(assert (= msg (split_rest lvl_and_msg ":" 1)))

; Timestamp format validation: YYYY-MM-DDThh:mm:ss
(assert (>= (num_splits ts "T") 2))
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))

(assert (= 10 (str.len date)))
(assert (= 8 (str.len time)))
(assert (= "-" (str.at date 4)))
(assert (= "-" (str.at date 7)))
(assert (= ":" (str.at time 2)))
(assert (= ":" (str.at time 5)))

(assert (>= (num_splits date "-") 3))
(assert (= year (split_at date "-" 0)))
(assert (= month (split_at date "-" 1)))
(assert (= day (split_at date "-" 2)))
(assert (= 4 (str.len year)))
(assert (= 2 (str.len month)))
(assert (= 2 (str.len day)))

(assert (>= (num_splits time ":") 3))
(assert (= hour (split_at time ":" 0)))
(assert (= minute (split_at time ":" 1)))
(assert (= second (split_at time ":" 2)))
(assert (= 2 (str.len hour)))
(assert (= 2 (str.len minute)))
(assert (= 2 (str.len second)))

; Allowed levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should not contain a forbidden path fragment (typical log sanitization check)
(assert (= x_contains_forbidden (str.contains X "Attached/bar_pl/chk.fcgi")))
(assert (not x_contains_forbidden))

; ---------------------------
; Additional UNSAT branch to ensure diversity: if level is ERROR then msg must contain "panic",
; but also forbid "panic" globally in the message.
; This makes the whole instance UNSAT when combined with (level="ERROR").
; Force level to ERROR to activate the contradiction.
(assert (= level "ERROR"))
(assert (=> (= level "ERROR") (str.contains msg "panic")))
(assert (not (str.contains msg "panic")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
