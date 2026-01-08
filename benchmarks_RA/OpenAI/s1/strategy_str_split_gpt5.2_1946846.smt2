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

; Scenario: Email Validation using str_split interface

; Uninterpreted split interface

; Email and derived parts
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const tld String)

; Extra variables retained/mutated from seed to preserve structure diversity
(declare-const key1 String)
(declare-const key2 String)
(declare-const value1 String)
(declare-const value2 String)

; Core email split constraints: one '@', domain has at least one '.'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= 2 (num_splits email "@")))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Domain structure with '.' delimiter
(assert (>= (num_splits domain ".") 2))
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_rest1 (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Basic segment validity
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; No empty labels: forbid consecutive dots and leading/trailing dot
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Local-part restrictions: no spaces, no consecutive dots, cannot start/end with dot
(assert (not (str.contains local " ")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Ensure '@' not present in either part (reinforces split correctness)
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; TLD character policy (approx): must be lowercase alpha only using regex
(assert (str.in_re tld (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z")))))

; Mutated seed-like noise constraints (kept but aligned with email flavor)
(assert (and
  (not (= (ite (= key1 "cache-control") 1 0) 0))
  (not (= (ite (= key2 "cache-control") 1 0) 0))
  (not (not (= (ite (str.contains value1 "=") 1 0) 0)))
  (not (= (ite (= (str.indexof value1 "=" 0) (- 1)) 1 0) 0))
  (>= (+ (str.indexof value1 "=" 0) 1) 0)
  (>= (- (str.len value1) (+ (str.indexof value1 "=" 0) 1)) 0)
  (not (not (= (ite (= (str.len value2) 0) 1 0) 0)))
  (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))
  (not (str.contains value2 "@"))
))

; UNSAT twist: require exactly 2 labels in domain but also require a third label exists
(assert (= (num_splits domain ".") 2))
(assert (>= (num_splits domain ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
