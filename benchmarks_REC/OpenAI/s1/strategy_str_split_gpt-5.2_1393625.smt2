(set-logic ALL)

; Uninterpreted interface for str_split
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

; Log line and extracted fields
(declare-const x String)
(declare-const ts String)
(declare-const level String)
(declare-const host String)
(declare-const kv1 String)
(declare-const kv2 String)
(declare-const msg String)
(declare-const hhmmss String)

; Core structure from seed: preserve regex-based boolean equalities/inequalities
(assert (let ((_let_0 (re.* re.allchar )))
  (let ((_let_1 (str.++ "C" "A")))
    (let ((_let_2 (str.to_re "A")))
      (let ((_let_3 (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "A")) _let_0 (str.to_re _let_1) _let_0))))
        (and
          (not (= (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "A" "C"))) _let_0 _let_2 _let_0)) _let_3))
          (not (= _let_3 (str.in_re x (re.++ _let_0 re.allchar _let_0 _let_2 _let_0 (str.to_re (str.++ "A" _let_1)) _let_0))))
        ))))))

; Log analysis scenario: parsing structured server log entries separated by spaces and colons
; Expected shape (one possible): "YYYY-MM-DDTHH:MM:SSZ LEVEL host: kv1 kv2 message..."

; Split by spaces
(assert (>= (num_splits x " ") 5))
(assert (= ts (split_at x " " 0)))
(assert (= level (split_at x " " 1)))
(assert (= host (split_at x " " 2)))
(assert (= kv1 (split_at x " " 3)))
(assert (= kv2 (split_at x " " 4)))
(assert (= msg (split_rest x " " 5)))

; Host ends with ':' to indicate structured prefix like "web01:" before key-values
(assert (str.in_re host (re.++ (re.+ (re.range "a" "z")) (str.to_re ":"))))

; Log level extraction: one of common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SSZ"
(declare-const DIGIT RegLan)
(assert (= DIGIT (re.range "0" "9")))
(declare-const D2 RegLan)
(declare-const D4 RegLan)
(assert (= D2 (re.++ DIGIT DIGIT)))
(assert (= D4 (re.++ D2 D2)))
(assert (str.in_re ts (re.++ D4 (str.to_re "-") D2 (str.to_re "-") D2 (str.to_re "T") D2 (str.to_re ":") D2 (str.to_re ":") D2 (str.to_re "Z"))))

; Further sanity: extract HH:MM:SS from timestamp via substring and validate colons positions
(assert (= hhmmss (str.substr ts 11 8)))
(assert (= (str.at hhmmss 2) ":"))
(assert (= (str.at hhmmss 5) ":"))

; Key-value tokens must contain a colon somewhere (e.g., "pid:123")
(assert (str.contains kv1 ":"))
(assert (str.contains kv2 ":"))

; Message should be non-empty if present
(assert (>= (str.len msg) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
