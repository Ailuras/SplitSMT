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

; Uninterpreted interface for string splitting

; ----------------------------
; Scenario: Email Validation
; We build both SAT and UNSAT instances in one file by using disjoint cases.
; Exactly one case must hold.
; ----------------------------

(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const dom_label2 String)
(declare-const tld String)
(declare-const rest_after_at String)
(declare-const rest_after_first_dot String)

(declare-const case_sat Bool)
(declare-const case_unsat Bool)

(assert (xor case_sat case_unsat))

; Helper-ish bounds and sanity constraints for split indices
(assert (>= (str.len email) 3))

; ============================
; Case 1: SAT email constraints
; - exactly one '@'
; - local part non-empty, no '.' in local part
; - domain has at least two labels separated by '.'
; - TLD length >= 2
; - additional structure: domain labels non-empty
; ============================

(assert (=> case_sat
  (and
    ; exactly one '@' -> split by '@' gives exactly 2 segments
    (= (num_splits email "@") 2)
    (= local_part (split_at email "@" 0))
    (= domain (split_at email "@" 1))
    (= rest_after_at (split_rest email "@" 1))
    (= rest_after_at domain)

    ; local part constraints
    (>= (str.len local_part) 1)
    (not (str.contains local_part "@"))
    (not (str.contains local_part "."))

    ; domain constraints
    (>= (str.len domain) 3)
    (>= (num_splits domain ".") 2)
    (= dom_label0 (split_at domain "." 0))
    (= dom_label1 (split_at domain "." 1))
    (= rest_after_first_dot (split_rest domain "." 1))
    (>= (str.len dom_label0) 1)
    (>= (str.len dom_label1) 1)

    ; choose the last label to be the tld using split_at with index 2 under a 3-part domain
    ; enforce exactly 3 labels here for a more complex structure: a.b.c
    (= (num_splits domain ".") 3)
    (= dom_label2 (split_at domain "." 2))
    (= tld dom_label2)

    ; TLD constraints
    (>= (str.len tld) 2)
    (not (str.contains tld "@"))
    (not (str.contains tld "."))

    ; Concrete witness to ensure satisfiable
    (= email "alice@sub.example")
  )))

; ============================
; Case 2: UNSAT email constraints
; Force contradictions about delimiter counts and structure.
; ============================

(assert (=> case_unsat
  (and
    ; claim exactly one '@'
    (= (num_splits email "@") 2)
    (= local_part (split_at email "@" 0))
    (= domain (split_at email "@" 1))

    ; simultaneously require no '@' at all (contradiction with split count intention)
    (not (str.contains email "@"))

    ; additionally, require domain to have at least 2 dot labels
    (>= (num_splits domain ".") 2)
    (= tld (split_at domain "." 1))
    (>= (str.len tld) 2)

    ; and force email to a concrete string with an '@' to intensify inconsistency
    (= email "bob@x.y")
  )))



; [GENERATION STATUS: SUCCESS]
(assert (= dom_label1 "@"))
(assert (= email "alice@sub.example"))
(assert (= rest_after_first_dot "..."))
(assert (= dom_label0 "A"))
(assert (= domain "..."))
(assert (= tld "CD"))
(assert (= dom_label2 "CD"))
(assert (= rest_after_at "..."))
(assert (= local_part "B"))
(assert (= case_sat true))
(assert (= case_unsat false))
(check-sat)
(exit)
