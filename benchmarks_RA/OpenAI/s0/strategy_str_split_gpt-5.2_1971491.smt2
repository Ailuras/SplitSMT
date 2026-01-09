(set-logic ALL)

; Email Validation via str_split: using '@' and '.' delimiters

; --- Uninterpreted interface for string split ---
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

; --- Common helpers ---
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_first String)
(declare-const tld String)
(declare-const tld2 String)
(declare-const reconstructed String)

; Basic decomposition around '@'
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (<= (num_splits email "@") 2))

; Reconstruction sanity: local@domain
(assert (= reconstructed (str.++ local_part "@" domain)))
(assert (= email reconstructed))

; Local part constraints
(assert (>= (str.len local_part) 1))
(assert (not (str.contains local_part " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains local_part "..")))

; Domain constraints: must contain at least one '.' and no spaces
(assert (>= (str.len domain) 3))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))
(assert (>= (num_splits domain ".") 2))

; Extract first domain label and last label (TLD)
(assert (= domain_first (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len domain_first) 1))
(assert (>= (str.len tld) 2))

; Ensure domain labels are non-empty at extremes and no consecutive dots
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Require TLD to be lowercase letters only, length 2..6
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; --- SAT instance constraints (a concrete satisfiable example) ---
(declare-const sat_email String)
(declare-const sat_local String)
(declare-const sat_domain String)
(declare-const sat_tld String)
(assert (= sat_email "alice.smith+tag@example.co"))
(assert (= sat_local (split_at sat_email "@" 0)))
(assert (= sat_domain (split_at sat_email "@" 1)))
(assert (= sat_tld (split_at sat_domain "." (- (num_splits sat_domain ".") 1))))
(assert (= (num_splits sat_email "@") 2))
(assert (>= (num_splits sat_domain ".") 2))
(assert (>= (str.len sat_local) 1))
(assert (str.in_re sat_tld (re.+ (re.range "a" "z"))))

; --- UNSAT instance constraints (deliberate contradiction) ---
; This block asserts an email with two '@' but simultaneously constrains exactly one '@' split.
(declare-const unsat_email String)
(declare-const unsat_local String)
(declare-const unsat_domain String)
(assert (= unsat_email "bad@@example.com"))
(assert (= unsat_local (split_at unsat_email "@" 0)))
(assert (= unsat_domain (split_at unsat_email "@" 1)))
(assert (= (num_splits unsat_email "@") 2))
(assert (>= (num_splits unsat_email "@") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
