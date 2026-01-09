(set-logic ALL)

; Uninterpreted interface for str_split
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

; Uninterpreted helper predicates/functions for readability
(declare-fun is_nonempty (String) Bool)
(declare-fun is_ascii_atom (String) Bool)
(declare-fun is_domain_label (String) Bool)
(declare-fun is_tld (String) Bool)

; -----------------------------
; SAT instance: a well-formed email
; -----------------------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const label0_ok String)
(declare-const rest_after_at_ok String)
(declare-const domain_parts_ok Int)

(assert (= email_ok "alice.smith+tag@example.co.uk"))

; Split at '@' into local and domain
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= rest_after_at_ok (split_rest email_ok "@" 1)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= domain_ok rest_after_at_ok))
(assert (= (num_splits email_ok "@") 2))

; Basic local-part constraints
(assert (is_nonempty local_ok))
(assert (is_ascii_atom local_ok))
(assert (not (str.contains local_ok "@")))
(assert (>= (str.len local_ok) 1))

; Domain structure: split on '.' and require at least 2 parts
(assert (= domain_parts_ok (num_splits domain_ok ".")))
(assert (>= domain_parts_ok 2))

; First domain label non-empty and plausible
(assert (= label0_ok (split_at domain_ok "." 0)))
(assert (is_nonempty label0_ok))
(assert (is_domain_label label0_ok))

; TLD = last segment: use split_at with known index for this concrete email ("uk" is index 3)
(assert (= tld_ok (split_at domain_ok "." 3)))
(assert (is_tld tld_ok))
(assert (= tld_ok "uk"))

; Disallow empty labels via additional constraints on known positions for this concrete domain
(assert (is_domain_label (split_at domain_ok "." 1)))
(assert (is_domain_label (split_at domain_ok "." 2)))

; Extra structural sanity checks
(assert (not (str.contains domain_ok "@")))
(assert (not (= (str.at email_ok 0) "@")))
(assert (not (= (str.at email_ok (- (str.len email_ok) 1)) "@")))

; -----------------------------
; UNSAT instance: contradictory constraints for email
; -----------------------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const domain_parts_bad Int)

(assert (= email_bad "bob@example.com"))

; Must split into exactly two parts at '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Contradiction 1: local part is required to contain '@' even though it is before '@'
(assert (str.contains local_bad "@"))

; Contradiction 2: domain must have at least 3 dot-separated parts, but concrete domain has only 2 (example, com)
(assert (= domain_parts_bad (num_splits domain_bad ".")))
(assert (>= domain_parts_bad 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
