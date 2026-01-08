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

; Uninterpreted split interface

; Log line and extracted fields
(declare-const logline String)
(declare-const ts String)          ; timestamp token (first space-separated field)
(declare-const levelTok String)    ; level token like "INFO:"
(declare-const level String)       ; extracted level without trailing ':'
(declare-const msg String)         ; rest of line after first two tokens
(declare-const levelHead String)
(declare-const levelTail String)

; Preserve core structure: keep two negative regex membership constraints (mutated)
(assert (not (str.in_re logline (str.to_re "MyAgentprotocolprotocolHost:/s(robert@blackcastlesoft.com)data2.activshopper.com\u{a}"))))
(assert (not (str.in_re logline (re.++ (str.to_re "//download.asp?p=") (re.range "0" "9") (str.to_re "/Ui\u{a}")))))

; Core split structure: space-separated tokens
(assert (= ts (split_at logline " " 0)))
(assert (= levelTok (split_at logline " " 1)))
(assert (= msg (split_rest logline " " 2)))
(assert (>= (num_splits logline " ") 3))

; Timestamp validation: YYYY-MM-DDTHH:MM:SSZ
; (simplified: fixed length and each position is a digit or a fixed separator)
(assert (= (str.len ts) 20))
(assert (str.in_re (str.at ts 0) (re.range "0" "9")))
(assert (str.in_re (str.at ts 1) (re.range "0" "9")))
(assert (str.in_re (str.at ts 2) (re.range "0" "9")))
(assert (str.in_re (str.at ts 3) (re.range "0" "9")))
(assert (= (str.at ts 4) "-"))
(assert (str.in_re (str.at ts 5) (re.range "0" "9")))
(assert (str.in_re (str.at ts 6) (re.range "0" "9")))
(assert (= (str.at ts 7) "-"))
(assert (str.in_re (str.at ts 8) (re.range "0" "9")))
(assert (str.in_re (str.at ts 9) (re.range "0" "9")))
(assert (= (str.at ts 10) "T"))
(assert (str.in_re (str.at ts 11) (re.range "0" "9")))
(assert (str.in_re (str.at ts 12) (re.range "0" "9")))
(assert (= (str.at ts 13) ":"))
(assert (str.in_re (str.at ts 14) (re.range "0" "9")))
(assert (str.in_re (str.at ts 15) (re.range "0" "9")))
(assert (= (str.at ts 16) ":"))
(assert (str.in_re (str.at ts 17) (re.range "0" "9")))
(assert (str.in_re (str.at ts 18) (re.range "0" "9")))
(assert (= (str.at ts 19) "Z"))

; Log level extraction: token is LEVEL: (colon-terminated)
(assert (= (str.at levelTok (- (str.len levelTok) 1)) ":"))
(assert (= (split_at levelTok ":" 0) level))
(assert (>= (num_splits levelTok ":") 2))

; Level must be one of common severities
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Message should contain a module prefix "mod:" somewhere (colon-separated key)
(assert (str.contains msg "mod:"))

; Additional colon parsing within message: ensure at least one ':' split exists
(assert (>= (num_splits msg ":") 2))

; UNSAT twist: contradict extracted level by forcing it to be both INFO and ERROR
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
