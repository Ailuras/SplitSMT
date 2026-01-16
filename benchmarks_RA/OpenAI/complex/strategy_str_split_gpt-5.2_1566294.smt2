; Scenario: Email Validation using str_split-style operations
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

; Uninterpreted interface operations for splitting

; Seed-like booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; Input email and derived parts
(declare-fun var_0xINPUT_113237 () String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)
(declare-const first_char_local String)
(declare-const last_char_local String)
(declare-const at_symbol String)
(declare-const dot_symbol String)

; Delimiter constants
(assert (= at_symbol "@"))
(assert (= dot_symbol "."))

; Mutate the original seed: no longer equals "-" and must look like an email
(assert (= T_1 (not (= "-" var_0xINPUT_113237))))
(assert T_1)

; Basic split around '@'
(assert (>= (num_splits var_0xINPUT_113237 at_symbol) 2))
(assert (= local_part (split_at var_0xINPUT_113237 at_symbol 0)))
(assert (= domain_part (split_at var_0xINPUT_113237 at_symbol 1)))

; Exactly one '@' by requiring only two segments
(assert (= (num_splits var_0xINPUT_113237 at_symbol) 2))

; Local-part sanity: non-empty, no dots at ends, no '@' inside
(assert (> (str.len local_part) 0))
(assert (= first_char_local (str.at local_part 0)))
(assert (= last_char_local (str.at local_part (- (str.len local_part) 1))))
(assert (not (= first_char_local dot_symbol)))
(assert (not (= last_char_local dot_symbol)))
(assert (not (str.contains local_part at_symbol)))

; Domain must contain at least one dot, and must not start/end with dot
(assert (>= (num_splits domain_part dot_symbol) 2))
(assert (not (= (str.at domain_part 0) dot_symbol)))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) dot_symbol)))

; Extract domain labels and TLD
(assert (= domain_label0 (split_at domain_part dot_symbol 0)))
(assert (= domain_label1 (split_at domain_part dot_symbol 1)))
(assert (= tld (split_at domain_part dot_symbol (- (num_splits domain_part dot_symbol) 1))))

; Domain labels must be non-empty and cannot contain '@'
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (not (str.contains domain_label0 at_symbol)))
(assert (not (str.contains domain_label1 at_symbol)))

; TLD constraints: length between 2 and 6, and must be alphabetic-like via regex
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Reconstruct email from parts (consistency check)
(assert (= reconstructed (str.++ local_part at_symbol domain_part)))
(assert (= reconstructed var_0xINPUT_113237))

; Extra consistency using split_rest: domain_part is rest after first split
(assert (= domain_part (split_rest var_0xINPUT_113237 at_symbol 1)))

; SAT/UNSAT toggle constraints: here we include both styles, but keep overall SAT by not enforcing T_2
; UNSAT example (not asserted): local_part cannot contain '@' but this would force it
(assert (= T_2 (= local_part "a@b")))
; Do not assert T_2 to keep the instance SAT



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
