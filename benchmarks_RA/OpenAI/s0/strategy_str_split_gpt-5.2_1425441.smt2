(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; =====================
; SAT instance: complex but valid-like email structure constraints
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_first_sat String)
(declare-const tld_sat String)
(declare-const after_at_sat String)
(declare-const subdomain_or_rest_sat String)
(declare-const dot_piece0_sat String)
(declare-const dot_piece1_sat String)
(declare-const dot_rest_after1_sat String)
(declare-const local0_sat String)
(declare-const local1_sat String)

; Basic email shape: exactly one '@' (two segments when split)
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= after_at_sat (split_rest email_sat "@" 1)))
(assert (= after_at_sat domain_sat))

; Local part constraints: non-empty, no spaces, has at least one dot segment (but not leading/trailing dot)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat " ")))
(assert (>= (num_splits local_sat ".") 2))
(assert (= local0_sat (split_at local_sat "." 0)))
(assert (= local1_sat (split_at local_sat "." 1)))
(assert (>= (str.len local0_sat) 1))
(assert (>= (str.len local1_sat) 1))

; Domain constraints: must contain at least one dot (at least two segments), no spaces
(assert (>= (num_splits domain_sat ".") 2))
(assert (not (str.contains domain_sat " ")))

; Domain structure: first label and last label (TLD) non-empty
(assert (= domain_first_sat (split_at domain_sat "." 0)))
(assert (>= (str.len domain_first_sat) 1))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (>= (str.len tld_sat) 2))

; TLD must be all lowercase letters (simple regex) and length 2..10
(assert (<= (str.len tld_sat) 10))
(assert (str.in_re tld_sat (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))

; Additional domain sanity: second label exists and non-empty
(assert (= dot_piece0_sat (split_at domain_sat "." 0)))
(assert (= dot_piece1_sat (split_at domain_sat "." 1)))
(assert (>= (str.len dot_piece1_sat) 1))
(assert (= dot_rest_after1_sat (split_rest domain_sat "." 1)))
(assert (>= (str.len dot_rest_after1_sat) 1))

; Concretize to ensure satisfiable while still matching constraints
(assert (= email_sat "john.doe@sub.example.co"))


; =====================
; UNSAT instance: contradictory email/domain structure constraints
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const dom_first_unsat String)

; Require exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Require domain to have at least one dot
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= dom_first_unsat (split_at domain_unsat "." 0)))
(assert (>= (str.len dom_first_unsat) 1))

; TLD extraction and constraints
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (>= (str.len tld_unsat) 2))

; Contradiction: TLD must be digits only AND lowercase letters only
(assert (str.in_re tld_unsat (re.+ (re.range "0" "9"))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))

; Concretize to a typical-looking email (still unsat due to regex contradiction)
(assert (= email_unsat "alice@company.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
