(set-logic ALL)

; Email Validation via str_split using '@' and '.' delimiters

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

; Shared helper strings
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =========================
; SAT instance: well-formed email
; =========================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_label0_ok String)
(declare-const domain_label1_ok String)

; Basic split around '@'
(assert (= local_ok (split_at email_ok at_delim 0)))
(assert (= domain_ok (split_at email_ok at_delim 1)))
(assert (= (num_splits email_ok at_delim) 2))

; Local-part constraints (non-empty, no spaces, no '@', no consecutive dots)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok "..")))
(assert (not (str.contains local_ok ".@")))
(assert (not (str.contains local_ok "@.")))

; Domain constraints (must contain at least one '.', no spaces)
(assert (not (str.contains domain_ok " ")))
(assert (>= (num_splits domain_ok dot_delim) 2))
(assert (= domain_label0_ok (split_at domain_ok dot_delim 0)))
(assert (= domain_label1_ok (split_at domain_ok dot_delim 1)))
(assert (> (str.len domain_label0_ok) 0))
(assert (> (str.len domain_label1_ok) 0))

; TLD is last segment: use split_rest to obtain suffix from index 1, then take its last label via another split
(assert (= tld_ok (split_at (split_rest domain_ok dot_delim 1) dot_delim (- (num_splits (split_rest domain_ok dot_delim 1) dot_delim) 1))))

; TLD structure constraints: length 2..24, alphabetic-only (lowercase for simplicity)
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Domain label constraints: simple DNS-like restrictions (no empty label, no leading/trailing '-')
(assert (not (= domain_label0_ok "-")))
(assert (not (= domain_label1_ok "-")))
(assert (not (= (str.at domain_label0_ok 0) "-")))
(assert (not (= (str.at domain_label1_ok 0) "-")))
(assert (not (= (str.at domain_label0_ok (- (str.len domain_label0_ok) 1)) "-")))
(assert (not (= (str.at domain_label1_ok (- (str.len domain_label1_ok) 1)) "-")))

; Witness email for SAT
(assert (= email_ok "alice.smith@sub.example"))

; =========================
; UNSAT instance: contradictory email requirements
; =========================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Force exactly one '@'
(assert (= (num_splits email_bad at_delim) 2))
(assert (= local_bad (split_at email_bad at_delim 0)))
(assert (= domain_bad (split_at email_bad at_delim 1)))

; Require domain to have at least one '.', and also require it to have no '.' (contradiction)
(assert (>= (num_splits domain_bad dot_delim) 2))
(assert (not (str.contains domain_bad ".")))

; Additional constraints that would otherwise look reasonable
(assert (> (str.len local_bad) 0))
(assert (not (str.contains local_bad " ")))
(assert (not (str.contains local_bad "@")))

; Define tld_bad from domain_bad if it were splittable (still consistent with the interface, but overall UNSAT due to contradiction above)
(assert (= tld_bad (split_at (split_rest domain_bad dot_delim 1) dot_delim (- (num_splits (split_rest domain_bad dot_delim 1) dot_delim) 1))))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
