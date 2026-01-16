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

; --- Uninterpreted interface for string splitting ---

; --- Seed booleans preserved and repurposed ---
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)

; --- Email validation variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const first_label String)
(declare-const tld String)
(declare-const dot_tail String)

; --- Seed structure mutated to relate to email instead of literal "-" ---
(assert (= T_1 (= "-" email)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" email)))
(assert (= T_4 (not T_3)))
(assert T_4)

; --- Core email split constraints using '@' ---
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (num_splits email "@") 2))

; local and domain must be non-empty
(assert (not (= local "")))
(assert (not (= domain "")))

; local part should not contain '@'
(assert (not (str.contains local "@")))

; --- Domain structure using '.' delimiter ---
; Require at least one dot in the domain: e.g., "example.com" or "mail.example.co"
(assert (>= (num_splits domain ".") 2))

; Define first label and TLD as first and last segments
(assert (= first_label (split_at domain "." 0)))
(assert (not (= first_label "")))

; dot_tail is everything after the first label
(assert (= dot_tail (split_rest domain "." 1)))
(assert (not (= dot_tail "")))

; Ensure dot_tail itself has at least one segment (always true if non-empty, but keeps structure explicit)
(assert (>= (num_splits dot_tail ".") 1))

; Constrain TLD via taking the last segment indirectly:
; If dot_tail has exactly 1 segment, that segment is the TLD.
(assert (=> (= (num_splits domain ".") 2)
            (= tld (split_at domain "." 1))))

; If dot_tail has at least 2 segments, the last segment is split_at dot_tail "." (num_splits dot_tail "." - 1)
(assert (=> (>= (num_splits domain ".") 3)
            (= tld (split_at dot_tail "." (- (num_splits dot_tail ".") 1)))))

; TLD non-empty and length constraints (2..24)
(assert (not (= tld "")))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; --- Additional consistency constraints ---
; Email must contain '@' as a delimiter and not start/end with it (approximated by non-empty parts already)
(assert (str.contains email "@"))

; Disallow domain starting with '.' (approximated by first_label non-empty) and disallow consecutive dots in domain
(assert (not (str.contains domain "..")))

; Disallow local starting or ending with '.' (approximated by not having '.' at edges using substr/at)
(assert (=> (>= (str.len local) 1)
            (and (not (= (str.at local 0) "."))
                 (not (= (str.at local (- (str.len local) 1)) ".")))))

; --- Include an UNSAT branch as a separate instance inside the same file via a contradiction trigger ---
; If email equals "a@b.c" then require TLD length >= 5, contradicting "c".
(assert (=> (= email "a@b.c") (>= (str.len tld) 5)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
