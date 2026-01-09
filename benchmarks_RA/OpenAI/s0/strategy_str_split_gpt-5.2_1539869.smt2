(set-logic ALL)

; Uninterpreted interface for string split operations
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

; ==========================
; Scenario: Email Validation
; ==========================

; --- SAT instance: a plausible complex email ---
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const sld_sat String)
(declare-const host_sat String)
(declare-const first_host_label_sat String)
(declare-const rest_host_labels_sat String)

; Split at '@': local and domain
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (<= (num_splits email_sat "@") 2))

; Basic structural constraints
(assert (>= (str.len email_sat) 6))
(assert (>= (str.len local_sat) 1))
(assert (>= (str.len domain_sat) 3))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Local-part constraints: no spaces, must contain at least one '.' (complex local)
(assert (not (str.contains local_sat " ")))
(assert (str.contains local_sat "."))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Domain constraints: at least 2 dot-separated segments, and has a non-empty TLD
(assert (>= (num_splits domain_sat ".") 2))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (>= (str.len tld_sat) 2))

; Enforce that domain ends with "." + tld (via split_rest from last index)
(assert (= (split_rest domain_sat "." (- (num_splits domain_sat ".") 1)) tld_sat))

; Model a domain of the form host.sld.tld (at least 3 segments)
(assert (>= (num_splits domain_sat ".") 3))
(assert (= host_sat (split_at domain_sat "." 0)))
(assert (= sld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 2))))
(assert (>= (str.len host_sat) 1))
(assert (>= (str.len sld_sat) 1))

; Host itself can have hyphenated/extra labels: enforce at least one label and optionally more via rest
(assert (= first_host_label_sat (split_at host_sat "-" 0)))
(assert (>= (num_splits host_sat "-") 1))
(assert (= rest_host_labels_sat (split_rest host_sat "-" 1)))
(assert (>= (str.len first_host_label_sat) 1))

; Concrete satisfying example (consistent with all constraints)
(assert (= email_sat "john.doe+tag@sub-mail.example.co"))


; --- UNSAT instance: contradictory domain structure requirements ---
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Split at '@'
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Contradiction: domain must have at least 2 dot segments but also exactly 1 segment
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= (num_splits domain_unsat ".") 1))

; Additional typical constraints (won't rescue satisfiability)
(assert (>= (str.len local_unsat) 1))
(assert (>= (str.len domain_unsat) 1))
(assert (= tld_unsat (split_at domain_unsat "." 0)))
(assert (>= (str.len tld_unsat) 2))

; Concrete-looking email (still UNSAT due to above contradiction)
(assert (= email_unsat "a@b"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
