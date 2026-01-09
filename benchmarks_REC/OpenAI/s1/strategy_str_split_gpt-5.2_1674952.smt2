(set-logic ALL)

; Log Analysis scenario: structured server log entries separated by spaces and colons

; Uninterpreted split interface
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

; Core variables
(declare-const X String)
(declare-const ts String)
(declare-const lvl String)
(declare-const hostField String)
(declare-const msg String)
(declare-const tDate String)
(declare-const tTime String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; Preserve seed structure: keep characteristic membership constraints but adapt to log-analysis theme
(assert (not (str.in_re X (str.to_re "Host:toUser-Agent:ClientsConnected-\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "log={IP:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Pcast") (re.+ (re.range "0" "9")) (str.to_re "Host:ohgdhkzfhdzo/uwpOK\u{d}\u{a}Host:HWAEname.cnnic.cnRXnewads1.com\u{a}")))))

; Require X to contain a plausible log prefix with timestamp and level
(assert (str.contains X " "))
(assert (>= (num_splits X " ") 4))
(assert (= ts (split_at X " " 0)))
(assert (= lvl (split_at X " " 1)))
(assert (= hostField (split_at X " " 2)))
(assert (= msg (split_rest X " " 3)))

; Timestamp expected format: YYYY-MM-DDTHH:MM:SS
(assert (>= (num_splits ts "T") 2))
(assert (= tDate (split_at ts "T" 0)))
(assert (= tTime (split_at ts "T" 1)))

(assert (>= (num_splits tDate "-") 3))
(assert (= year (split_at tDate "-" 0)))
(assert (= month (split_at tDate "-" 1)))
(assert (= day (split_at tDate "-" 2)))

(assert (>= (num_splits tTime ":") 3))
(assert (= hour (split_at tTime ":" 0)))
(assert (= minute (split_at tTime ":" 1)))
(assert (= second (split_at tTime ":" 2)))

; Regex helpers for digits
(define-fun reDigit () RegLan (re.range "0" "9"))
(define-fun re2Digits () RegLan (re.++ reDigit reDigit))
(define-fun re4Digits () RegLan (re.++ re2Digits re2Digits))

; Timestamp components validation
(assert (str.in_re year re4Digits))
(assert (str.in_re month re2Digits))
(assert (str.in_re day re2Digits))
(assert (str.in_re hour re2Digits))
(assert (str.in_re minute re2Digits))
(assert (str.in_re second re2Digits))

; Accept only common log levels
(assert (str.in_re lvl (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Structured host field: "host:<token>"
(assert (str.in_re hostField (re.++ (str.to_re "host:") (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "-"))))))))

; Message must mention a key/value with colon to exercise parsing-by-colon scenario
(assert (str.contains msg ":"))

; UNSAT instance: force X to be exactly a long seed-like string that cannot satisfy the required timestamp prefix
(assert (str.in_re X (str.to_re "From:X-Mailer:\u{13}backtrust.comReferer:Supremewjpropqmlpohj/loLogsX-FILTERED-BY-GHOST:\u{a}")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
