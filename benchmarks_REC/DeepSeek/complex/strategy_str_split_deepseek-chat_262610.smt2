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

; Uninterpreted interface: str_split

; ------------------------------
; SAT instance: complex but consistent email validation constraints
; ------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_main_sat String)
(declare-const tld_sat String)
(declare-const sub1_sat String)
(declare-const sub2_sat String)
(declare-const tld2_sat String)
(declare-const recon_domain_sat String)
(declare-const recon_email_sat String)
(declare-const plus_tag_sat String)
(declare-const plus_left_sat String)
(declare-const plus_right_sat String)
(declare-const start_local_char_sat String)

; Split at '@' into local and domain, enforce exactly one '@' (2 segments)
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))

; Basic non-emptiness and structure
(assert (> (str.len local_sat) 0))
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains domain_sat "@")))

; Local part: allow optional '+' tag (must not be empty on either side if '+' appears)
(assert (>= (num_splits local_sat "+") 1))
(assert (<= (num_splits local_sat "+") 2))
(assert (= plus_left_sat (split_at local_sat "+" 0)))
(assert (= plus_right_sat (split_at local_sat "+" 1)))
(assert (=> (= (num_splits local_sat "+") 2)
            (and (> (str.len plus_left_sat) 0)
                 (> (str.len plus_right_sat) 0))))
(assert (=> (= (num_splits local_sat "+") 2)
            (= plus_tag_sat plus_right_sat)))
(assert (=> (= (num_splits local_sat "+") 1)
            (= plus_tag_sat "")))

; Local part should not start with '.' and must not contain ".."
(assert (= start_local_char_sat (str.at local_sat 0)))
(assert (not (= start_local_char_sat ".")))
(assert (not (str.contains local_sat "..")))

; Domain structure: must have at least one dot, i.e., >=2 segments when split by '.'
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_main_sat (split_at domain_sat "." 0)))
(assert (= tld_sat (split_at domain_sat "." 1)))
(assert (> (str.len domain_main_sat) 0))
(assert (> (str.len tld_sat) 0))

; Also require at least 3 dot-separated segments (subdomain + domain + tld)
(assert (>= (num_splits domain_sat ".") 3))
(assert (= sub1_sat (split_at domain_sat "." 0)))
(assert (= sub2_sat (split_at domain_sat "." 1)))
(assert (= tld2_sat (split_at domain_sat "." 2)))
(assert (> (str.len sub1_sat) 0))
(assert (> (str.len sub2_sat) 0))
(assert (> (str.len tld2_sat) 0))

; Domain parts must not be empty (implies no leading/trailing dot and no ".." in domain)
(assert (not (str.contains domain_sat "..")))
(assert (not (str.contains domain_sat ".-")))
(assert (not (str.contains domain_sat "-.")))

; Reconstruct domain/email using split_rest and concatenation to tie components together
(assert (= recon_domain_sat (str.++ (split_at domain_sat "." 0) "." (split_rest domain_sat "." 1))))
(assert (= recon_domain_sat domain_sat))
(assert (= recon_email_sat (str.++ local_sat "@" domain_sat)))
(assert (= recon_email_sat email_sat))

; Provide a concrete satisfying witness
(assert (= email_sat "john.doe+tag@sub.example.com"))

; ------------------------------
; UNSAT instance: conflicting requirements about dots in the domain
; ------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const domain_first_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))
(assert (> (str.len local_unsat) 0))
(assert (> (str.len domain_unsat) 0))

; Require at least one '.' in domain
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= domain_first_unsat (split_at domain_unsat "." 0)))
(assert (> (str.len domain_first_unsat) 0))

; Contradiction: also require that domain contains no '.'
(assert (not (str.contains domain_unsat ".")))

; Tie to a plausible email shape (still contradictory due to dot constraints)
(assert (= email_unsat "alice@domain"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
