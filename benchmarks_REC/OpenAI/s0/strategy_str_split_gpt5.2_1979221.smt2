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

; Email Validation via str_split abstraction

; --- Uninterpreted split interface ---

; --- Shared helpers / constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =====================
; SAT instance: plausible valid email
; =====================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const host_ok String)
(declare-const tld_ok String)
(declare-const tld_label_ok String)

; Basic split at '@'
(assert (= local_ok (split_at email_ok at_delim 0)))
(assert (= domain_ok (split_rest email_ok at_delim 1)))
(assert (= (num_splits email_ok at_delim) 2))

; Non-empty local/domain
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))

; Local constraints: no '@', no spaces, at least 3 chars, simple regex
(assert (not (str.contains local_ok at_delim)))
(assert (not (str.contains local_ok " ")))
(assert (>= (str.len local_ok) 3))
(assert (str.in_re local_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))

; Domain constraints: must have at least one '.', no spaces
(assert (not (str.contains domain_ok " ")))
(assert (>= (num_splits domain_ok dot_delim) 2))

; Split domain into host and tld (rest)
(assert (= host_ok (split_at domain_ok dot_delim 0)))
(assert (= tld_ok (split_rest domain_ok dot_delim 1)))
(assert (> (str.len host_ok) 0))
(assert (> (str.len tld_ok) 0))

; Host label constraints: alnum/hyphen only, cannot start/end with '-'
(assert (str.in_re host_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (= (str.at host_ok 0) "-")))
(assert (not (= (str.at host_ok (- (str.len host_ok) 1)) "-")))

; TLD constraints: one or more labels separated by '.', final label length >= 2
(assert (>= (num_splits tld_ok dot_delim) 1))
(assert (= tld_label_ok (split_at tld_ok dot_delim (- (num_splits tld_ok dot_delim) 1))))
(assert (>= (str.len tld_label_ok) 2))
(assert (str.in_re tld_label_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Concrete witness to ensure SAT
(assert (= email_ok "alice.smith+tag@example.co.uk"))

; =====================
; UNSAT instance: contradictory email requirements
; =====================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const host_bad String)
(declare-const tld_bad String)

; Requires exactly one '@'
(assert (= local_bad (split_at email_bad at_delim 0)))
(assert (= domain_bad (split_rest email_bad at_delim 1)))
(assert (= (num_splits email_bad at_delim) 2))
(assert (> (str.len local_bad) 0))
(assert (> (str.len domain_bad) 0))

; Domain split and structure constraints
(assert (= host_bad (split_at domain_bad dot_delim 0)))
(assert (= tld_bad (split_rest domain_bad dot_delim 1)))
(assert (>= (num_splits domain_bad dot_delim) 2))
(assert (> (str.len host_bad) 0))
(assert (> (str.len tld_bad) 0))

; Contradiction 1: local part must both contain '@' and not contain '@'
(assert (str.contains local_bad at_delim))
(assert (not (str.contains local_bad at_delim)))

; Contradiction 2: domain must have at least one dot but also forced to have none
(assert (>= (num_splits domain_bad dot_delim) 2))
(assert (= (num_splits domain_bad dot_delim) 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
