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
; Scenario: Email Validation using '@' and '.' delimiters with str_split interface

; Uninterpreted functions for split reasoning

; Primary input email
(declare-const email String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const label0 String)
(declare-const label1 String)
(declare-const tld String)

; Basic split structure for email
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 1) domain))

; Exactly one '@' -> two segments
(assert (= (num_splits email "@") 2))

; Non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Disallow leading/trailing dots in local and domain
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Local-part regex: allow alnum plus '._%+-' but no spaces
(assert (str.in_re local (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))
(assert (not (str.contains local " ")))

; Domain structure via '.' split
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Require at least one dot in domain (>= 2 labels)
(assert (>= (num_splits domain ".") 2))

; Labels must be non-empty
(assert (> (str.len label0) 0))
(assert (> (str.len tld) 0))

; Domain label regex: allow alnum and hyphen, but no underscores
(assert (str.in_re label0 (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (str.in_re label1 (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (str.contains domain "_")))

; Hyphen cannot be at start/end of first label and TLD
(assert (not (= (str.at label0 0) "-")))
(assert (not (= (str.at label0 (- (str.len label0) 1)) "-")))
(assert (not (= (str.at tld 0) "-")))
(assert (not (= (str.at tld (- (str.len tld) 1)) "-")))

; TLD: 2..24 alphabetic characters
(assert (str.in_re tld ((_ re.loop 2 24) (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Forbid consecutive dots in the domain
(assert (not (str.contains domain "..")))

; Optional additional guard: email must not contain newline characters
(assert (not (str.contains email "\n")))
(assert (not (str.contains email "\r")))

; Produce UNSAT by forcing an invalid domain structure simultaneously
; (Contradiction: require at least one dot, but also forbid any dot)
(assert (not (str.contains domain ".")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
