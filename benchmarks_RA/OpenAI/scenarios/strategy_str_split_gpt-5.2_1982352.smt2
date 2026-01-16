(set-logic ALL)
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

; Email Validation with split-based reasoning

; --- str_split interface (uninterpreted) ---

; --- Shared helper constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; ------------------------------------------------------------
; SAT instance: a plausible, structured email
; local@sub.domain.tld with additional constraints
; ------------------------------------------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const dom_last_sat String)
(declare-const dom_before_last_sat String)

; Exactly one '@' => 2 segments when splitting by '@'
(assert (= (num_splits email_sat at_delim) 2))
(assert (= local_sat (split_at email_sat at_delim 0)))
(assert (= domain_sat (split_at email_sat at_delim 1)))

; Local-part constraints (simple structural checks)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat at_delim)))
(assert (not (str.contains local_sat " ")))
(assert (not (= (str.at local_sat 0) ".")))

; Domain constraints: at least sub.domain.tld => >= 3 segments by '.'
(assert (>= (num_splits domain_sat dot_delim) 3))

; Extract last two segments via split_rest nesting
(assert (= dom_last_sat (split_at domain_sat dot_delim (- (num_splits domain_sat dot_delim) 1))))
(assert (= dom_before_last_sat (split_at domain_sat dot_delim (- (num_splits domain_sat dot_delim) 2))))
(assert (= tld_sat dom_last_sat))

; TLD constraints: length >= 2 and only lowercase letters a-z
(assert (>= (str.len tld_sat) 2))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Second-level domain constraints: non-empty and lowercase letters/digits/hyphen (no empty segment)
(assert (>= (str.len dom_before_last_sat) 1))
(assert (str.in_re dom_before_last_sat (re.+ (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))

; Domain must not contain '@' or spaces
(assert (not (str.contains domain_sat at_delim)))
(assert (not (str.contains domain_sat " ")))

; Enforce a concrete satisfying example (still consistent with above constraints)
(assert (= email_sat "alice-1@sub.example.co"))

; ------------------------------------------------------------
; UNSAT instance: contradictory delimiter/segment constraints
; ------------------------------------------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

; Claim exactly one '@'
(assert (= (num_splits email_unsat at_delim) 2))
(assert (= local_unsat (split_at email_unsat at_delim 0)))
(assert (= domain_unsat (split_at email_unsat at_delim 1)))

; Also (incorrectly) require that the whole email contains no '@' at all => contradiction with num_splits = 2
(assert (not (str.contains email_unsat at_delim)))

; Additional domain structure requirements (won't matter due to contradiction above)
(assert (>= (num_splits domain_unsat dot_delim) 2))
(assert (= tld_unsat (split_at domain_unsat dot_delim (- (num_splits domain_unsat dot_delim) 1))))
(assert (>= (str.len tld_unsat) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
