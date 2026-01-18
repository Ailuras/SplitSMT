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

; Email Validation via str_split: '@' separates local-part and domain, '.' separates domain labels.

; --- Uninterpreted split interface ---

; --- Common helper uninterpreted predicates for readability (non-primitive operations) ---
(declare-fun is_alnum_underscore_plus_hyphen (String) Bool)
(declare-fun is_domain_label (String) Bool)
(declare-fun is_tld (String) Bool)

; --- SAT instance variables ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_first_ok String)
(declare-const tld_ok String)
(declare-const dom_rest_ok String)

; Shape: exactly one '@'
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local-part constraints: non-empty, no '@', allow complex characters abstractly
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (is_alnum_underscore_plus_hyphen local_ok))

; Domain constraints: must have at least one dot => at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))
(assert (= dom_first_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (= dom_rest_ok (split_rest domain_ok "." 1)))

; Each label constraints (abstract): first label non-empty, TLD looks like a TLD
(assert (> (str.len dom_first_ok) 0))
(assert (is_domain_label dom_first_ok))
(assert (> (str.len tld_ok) 1))
(assert (is_tld tld_ok))

; Ensure domain does not start/end with dot and no consecutive dots via split properties (non-empty labels)
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i (num_splits domain_ok ".")))
      (> (str.len (split_at domain_ok "." i)) 0))))

; Provide a concrete satisfying witness while still exercising split constraints
(assert (= email_ok "john_doe+tag@example.co.uk"))


; --------------------
; UNSAT instance: forces conflicting structure
; --------------------

(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Claim: exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Also claim: domain has at least one dot
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))

; Contradiction: force email_bad to be a string with no '@' and no '.' in domain
(assert (= email_bad "nodomainseparators"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
