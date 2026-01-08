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

; Uninterpreted interface operations for string splitting

; Seed-derived symbols (mutated/extended)
(declare-fun T_1 () Bool)
(declare-const var_0xINPUT_103698 String)

; Email validation symbols
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const dot_count_dom Int)
(declare-const at_count Int)
(declare-const at_idx Int)
(declare-const local_len Int)
(declare-const domain_len Int)

; Preserve core structure: keep a Boolean tying to the original input, but no longer force exact seed string
(assert (= T_1 (= var_0xINPUT_103698 email)))
(assert T_1)

; Basic email split at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= at_count (num_splits email "@")))

; Exactly one '@' => two segments
(assert (= at_count 2))

; Local and domain must be non-empty
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 0))

; Disallow extra '@' anywhere: the second segment must not contain '@'
(assert (= (num_splits domain "@") 1))

; Domain structure split by '.'
(assert (= dot_count_dom (num_splits domain ".")))
(assert (>= dot_count_dom 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dot_count_dom 1))))
(assert (= rest_labels (split_rest domain "." 1)))

; Each required component must be non-empty
(assert (> (str.len first_label) 0))
(assert (> (str.len tld) 0))

; No empty label: domain cannot start or end with '.' and cannot contain '..'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "..")))

; TLD constraints: length at least 2, and must not contain '.'
(assert (>= (str.len tld) 2))
(assert (= (num_splits tld ".") 1))

; Local part constraints: cannot start/end with '.', cannot contain consecutive dots
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))
(assert (not (str.contains local "..")))

; Ensure '@' occurs in a valid position in the full email using index bounds
(assert (= at_idx (str.indexof email "@" 0)))
(assert (>= at_idx 1))
(assert (< at_idx (- (str.len email) 1)))

; SAT instance: provide a concrete satisfying example
(assert (= email "user.name+tag@example.co.uk"))

; Also include an UNSAT branch guarded by a boolean to demonstrate diversity without forcing UNSAT
(declare-const make_unsat Bool)
(assert (or (not make_unsat)
            (and
              (= email "bad..local@.example..com")
              (not (str.contains local ".."))
              (not (str.prefixof "." domain))
              (not (str.contains domain "..")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
