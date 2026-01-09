(set-logic ALL)

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

; Primary email inputs
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domainLabel0 String)
(declare-const domainLabel1 String)
(declare-const domainLabel2 String)
(declare-const tld String)
(declare-const reconstructedDomain String)
(declare-const userChar0 String)
(declare-const userCharLast String)

; -------------------------
; SAT instance: complex email validation constraints
; -------------------------

; Email must contain exactly one '@' => 2 segments when split by '@'
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; A lightweight structural check on local-part boundary characters
(assert (= userChar0 (str.at local 0)))
(assert (not (= userChar0 ".")))
(assert (= userCharLast (str.at local (- (str.len local) 1))))
(assert (not (= userCharLast ".")))

; Domain constraints: contains at least one dot (>= 2 labels)
(assert (>= (num_splits domain ".") 2))

; Enforce at least 3 labels in domain: e.g., mail.example.com
(assert (>= (num_splits domain ".") 3))
(assert (= domainLabel0 (split_at domain "." 0)))
(assert (= domainLabel1 (split_at domain "." 1)))
(assert (= domainLabel2 (split_at domain "." 2)))
(assert (= tld (split_rest domain "." 3)))

; Each of first 3 domain labels must be non-empty and must not contain '@' or spaces
(assert (>= (str.len domainLabel0) 1))
(assert (>= (str.len domainLabel1) 1))
(assert (>= (str.len domainLabel2) 1))
(assert (not (str.contains domainLabel0 "@")))
(assert (not (str.contains domainLabel1 "@")))
(assert (not (str.contains domainLabel2 "@")))
(assert (not (str.contains domainLabel0 " ")))
(assert (not (str.contains domainLabel1 " ")))
(assert (not (str.contains domainLabel2 " ")))

; Domain label boundary constraints: labels cannot start or end with '-'
(assert (not (= (str.at domainLabel0 0) "-")))
(assert (not (= (str.at domainLabel1 0) "-")))
(assert (not (= (str.at domainLabel2 0) "-")))
(assert (not (= (str.at domainLabel0 (- (str.len domainLabel0) 1)) "-")))
(assert (not (= (str.at domainLabel1 (- (str.len domainLabel1) 1)) "-")))
(assert (not (= (str.at domainLabel2 (- (str.len domainLabel2) 1)) "-")))

; TLD constraints: non-empty, at least 2 chars, contains no dots (since it is split_rest from 3)
(assert (>= (str.len tld) 2))
(assert (not (str.contains tld "@")))
(assert (not (str.contains tld " ")))

; Reconstruct domain in a canonical way: first three labels plus rest (tld may include additional dots)
(assert (= reconstructedDomain (str.++ domainLabel0 "." domainLabel1 "." domainLabel2 (ite (= tld "") "" (str.++ "." tld)))))
(assert (str.contains reconstructedDomain domainLabel0))

; Provide a concrete satisfiable example while still respecting the structure
(assert (= email "alice.smith+tag@dept.mail.example.co.uk"))

(check-sat)

; -------------------------
; UNSAT instance: contradictory email/domain constraints (same declarations reused)
; -------------------------


; Force exactly one '@'
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Contradiction: also require zero '@' occurrences
(assert (not (str.contains email "@")))

(check-sat)
(exit)
