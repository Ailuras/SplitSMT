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

; Email Validation scenario using str_split interface with '@' and '.' delimiters


(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const second_level String)
(declare-const rest_after_at String)
(declare-const first_dot_seg String)
(declare-const remainder_from_dot String)
(declare-const at_count Int)
(declare-const dot_count Int)
(declare-const local_len Int)
(declare-const domain_len Int)
(declare-const tld_len Int)

; Core split structure
(assert (= local (split_at email "@" 0)))
(assert (= rest_after_at (split_rest email "@" 1)))
(assert (= domain (split_at email "@" 1)))
(assert (= at_count (num_splits email "@")))

; Exactly one '@' => two segments
(assert (= at_count 2))

; Domain split by '.'
(assert (= first_dot_seg (split_at domain "." 0)))
(assert (= remainder_from_dot (split_rest domain "." 1)))
(assert (= second_level (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))
(assert (= dot_count (num_splits domain ".")))

; Require at least one '.' in domain => at least two segments
(assert (>= dot_count 2))

; Basic non-emptiness
(assert (> (str.len email) 5))
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (= tld_len (str.len tld)))
(assert (>= local_len 1))
(assert (>= domain_len 3))
(assert (>= tld_len 2))

; No spaces in local or domain (approximate by forbidding contains)
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))

; Local part should not start or end with '.'
(assert (or (= local "") (not (= (str.at local 0) "."))))
(assert (or (= local "") (not (= (str.at local (- (str.len local) 1)) "."))))

; Domain should not start or end with '.'
(assert (or (= domain "") (not (= (str.at domain 0) "."))))
(assert (or (= domain "") (not (= (str.at domain (- (str.len domain) 1)) "."))))

; Disallow consecutive dots in domain by forbidding ".." occurrence
(assert (not (str.contains domain "..")))

; Constrain email by a loose regex: must contain '@' somewhere and at least one '.' after it
; This does not fully validate RFC rules; it enforces presence/ordering.
(assert (str.in_re email (re.++ (re.* re.allchar)
                               (str.to_re "@")
                               (re.* re.allchar)
                               (str.to_re ".")
                               (re.* re.allchar))))

; Negative examples (preserve seed-like exclusions but adapted to email context)
(assert (not (= email "")))
(assert (not (= email "a@b")))
(assert (not (= email "@example.com")))
(assert (not (= email "user@.com")))
(assert (not (= email "user@example..com")))
(assert (not (= email "user@@example.com")))
(assert (not (= email "user example@example.com")))

; SAT branch: enforce a concrete valid-ish structure while leaving content flexible
(assert (= tld "com"))
(assert (>= (str.len second_level) 1))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
