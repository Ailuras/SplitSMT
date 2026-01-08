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

; --- seed-core declarations (kept / extended) ---
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

; --- log-specific declarations ---
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const timepart String)
(declare-const y String)
(declare-const mo String)
(declare-const da String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const host String)
(declare-const kvpair String)
(declare-const key String)
(declare-const val String)

; --- seed core structure: a large regex membership with loop, and result concatenation ---
(assert (str.in_re attack (re.++ prefix ((_ re.loop 5000 5000) infix) postfix)))

; Mutated prefix to resemble a log header fragment: "x86_64 " then "1" digit "1" digit
(assert (= prefix
  (re.++
    (str.to_re "x")
    (re.++ (str.to_re "8")
    (re.++ (str.to_re "6")
    (re.++ (str.to_re "_")
    (re.++ (str.to_re "6")
    (re.++ (str.to_re "4")
    (re.++ (str.to_re " ")
    (re.++ (str.to_re "1")
    (re.++ (re.range "0" "9")
          (re.++ (str.to_re "1") (re.range "0" "9")))))))))))))

; Keep infix as intersection of digit+ and any tail, but tighten to ensure at least one digit then arbitrary chars
(assert (= infix
  (re.inter
    (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar))
    (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar)))))

; Postfix is '@' per seed; keep and also require postfixs is exactly "@" (mutated from length>=1)
(assert (= postfix (str.to_re "@")))
(assert (str.in_re postfixs postfix))
(assert (= postfixs "@"))

(assert (= result (str.++ attack postfixs)))

; --- Build a structured logline from result and additional fields ---
; logline = "<ts> <level>: <message> <result>"
(assert (= logline (str.++ ts (str.++ " " (str.++ level (str.++ ": " (str.++ message (str.++ " " result))))))))

; Ensure basic splitting expectations: " " separators and ":" delimiter usage
(assert (>= (num_splits logline " ") 5))
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_at logline " " 2)))

; Parse "level:" by splitting message at ':' for an additional check; require message contains ':'
(assert (str.contains (str.++ level ":") ":"))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SSZ
(assert (= timepart ts))
(assert (= (str.len timepart) 20))
(assert (= (str.at timepart 4) "-"))
(assert (= (str.at timepart 7) "-"))
(assert (= (str.at timepart 10) "T"))
(assert (= (str.at timepart 13) ":"))
(assert (= (str.at timepart 16) ":"))
(assert (= (str.at timepart 19) "Z"))

; Extract components via substrings
(assert (= y  (str.substr timepart 0 4)))
(assert (= mo (str.substr timepart 5 2)))
(assert (= da (str.substr timepart 8 2)))
(assert (= hh (str.substr timepart 11 2)))
(assert (= mm (str.substr timepart 14 2)))
(assert (= ss (str.substr timepart 17 2)))

; Component regex constraints
(assert (str.in_re y  (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mo (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re da (re.++ (re.range "0" "3") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction constraints (allow INFO|WARN|ERROR)
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Additional parsing: message expected like "host:xyz"; split at ':'
(assert (str.contains message ":"))
(assert (= host (split_at message ":" 0)))
(assert (= kvpair (split_at message ":" 1)))
(assert (= host "host"))
(assert (>= (str.len kvpair) 1))

; Include a key=value pair after host value, e.g., "<val> key=..." in the rest
(assert (>= (num_splits (split_rest logline " " 3) "=") 2))
(assert (= key (split_at (split_rest logline " " 3) "=" 0)))
(assert (= val (split_at (split_rest logline " " 3) "=" 1)))

; --- UNSAT toggle via contradictory constraints (kept as part of file diversity) ---
; Force both INFO and ERROR simultaneously (impossible)
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
