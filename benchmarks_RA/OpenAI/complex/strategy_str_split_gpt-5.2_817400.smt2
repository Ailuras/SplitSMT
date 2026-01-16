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

; Uninterpreted interface operations for str_split

; Seed-preserved symbols (kept for core structure)
(declare-fun I0_2 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_2 () String)
(declare-fun T1_2 () String)
(declare-fun T2_2 () String)
(declare-fun T3_2 () String)
(declare-fun T4_2 () String)
(declare-fun T5_2 () String)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_4157 () String)

; New variables for Email Validation scenario
(declare-const localpart String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const has_plus Bool)
(declare-const has_spaces Bool)

; Core structure preserved: select condition over sentinel ((- 1))
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))

; Mutated/extended: now models email parsing, still using the same concatenation skeleton
(assert
  (ite T_SELECT_1
    (and
      (= PCTEMP_LHS_1 (+ I0_2 0))
      (= var_0xINPUT_4157 (str.++ T0_2 T1_2))
      (= 0 (str.len T0_2))

      ; Email must contain exactly one '@'
      (= at_count (num_splits var_0xINPUT_4157 "@"))
      (= at_count 2)

      ; Local part and domain extracted by split
      (= localpart (split_at var_0xINPUT_4157 "@" 0))
      (= domain (split_at var_0xINPUT_4157 "@" 1))

      ; Non-empty localpart and domain
      (> (str.len localpart) 0)
      (> (str.len domain) 0)

      ; Domain must have at least one '.' and at least two labels
      (= dot_count (num_splits domain "."))
      (>= dot_count 2)

      ; Extract first two labels and TLD (last label approximated by index 1 when dot_count=2)
      (= dom_label0 (split_at domain "." 0))
      (= dom_label1 (split_at domain "." 1))
      (= tld dom_label1)

      ; Label constraints: no empty labels
      (> (str.len dom_label0) 0)
      (> (str.len dom_label1) 0)

      ; TLD constraints: length between 2 and 24
      (>= (str.len tld) 2)
      (<= (str.len tld) 24)

      ; Basic disallowed characters
      (= has_spaces (str.contains var_0xINPUT_4157 " "))
      (not has_spaces)
      (not (str.contains localpart ".."))
      (not (str.contains domain ".."))
      (not (str.contains domain "@"))

      ; Allow plus-tagging but forbid it in domain
      (= has_plus (str.contains localpart "+"))
      (not (str.contains domain "+"))

      ; Link to seed's length-carrying variable
      (= I0_2 (str.len localpart))

      ; Mutated from seed: forbid a debug-query-like suffix in the domain
      (= T5_2 "?debug=1")
      (not (str.contains domain T5_2))

      ; Tie some seed strings into the email structure
      (= T4_2 localpart)
      (= T2_2 (str.++ T4_2 "@"))
      (= T3_2 domain)
      (= T1_2 (str.++ T2_2 T3_2))

      ; Ensure there is no trailing '.' in domain
      (not (= (str.at domain (- (str.len domain) 1)) "."))
    )
    (and
      (= PCTEMP_LHS_1 (- 1))
      (= var_0xINPUT_4157 (str.++ T0_2 T1_2))
      (= 0 (str.len T0_2))

      ; Alternate branch: makes it easy to be UNSAT if chosen, by demanding impossible email split
      (= (num_splits T1_2 "@") 1)
      (str.contains T1_2 "@")
    )
  )
)

; Seed-preserved Boolean plumbing
(assert (= T_2 (= PCTEMP_LHS_1 (- 1))))
(assert (= T_3 (not T_2)))

; Force selection of the main (email-validating) branch
(assert T_3)

; Additional email-specific assertions
(assert (not (str.contains localpart "@")))
(assert (not (str.contains localpart ".@")))
(assert (not (str.contains var_0xINPUT_4157 "\n")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
