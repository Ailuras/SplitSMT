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

; Uninterpreted interface operations for string splitting

; Inputs / derived fields
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const user String)
(declare-const plus_tag String)
(declare-const first_label String)
(declare-const second_label String)
(declare-const tld String)
(declare-const subdomain_rest String)
(declare-const domain_dot_count Int)
(declare-const at_count Int)

; Basic split-derived structure
(assert (= at_count (num_splits email "@")))
(assert (>= at_count 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Require at least one '.' in the domain (so at least 2 dot-separated segments)
(assert (= domain_dot_count (num_splits domain ".")))
(assert (>= domain_dot_count 2))

; Local-part rules: allow optional plus-tagging, require non-empty user
(assert (= user (split_at local_part "+" 0)))
(assert (= plus_tag (split_at local_part "+" 1)))
(assert (>= (str.len user) 1))

; Disallow empty local part and domain
(assert (>= (str.len local_part) 1))
(assert (>= (str.len domain) 1))

; Domain structure: label.label.tld (at least)
(assert (= first_label (split_at domain "." 0)))
(assert (= second_label (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- domain_dot_count 1))))
(assert (= subdomain_rest (split_rest domain "." 1)))

; Basic non-emptiness of required labels
(assert (>= (str.len first_label) 1))
(assert (>= (str.len second_label) 1))
(assert (>= (str.len tld) 2))

; No spaces or extra '@' in local or domain parts
(assert (not (str.contains local_part " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local_part "@")))
(assert (not (str.contains domain "@")))

; Basic shape: must contain '@' and at least one '.' after it
(assert (str.contains email "@"))
(assert (str.contains domain "."))

; Provide a SAT instance via an explicit example that satisfies the above constraints
(assert (= email "alice+tag@sub.example.com"))

; Additional constraints on the chosen example to exercise split operations
(assert (= local_part "alice+tag"))
(assert (= domain "sub.example.com"))
(assert (= first_label "sub"))
(assert (= tld "com"))

; Create an UNSAT instance alongside (separate email) to ensure diversity
(declare-const bad_email String)
(declare-const bad_at_count Int)
(declare-const bad_domain String)
(declare-const bad_domain_dot_count Int)
(declare-const bad_tld String)

; Define a concrete invalid email: missing '.' in domain but demanded by constraints
(assert (= bad_email "bob@localhost"))
(assert (= bad_at_count (num_splits bad_email "@")))
(assert (>= bad_at_count 2))
(assert (= bad_domain (split_at bad_email "@" 1)))
(assert (= bad_domain_dot_count (num_splits bad_domain ".")))

; UNSAT trigger: require at least one '.' in domain but bad_domain has none
(assert (>= bad_domain_dot_count 2))
(assert (= bad_tld (split_at bad_domain "." (- bad_domain_dot_count 1))))
(assert (>= (str.len bad_tld) 2))



; [GENERATION STATUS: SUCCESS]
(assert (= subdomain_rest ""))
(assert (= bad_tld "BC"))
(assert (= email "alice+tag@sub.example.com"))
(assert (= at_count 2))
(assert (= domain "sub.example.com"))
(assert (= tld "com"))
(assert (= plus_tag "alice+tag"))
(assert (= bad_at_count 2))
(assert (= bad_domain_dot_count 2439))
(assert (= bad_email "bob@localhost"))
(assert (= bad_domain "a"))
(assert (= first_label "sub"))
(assert (= second_label "A"))
(assert (= domain_dot_count 21240))
(assert (= user "D"))
(assert (= local_part "alice+tag"))
(check-sat)
(exit)
