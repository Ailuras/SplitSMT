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

; --- Uninterpreted interface functions for str_split ---

; --- Email validation scenario: SAT instance ---
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const sld_ok String)
(declare-const first_label_ok String)
(declare-const rest_labels_ok String)

; Split around '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= "" (split_rest email_ok "@" 2)))
(assert (= (num_splits email_ok "@") 2))

; Local-part constraints: non-empty, no '@', no spaces
(assert (>= (str.len local_ok) 1))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))

; Domain constraints: must contain '.', not start/end with '.', non-empty labels
(assert (>= (str.len domain_ok) 3))
(assert (>= (num_splits domain_ok ".") 2))
(assert (not (= (split_at domain_ok "." 0) "")))
(assert (not (= (split_at domain_ok "." (- (num_splits domain_ok ".") 1)) "")))

; Bind last two labels (SLD and TLD) using indices derived from num_splits
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (= sld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 2))))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 15))

; Require at least one label before the SLD (i.e., allow subdomains but not mandatory)
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (not (= first_label_ok "")))

; Domain labels must avoid spaces and '@'
(assert (not (str.contains domain_ok " ")))
(assert (not (str.contains domain_ok "@")))

; Restrict TLD to letters only
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Ensure local part begins with an alnum and contains only allowed characters (simplified)
(assert (str.in_re local_ok (re.++ (re.union (re.range "a" "z") (re.range "0" "9"))
                                   (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "+"))))))

; Ensure each label in domain is alnum/hyphen and does not start/end with hyphen (approx via regex for whole domain)
(declare-const domain_label_re RegLan)
(assert (= domain_label_re (re.++ (re.union (re.range "a" "z") (re.range "0" "9"))
                                   (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
                                   (re.union (re.range "a" "z") (re.range "0" "9")))))
(declare-const domain_re RegLan)
(assert (= domain_re (re.++ domain_label_re (re.* (re.++ (str.to_re ".") domain_label_re)))))
(assert (str.in_re domain_ok domain_re))

; Provide a concrete satisfying witness for the SAT part
(assert (= email_ok "john.doe+1@sub.example.com"))

; --- Email validation scenario: UNSAT instance ---
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Split around '@'
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))
(assert (= (num_splits email_bad "@") 2))

; Force a specific email with a one-letter TLD, while requiring TLD length >= 2 (contradiction)
(assert (= email_bad "a@b.c"))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))
(assert (>= (num_splits domain_bad ".") 2))
(assert (>= (str.len tld_bad) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
