(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; Email inputs
(declare-const email_sat String)
(declare-const email_unsat String)

; Common derived parts for SAT email
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_first_label String)
(declare-const sat_tld String)
(declare-const sat_domain_rest String)

; Common derived parts for UNSAT email
(declare-const unsat_local String)
(declare-const unsat_domain String)
(declare-const unsat_first_label String)
(declare-const unsat_tld String)

; -------------------------
; SAT instance: should be satisfiable
; Enforce shape: local@label.tld  (at least 2 labels in domain)
; -------------------------
(assert (= email_sat "alice.smith+tag@example.co"))

; Split by '@' must give exactly 2 parts
(assert (= (num_splits email_sat "@") 2))
(assert (= sat_local (split_at email_sat "@" 0)))
(assert (= sat_domain (split_at email_sat "@" 1)))
(assert (= (split_rest email_sat "@" 1) sat_domain))

; Local-part sanity: non-empty, no '@', does not start/end with '.'
(assert (> (str.len sat_local) 0))
(assert (not (str.contains sat_local "@")))
(assert (not (= (str.at sat_local 0) ".")))
(assert (not (= (str.at sat_local (- (str.len sat_local) 1)) ".")))

; Domain sanity: contains at least one '.', no '@', non-empty
(assert (> (str.len sat_domain) 0))
(assert (not (str.contains sat_domain "@")))
(assert (>= (num_splits sat_domain ".") 2))

; Extract first label and last label (TLD) using split operations
(assert (= sat_first_label (split_at sat_domain "." 0)))
(assert (= sat_domain_rest (split_rest sat_domain "." 1)))

; Constrain TLD to be the last segment by making domain_rest exactly "co"
; (This enforces exactly two labels: example.co)
(assert (= sat_domain_rest "co"))
(assert (= sat_tld (split_at sat_domain "." 1)))

; Label constraints: non-empty labels, no empty segments around '.'
(assert (> (str.len sat_first_label) 0))
(assert (> (str.len sat_tld) 0))

; TLD constraints: length at least 2
(assert (>= (str.len sat_tld) 2))

; -------------------------
; UNSAT instance: should be unsatisfiable
; Intend to force both "exactly one '@'" and also "no '@'", conflicting
; Additionally enforce domain has at least 2 '.' labels, while fixing to a single-label domain
; -------------------------
(assert (= email_unsat "bob@localhost"))

; Split by '@' must give exactly 2 parts
(assert (= (num_splits email_unsat "@") 2))
(assert (= unsat_local (split_at email_unsat "@" 0)))
(assert (= unsat_domain (split_at email_unsat "@" 1)))

; Contradiction: email must not contain '@'
(assert (not (str.contains email_unsat "@")))

; Domain structure requirements: must have at least two labels (contain '.')
(assert (>= (num_splits unsat_domain ".") 2))
(assert (= unsat_first_label (split_at unsat_domain "." 0)))
(assert (= unsat_tld (split_at unsat_domain "." 1)))

; Fix domain to single-label "localhost" (contradicts the '.' split requirement)
(assert (= unsat_domain "localhost"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
