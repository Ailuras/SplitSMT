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

; Email validation scenario using split constraints over '@' and '.' delimiters

; --- str_split interface (uninterpreted) ---

; ----------------------
; SAT instance: complex but valid email
; ----------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const rest_from_1_sat String)
(declare-const dot_count_sat Int)

(assert (= email_sat "john.doe+tag_123@sub.mail.example.co.uk"))

; exactly one '@' meaning 2 segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; local-part basic structure constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "."))

; domain structure: must have at least one dot and at least 2 labels
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_first_sat (split_at domain_sat "." 0)))
(assert (>= (str.len domain_first_sat) 1))

; top-level domain (last label) length >= 2
(assert (= dot_count_sat (num_splits domain_sat ".")))
(assert (>= dot_count_sat 2))
(assert (= tld_sat (split_at domain_sat "." (- dot_count_sat 1))))
(assert (>= (str.len tld_sat) 2))

; split_rest sanity: from index 1 onward equals suffix after first label
(assert (= rest_from_1_sat (split_rest domain_sat "." 1)))
(assert (>= (str.len rest_from_1_sat) 1))

; extra: no consecutive dots in domain (approximate via excluding "..")
(assert (not (str.contains domain_sat "..")))

; ----------------------
; UNSAT instance: contradictory email requirements
; ----------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dot_count_unsat Int)

(assert (= email_unsat "alice@example.com"))

; force exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; require domain to have at least one dot
(assert (>= (num_splits domain_unsat ".") 2))

; but also (contradiction) require domain to have no dots
(assert (not (str.contains domain_unsat ".")))

; additionally contradict tld length: must be >= 2 and = 1 simultaneously
(assert (= dot_count_unsat (num_splits domain_unsat ".")))
(assert (>= dot_count_unsat 2))
(assert (= tld_unsat (split_at domain_unsat "." (- dot_count_unsat 1))))
(assert (>= (str.len tld_unsat) 2))
(assert (= (str.len tld_unsat) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
