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

; --- Uninterpreted interface operations for str_split ---

; --- Variables (mutated/extended from seed) ---
(declare-const T1_3 String)
(declare-const T2_3 String)
(declare-const T_1 String)
(declare-const T_2 Bool)
(declare-const var_0xINPUT_96358 String)

; Email-related helpers
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const domain_has_dot Bool)
(declare-const email_has_at Bool)

; --- Core seed structure retained but repurposed to email pipeline ---
(assert (= T_1 (str.++ T1_3 T2_3)))
(assert (= T2_3 var_0xINPUT_96358))
(assert (= T1_3 ""))

; Tie the seed input to an email string
(assert (= email T_1))

; --- Email validation constraints using '@' and '.' delimiters ---
; Must have exactly one '@' -> num_splits(email,"@") = 2 segments
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part constraints (non-empty, no spaces)
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))

; Domain constraints: must contain at least one '.' => at least 2 segments after split
(assert (= domain_has_dot (>= (num_splits domain ".") 2)))
(assert domain_has_dot)

; Extract some domain labels and tld
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Labels and tld non-empty, no spaces
(assert (> (str.len domain_label0) 0))
(assert (> (str.len tld) 0))
(assert (not (str.contains domain " ")))

; Ban empty labels by forbidding consecutive dots and leading/trailing dot patterns (sound but not complete)
(assert (not (str.contains domain "..")))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Some sanity about overall email
(assert (= email_has_at (str.contains email "@")))
(assert email_has_at)
(assert (not (str.contains email "@@")))

; --- Force an UNSAT instance by requiring local part to contain '@' while having exactly one '@' total ---
; If local contains '@', then email must contain at least two '@' (one inside local plus the delimiter), contradicting num_splits=email has exactly one '@'.
(assert (str.contains local "@"))

; Keep boolean wrapper from seed (now asserting a property about the email)
(assert (= T_2 (= "-" email)))
(assert (not T_2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
