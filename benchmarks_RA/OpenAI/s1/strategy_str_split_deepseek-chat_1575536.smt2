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
; Email Validation scenario using str_split and regex

; --- split interface ---

; --- variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const domain_tld String)
(declare-const at_count Int)
(declare-const dot_count Int)

; --- basic split constraints for '@' ---
(assert (= at_count (num_splits email "@")))
(assert (= at_count 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; local part should not contain '@'
(assert (= (num_splits local "@") 1))

; domain must contain at least one '.' and have at least two labels
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))
(assert (= domain_first (split_at domain "." 0)))
(assert (>= (str.len domain_first) 1))

; last segment (TLD) should be length 2 or 3 (e.g., com, io)
(assert (= domain_tld (split_at domain "." (- dot_count 1))))
(assert (or (= (str.len domain_tld) 2) (= (str.len domain_tld) 3)))

; no empty segments in domain: reject leading, trailing, or consecutive dots
(assert (not (= domain_first "")))
(assert (not (= domain_tld "")))
(assert (not (str.contains domain "..")))

; forbid consecutive '@' (implied by at_count=2, but kept as structure)
(assert (not (str.contains email "@@")))

; --- regex constraints (mutated/extended from seed style) ---
; allow only a limited safe alphabet: letters, digits, '.', '_', '-', '@'
(declare-const allowed_re RegLan)
(assert (= allowed_re
  (re.*
    (re.union
      (re.range "a" "z")
      (re.union
        (re.range "A" "Z")
        (re.union
          (re.range "0" "9")
          (re.union (str.to_re ".")
            (re.union (str.to_re "_")
              (re.union (str.to_re "-") (str.to_re "@")))))))))
)
(assert (str.in_re email allowed_re))

; enforce exactly one '@' via split, plus ensure local/domain are not empty
(assert (not (= local "")))
(assert (not (= domain "")))

; local cannot start/end with '.' and cannot contain consecutive '.'
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; domain cannot start/end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; additional domain structure: the rest after first label must start with '.'
; (helps ensure split is consistent with presence of '.')
(assert (str.contains (split_rest domain "." 1) "."))

; --- UNSAT branch to ensure diversity: cannot have two distinct required TLD lengths simultaneously ---
(declare-const force_unsat Bool)
(assert (= force_unsat true))
(assert (=> force_unsat (and (= (str.len domain_tld) 2) (= (str.len domain_tld) 3))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
