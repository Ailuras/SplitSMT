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

; Primary email candidate (intended SAT)
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_tld String)
(declare-const domain_rest_from1 String)

; Auxiliary email candidate (intended UNSAT)
(declare-const email_bad String)
(declare-const bad_local String)
(declare-const bad_domain String)

; -------------------------------
; SAT instance: enforce a reasonably complex valid email structure
; Must have exactly one '@' => exactly 2 segments when split by '@'
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Basic non-emptiness and length bounds
(assert (>= (str.len local) 1))
(assert (<= (str.len local) 64))
(assert (>= (str.len domain) 3))
(assert (<= (str.len domain) 255))

; Disallow spaces in local/domain (simple sanity)
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))

; Local part should not contain '@'
(assert (not (str.contains local "@")))

; Domain must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= domain_rest_from1 (split_rest domain "." 1)))

; The last label (TLD) must have length >= 2
(assert (= domain_tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len domain_tld) 2))

; Domain first label and TLD should be non-empty
(assert (>= (str.len domain_first_label) 1))
(assert (>= (str.len domain_tld) 1))

; Domain should not start or end with '.'
(assert (not (= domain_first_label "")))
(assert (not (= domain_tld "")))

; Enforce that domain has no empty labels anywhere by requiring no ".."
(assert (not (str.contains domain "..")))

; Add a structured constraint: domain_rest_from1 must contain at least one '.' iff domain has >=3 labels
(assert (= (>= (num_splits domain ".") 3) (str.contains domain_rest_from1 ".")))

; Make the instance more concrete but still satisfiable
(assert (str.contains local "."))
(assert (not (str.contains local "..")))
(assert (str.contains domain "example"))
(assert (str.contains domain_tld "com"))

; Ensure overall email matches the split recomposition expectation (sanity)
(assert (= email (str.++ local "@" domain)))

; -------------------------------
; UNSAT instance: contradictory email structure requirements
; Force exactly one '@' split but also force local to contain '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= bad_local (split_at email_bad "@" 0)))
(assert (= bad_domain (split_at email_bad "@" 1)))
(assert (>= (str.len bad_local) 1))
(assert (>= (str.len bad_domain) 1))
(assert (not (str.contains bad_local "@")))
(assert (str.contains bad_local "@"))

; Also add a domain contradiction: require at least 2 labels but forbid '.' entirely
(assert (>= (num_splits bad_domain ".") 2))
(assert (not (str.contains bad_domain ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
