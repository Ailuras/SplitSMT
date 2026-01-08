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

; Email Validation scenario using str_split interface

; --- Uninterpreted split interface ---

; --- Core variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_head String)
(declare-const tld String)
(declare-const second_level String)

; Indices used for split operations
(declare-const k0 Int)
(declare-const k1 Int)

; --- Basic index/natural constraints (interface discipline) ---
(assert (= k0 0))
(assert (= k1 1))
(assert (>= k0 0))
(assert (>= k1 0))

; --- High-level structure: local@domain ---
(assert (>= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Disallow empty local/domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Simple sanity constraints on email string itself
(assert (not (str.contains email " ")))
(assert (not (str.contains email "\n")))
(assert (not (str.contains email "\t")))

; Local-part: must not contain '@', but can contain '.' (not fully RFC)
(assert (not (str.contains local "@")))
; Domain must not contain '@'
(assert (not (str.contains domain "@")))

; --- Domain structure: at least one dot, extract head and tld ---
(assert (>= (num_splits domain ".") 2))
(assert (= domain_head (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))

; Domain labels must be non-empty
(assert (> (str.len domain_head) 0))
(assert (> (str.len tld) 0))

; Enforce no leading/trailing dot in domain by requiring first label and last part non-empty
; (already implied above, but repeated explicitly for clarity)
(assert (not (= domain_head "")))
(assert (not (= tld "")))

; Further constrain: tld must itself contain at most one dot (i.e., either "com" or "co.uk" style)
(assert (or (= (num_splits tld ".") 1)
            (= (num_splits tld ".") 2)))

; If tld has two labels, extract second-level and final label; otherwise second_level is whole tld
(assert (= second_level (split_at tld "." 0)))

; Ensure all labels in tld are non-empty
(assert (> (str.len (split_at tld "." 0)) 0))
(assert (=> (= (num_splits tld ".") 2)
            (> (str.len (split_at tld "." 1)) 0)))

; Additional mild restrictions: local and domain should be reasonably short
(assert (<= (str.len local) 64))
(assert (<= (str.len domain) 255))

; --- SAT instance witness constraints (choose a concrete-valid email) ---
(declare-const sat_email String)
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_tld String)
(assert (= sat_email "alice.smith+tag@sub.example.co.uk"))
(assert (>= (num_splits sat_email "@") 2))
(assert (= sat_local (split_at sat_email "@" 0)))
(assert (= sat_domain (split_at sat_email "@" 1)))
(assert (>= (num_splits sat_domain ".") 2))
(assert (= sat_tld (split_rest sat_domain "." 1)))
(assert (> (str.len sat_local) 0))
(assert (> (str.len sat_domain) 0))
(assert (not (str.contains sat_email " ")))

; --- UNSAT instance: contradictory requirements on a single email ---
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(assert (= bad_email "bob@example.com"))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))
; Contradiction: require domain to have at least one dot and also no dots at all
(assert (>= (num_splits bad_domain ".") 2))
(assert (= (num_splits bad_domain ".") 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
