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

; =========
; Scenario: Email Validation
; Validating complex email address formats using '@' and '.' as delimiters.
; We create one SAT instance (email_ok) and one UNSAT instance (email_bad).
; =========

; --- SAT instance variables ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const first_label_ok String)
(declare-const tld_ok String)

; --- UNSAT instance variables ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; -----------------------------
; SAT constraints: well-formed email
; -----------------------------

; Exactly one '@' => exactly 2 segments when splitting by '@'
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local part constraints: non-empty, no '@', no spaces
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: non-empty, contains '.', no '@', no spaces
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (str.contains domain_ok "."))

; Domain structure: at least 2 labels (e.g., example.com)
(assert (>= (num_splits domain_ok ".") 2))
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))

; Labels must be non-empty
(assert (> (str.len first_label_ok) 0))
(assert (> (str.len tld_ok) 0))

; TLD should be length 2..63
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 63))

; Ensure domain does not start or end with '.' (approximated by non-empty first/last labels)
; Already implied by first_label_ok and tld_ok being non-empty.

; Provide a concrete witness to ensure SAT
(assert (= email_ok "alice.smith+tag@example.co.uk"))

; -----------------------------
; UNSAT constraints: contradictory email requirements
; -----------------------------

; Force a fixed simple-looking email
(assert (= email_bad "bob@example.com"))

; Split by '@' and bind parts
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Require domain to have at least one '.' and a TLD
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))

; Contradiction: demand TLD be empty but also length >= 2
(assert (= tld_bad ""))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
