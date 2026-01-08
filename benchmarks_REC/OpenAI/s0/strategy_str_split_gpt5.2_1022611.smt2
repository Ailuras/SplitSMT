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

; Uninterpreted interface operations for string split

; ------------------------
; SAT instance: complex-but-valid email validation constraints
; ------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const subdomain_sat String)
(declare-const domain_first_label_sat String)
(declare-const domain_rest_after_first_sat String)
(declare-const domain_last_label_sat String)
(declare-const i_sat Int)

; Basic non-emptiness and presence constraints
(assert (> (str.len email_sat) 5))
(assert (>= (num_splits email_sat "@") 2))
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))

; Local-part should not contain '@' and should include at least one '.' (to vary patterns)
(assert (= (num_splits local_sat "@") 1))
(assert (>= (num_splits local_sat ".") 2))

; Domain must have at least 2 labels separated by '.' (e.g., example.com)
(assert (>= (num_splits domain_sat ".") 2))

; Extract first label, rest, and last label of the domain
(assert (= domain_first_label_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_after_first_sat (split_rest domain_sat "." 1)))
(assert (= domain_last_label_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (> (str.len domain_first_label_sat) 0))
(assert (> (str.len domain_rest_after_first_sat) 0))
(assert (> (str.len domain_last_label_sat) 0))

; TLD constraints: 2..6 chars, alphabetic-only (using regex)
(assert (= tld_sat domain_last_label_sat))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 6))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Optional additional structure: require a subdomain label of at least 2 chars
; (take the first label again as a "subdomain" placeholder)
(assert (= subdomain_sat domain_first_label_sat))
(assert (>= (str.len subdomain_sat) 2))

; Use a natural index constraint to exercise the interface's index discipline
(assert (>= i_sat 0))
(assert (< i_sat (num_splits domain_sat ".")))

; Construct a witness email string to ensure SAT
(assert (= email_sat "first.last@sub.example.com"))


; ------------------------
; UNSAT instance: contradictory domain/TLD requirements
; ------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const last_label_unsat String)

(assert (= email_unsat "user@corp.internal"))
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= last_label_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (= tld_unsat last_label_unsat))

; Contradiction: force TLD to be purely digits but also to be purely lowercase letters
(assert (str.in_re tld_unsat (re.+ (re.range "0" "9"))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))


(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
