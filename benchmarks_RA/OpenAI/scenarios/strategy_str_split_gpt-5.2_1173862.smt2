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

; Email Validation using str_split-like interface

; Uninterpreted split interface

; -------------------------
; SAT instance: a valid-looking email with structural constraints
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_full_sat String)
(declare-const domain_head_sat String)
(declare-const tld_sat String)
(declare-const domain_rest_from1_sat String)
(declare-const domain_dots_sat Int)

; Ensure exactly one '@' => two segments when splitting by '@'
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_full_sat (split_at email_sat "@" 1)))

; Local part constraints: non-empty, no '@'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat "@")))

; Domain must contain at least one '.' => at least two segments when splitting by '.'
(assert (>= (num_splits domain_full_sat ".") 2))
(assert (= domain_head_sat (split_at domain_full_sat "." 0)))
(assert (= tld_sat (split_at domain_full_sat "." (- (num_splits domain_full_sat ".") 1))))
(assert (= domain_rest_from1_sat (split_rest domain_full_sat "." 1)))

; Head label constraints: non-empty and no '.'
(assert (> (str.len domain_head_sat) 0))
(assert (not (str.contains domain_head_sat ".")))

; TLD constraints: length 2..10, no '.'
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 10))
(assert (not (str.contains tld_sat ".")))

; Domain tail (everything after first dot) should be non-empty and contain no '@'
(assert (> (str.len domain_rest_from1_sat) 0))
(assert (not (str.contains domain_full_sat "@")))

; Provide a concrete witness to ensure satisfiable
(assert (= email_sat "alice.smith@sub.example.co"))

; Add a small arithmetic constraint connected to structure (kept consistent)
(assert (= domain_dots_sat (- (num_splits domain_full_sat ".") 1)))
(assert (>= domain_dots_sat 1))

; -------------------------
; UNSAT instance: contradictory email requirements
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_full_unsat String)
(declare-const tld_unsat String)

; Exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_full_unsat (split_at email_unsat "@" 1)))

; Require a domain with at least one '.'
(assert (>= (num_splits domain_full_unsat ".") 2))
(assert (= tld_unsat (split_at domain_full_unsat "." (- (num_splits domain_full_unsat ".") 1))))

; Contradiction: force domain to contain no '.' while also requiring dot-splitting into >=2 parts
(assert (not (str.contains domain_full_unsat ".")))

; Additional constraints (still consistent alone): local must be non-empty
(assert (> (str.len local_unsat) 0))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
