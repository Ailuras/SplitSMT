(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; =========================
; Scenario: Email Validation
; =========================

; ----------
; SAT instance: a well-formed email with structured local-part and domain
; ----------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const local_user_ok String)
(declare-const local_tag_ok String)
(declare-const local_tag_count_ok Int)
(declare-const domain_label_count_ok Int)
(declare-const dom_label0_ok String)
(declare-const dom_label1_ok String)
(declare-const dom_label2_ok String)
(declare-const tld_ok String)

(assert (= email_ok "john.doe+news@sub.example.com"))

; Basic split by '@'
(assert (>= (num_splits email_ok "@") 2))
(assert (= 2 (num_splits email_ok "@")))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= "" (split_rest email_ok "@" 2)))

; Local-part constraints
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Optional tag via '+' in local-part: require exactly 2 segments (user + tag)
(assert (= local_tag_count_ok (num_splits local_ok "+")))
(assert (= local_user_ok (split_at local_ok "+" 0)))
(assert (= local_tag_ok (split_at local_ok "+" 1)))
(assert (= 2 local_tag_count_ok))
(assert (> (str.len local_user_ok) 0))
(assert (> (str.len local_tag_ok) 0))

; Ensure local_user has at least one '.' segment (e.g., first.last)
(assert (>= (num_splits local_user_ok ".") 2))
(assert (not (str.contains local_user_ok "..")))
(assert (not (str.contains local_user_ok ".@")))

; Domain constraints
(assert (> (str.len domain_ok) 0))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "..")))
(assert (not (str.contains domain_ok ".-")))
(assert (not (str.contains domain_ok "-.")))
(assert (not (str.contains domain_ok "-@")))

; Split domain by '.' and require at least 3 labels: sub + second-level + TLD
(assert (= domain_label_count_ok (num_splits domain_ok ".")))
(assert (>= domain_label_count_ok 3))
(assert (= dom_label0_ok (split_at domain_ok "." 0)))
(assert (= dom_label1_ok (split_at domain_ok "." 1)))
(assert (= dom_label2_ok (split_at domain_ok "." 2)))
(assert (= tld_ok (split_at domain_ok "." (- domain_label_count_ok 1))))

; Labels are non-empty and no spaces
(assert (> (str.len dom_label0_ok) 0))
(assert (> (str.len dom_label1_ok) 0))
(assert (> (str.len dom_label2_ok) 0))
(assert (not (str.contains dom_label0_ok " ")))
(assert (not (str.contains dom_label1_ok " ")))
(assert (not (str.contains dom_label2_ok " ")))

; TLD must be "com" for this SAT instance
(assert (= tld_ok "com"))

; ----------
; UNSAT instance: force contradictory structure with split constraints
; ----------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const domain_label_count_bad Int)
(declare-const first_dom_label_bad String)
(declare-const last_dom_label_bad String)

(assert (= email_bad "alice@@example..com"))

(assert (= at_count_bad (num_splits email_bad "@")))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Contradiction: require exactly 2 segments on '@' but the concrete string has more
(assert (= 2 at_count_bad))

; Additional contradictory constraints on the domain structure
(assert (= domain_label_count_bad (num_splits domain_bad ".")))
(assert (>= domain_label_count_bad 2))
(assert (= first_dom_label_bad (split_at domain_bad "." 0)))
(assert (= last_dom_label_bad (split_at domain_bad "." (- domain_label_count_bad 1))))
(assert (> (str.len first_dom_label_bad) 0))
(assert (> (str.len last_dom_label_bad) 0))

; Contradiction: disallow consecutive dots, but the concrete email contains ".."
(assert (not (str.contains email_bad "..")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
