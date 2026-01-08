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

; --- Uninterpreted interface: str_split ---

; --- Helpers (uninterpreted, non-primitive) ---
(declare-fun isLowerAlphaNum (String) Bool)
(declare-fun isLabelChar (String) Bool)

; =====================
; SAT instance: complex-ish email validation
; =====================
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const second_level_ok String)
(declare-const subdomain_ok String)

; Split at '@' must yield at least 2 segments, and we validate first two explicitly
(assert (>= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Local part constraints: non-empty, no '@', and made of allowed characters (abstracted)
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains local_ok " ")))
(assert (isLowerAlphaNum local_ok))

; Domain must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain_ok ".") 2))

; Constrain a 3-label domain: subdomain.secondlevel.tld
(assert (= subdomain_ok (split_at domain_ok "." 0)))
(assert (= second_level_ok (split_at domain_ok "." 1)))
(assert (= tld_ok (split_at domain_ok "." 2)))
(assert (>= (num_splits domain_ok ".") 3))

; No empty labels
(assert (> (str.len subdomain_ok) 0))
(assert (> (str.len second_level_ok) 0))
(assert (> (str.len tld_ok) 0))

; Basic label structure: no spaces and abstracted allowed characters
(assert (not (str.contains domain_ok " ")))
(assert (isLabelChar subdomain_ok))
(assert (isLabelChar second_level_ok))
(assert (isLabelChar tld_ok))

; TLD length constraint typical for validation
(assert (and (>= (str.len tld_ok) 2) (<= (str.len tld_ok) 24)))

; Enforce reconstructability via split_rest to connect structure
(assert (= (split_rest domain_ok "." 1) (str.++ second_level_ok "." tld_ok)))

; Concrete witness to ensure satisfiable
(assert (= email_ok "alice123@mx.example.com"))

; =====================
; UNSAT instance: contradictory email requirements
; =====================
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

(assert (= email_bad "bob@site.com"))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain split: for "site.com", the TLD is "com" (length 3)
(assert (= tld_bad (split_at domain_bad "." 1)))
(assert (>= (num_splits domain_bad ".") 2))

; Contradiction: demand TLD length 2 and also equal to "com"
(assert (= tld_bad "com"))
(assert (= (str.len tld_bad) 2))

; Additional contradiction: claim there are at least 3 labels in "site.com"
(assert (>= (num_splits domain_bad ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
