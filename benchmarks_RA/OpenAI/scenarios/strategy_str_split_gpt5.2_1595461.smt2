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

; Uninterpreted interface for string split constraints

; ----------------------------
; SAT instance: plausible complex email validation
; ----------------------------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const domain_label1 String)
(declare-const domain_rest2 String)
(declare-const tld String)

; Basic structure: local@domain
(assert (>= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_rest email "@" 2)))

; local-part constraints: non-empty, no spaces, no '@', contains a '.' (complexity)
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (str.contains local "."))

; domain constraints: non-empty, no spaces, contains at least one dot
(assert (> (str.len domain) 0))
(assert (not (str.contains domain " ")))
(assert (str.contains domain "."))

; Domain split by '.' => at least 2 labels; constrain first three labels for structure
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_rest1 (split_rest domain "." 1)))
(assert (= domain_label1 (split_at domain "." 1)))
(assert (= domain_rest2 (split_rest domain "." 2)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Label constraints: non-empty and no illegal separators
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 1))
(assert (not (str.contains domain_label0 "@")))
(assert (not (str.contains domain_label0 ".")))
(assert (not (str.contains domain_label1 "@")))
(assert (not (str.contains domain_label1 ".")))
(assert (not (str.contains tld "@")))
(assert (not (str.contains tld ".")))

; Ensure there is no trailing dot and no empty last segment
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Force a concrete satisfying example (keeps this instance SAT)
(assert (= email "first.last@sub.example.co"))

; ----------------------------
; UNSAT instance: contradictory domain structure
; ----------------------------
(declare-const email_bad String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)
(declare-const bad_label0 String)

(assert (>= (num_splits email_bad "@") 2))
(assert (= bad_local (split_at email_bad "@" 0)))
(assert (= bad_domain (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))

; Require a dot in the domain, but also assert domain has exactly one segment when split by '.' (contradiction)
(assert (str.contains bad_domain "."))
(assert (= (num_splits bad_domain ".") 1))

; Additional constraints (consistent by themselves)
(assert (> (str.len bad_local) 0))
(assert (not (str.contains bad_local " ")))
(assert (= bad_label0 (split_at bad_domain "." 0)))
(assert (= bad_tld (split_at bad_domain "." (- (num_splits bad_domain ".") 1))))
(assert (> (str.len bad_tld) 1))

; Anchor to a concrete email that still cannot satisfy the contradictory split constraints
(assert (= email_bad "a@b.c"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
