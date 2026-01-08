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

; Uninterpreted string split interface

; -------------------------
; SAT instance: plausible complex email validation
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const second_level_sat String)
(declare-const subdomain_sat String)
(declare-const domain_rest_sat String)
(declare-const local_plus_parts_sat Int)
(declare-const local_dot_parts_sat Int)
(declare-const domain_dot_parts_sat Int)

; Split at '@' into local and domain
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Local part constraints: length bounds and no embedded '@'
(assert (>= (str.len local_sat) 1))
(assert (<= (str.len local_sat) 64))
(assert (not (str.contains local_sat "@")))

; Allow complex local: require at least one '.' or '+' segmenting (via split counts)
(assert (= local_plus_parts_sat (num_splits local_sat "+")))
(assert (= local_dot_parts_sat (num_splits local_sat ".")))
(assert (or (>= local_plus_parts_sat 2) (>= local_dot_parts_sat 2)))

; Domain constraints: overall length and at least one '.'
(assert (>= (str.len domain_sat) 3))
(assert (<= (str.len domain_sat) 255))
(assert (= domain_dot_parts_sat (num_splits domain_sat ".")))
(assert (>= domain_dot_parts_sat 2))

; Extract domain labels: subdomain, second-level, and TLD
(assert (= subdomain_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_sat (split_rest domain_sat "." 1)))
(assert (= second_level_sat (split_at domain_sat "." (- domain_dot_parts_sat 2))))
(assert (= tld_sat (split_at domain_sat "." (- domain_dot_parts_sat 1))))

; Index sanity (natural indices)
(assert (>= (- domain_dot_parts_sat 2) 0))
(assert (>= (- domain_dot_parts_sat 1) 0))

; Label non-emptiness
(assert (>= (str.len subdomain_sat) 1))
(assert (>= (str.len second_level_sat) 1))
(assert (>= (str.len tld_sat) 2))

; Simple structural restrictions: no empty labels and no '@' in domain
(assert (not (str.contains domain_sat "@")))

; Require alphabetic TLD: [a-zA-Z]{2,6}
(assert (str.in_re tld_sat (re.++ (re.union (re.range "a" "z") (re.range "A" "Z"))
                                 (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))))))
(assert (<= (str.len tld_sat) 6))

; Disallow leading/trailing dot in domain by requiring first and last labels non-empty
(assert (>= (str.len (split_at domain_sat "." 0)) 1))
(assert (>= (str.len (split_at domain_sat "." (- domain_dot_parts_sat 1))) 1))

; Ensure email has no spaces
(assert (not (str.contains email_sat " ")))

(check-sat)

; -------------------------
; UNSAT instance: contradictory email constraints
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const domain_dot_parts_unsat Int)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))

; Domain must have at least one '.'
(assert (= domain_dot_parts_unsat (num_splits domain_unsat ".")))
(assert (>= domain_dot_parts_unsat 2))
(assert (= tld_unsat (split_at domain_unsat "." (- domain_dot_parts_unsat 1))))
(assert (>= (- domain_dot_parts_unsat 1) 0))

; Contradiction: force TLD to be length >= 2, but also exactly "c" (length 1)
(assert (>= (str.len tld_unsat) 2))
(assert (= tld_unsat "c"))

(check-sat)



; [GENERATION STATUS: SUCCESS]
(exit)
