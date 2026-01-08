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

; Uninterpreted functions for str_split interface

; ----------------------------
; Scenario: Email Validation
; ----------------------------

; Primary email under validation (intended SAT)
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const domain_label0_ok String)
(declare-const domain_label1_ok String)
(declare-const tld_ok String)
(declare-const domain_prefix_ok String)

; Secondary email under validation (intended UNSAT)
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const bad_label0 String)
(declare-const bad_label1 String)
(declare-const bad_label2 String)

; ----------------------------
; SAT instance: email_ok constraints
; ----------------------------

; Exactly one '@' delimiter => two segments
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Basic sanity: non-empty local and domain, and local cannot contain '@'
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains local_ok "@")))

; Domain must have at least one '.' => at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))
(assert (= domain_label0_ok (split_at domain_ok "." 0)))
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))

; The rest from label1 onward forms the domain suffix
(assert (= domain_prefix_ok (split_rest domain_ok "." 1)))
(assert (> (str.len domain_label0_ok) 0))
(assert (> (str.len tld_ok) 1))

; No empty labels: require the first two labels non-empty when present
(assert (=> (>= (num_splits domain_ok ".") 2)
            (> (str.len (split_at domain_ok "." 1)) 0)))

; Forbid leading or trailing '.' in domain
(assert (not (= (str.at domain_ok 0) ".")))
(assert (not (= (str.at domain_ok (- (str.len domain_ok) 1)) ".")))

; Ensure domain contains no '@'
(assert (not (str.contains domain_ok "@")))

; Strengthen: local part contains a dot somewhere (allowed in many emails)
(assert (str.contains local_ok "."))

; Provide a concrete satisfying example to ensure SAT
(assert (= email_ok "john.doe@example.co.uk"))

; ----------------------------
; UNSAT instance: email_bad constraints
; ----------------------------

; Claim exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Additionally (contradict) that there are at least 3 segments by '@'
(assert (>= (num_splits email_bad "@") 3))

; Add domain structure constraints that would otherwise be reasonable
(assert (>= (num_splits domain_bad ".") 2))
(assert (= bad_label0 (split_at domain_bad "." 0)))
(assert (= bad_label1 (split_at domain_bad "." 1)))
(assert (=> (>= (num_splits domain_bad ".") 3)
            (= bad_label2 (split_at domain_bad "." 2))))

; Non-empty first label and TLD length constraint
(assert (> (str.len bad_label0) 0))
(assert (> (str.len (split_at domain_bad "." (- (num_splits domain_bad ".") 1))) 1))

; Provide a concrete-looking email string (still UNSAT due to '@' split contradiction)
(assert (= email_bad "alice@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
