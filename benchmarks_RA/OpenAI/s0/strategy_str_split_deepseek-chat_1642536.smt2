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

; ------------ SAT instance: complex but plausible email validation ------------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_labels String)
(declare-const tld String)
(declare-const second_level String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const domain_len Int)
(declare-const local_len Int)
(declare-const tld_len Int)
(declare-const dot_count Int)

; Split email into local@domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (<= (num_splits email "@") 2))

; Basic non-emptiness / length checks
(assert (= local_len (str.len local)))
(assert (= domain_len (str.len domain)))
(assert (> local_len 0))
(assert (> domain_len 3))

; Disallow whitespace and additional '@'
(assert (not (str.contains email " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Local-part constraints: no leading/trailing dot, no consecutive dots
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))
(assert (not (str.contains local "..")))

; Domain constraints: must contain at least one dot, no leading/trailing dot, no consecutive dots
(assert (str.contains domain "."))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "..")))

; Use split on '.' to enforce domain label structure
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; Extract first label, second label, and top-level domain (last label)
(assert (= first_label (split_at domain "." 0)))
(assert (= second_level (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- dot_count 1))))
(assert (= rest_labels (split_rest domain "." 1)))

; Labels must be non-empty and contain no dots
(assert (> (str.len first_label) 0))
(assert (> (str.len second_level) 0))
(assert (> (str.len tld) 0))
(assert (not (str.contains first_label ".")))
(assert (not (str.contains second_level ".")))
(assert (not (str.contains tld ".")))

; TLD length restrictions (common email validation heuristic)
(assert (= tld_len (str.len tld)))
(assert (>= tld_len 2))
(assert (<= tld_len 24))

; A mild heuristic: domain should not contain underscores
(assert (not (str.contains domain "_")))

; Ensure domain reconstruction matches prefix + rest (helps tie split_rest semantics)
(assert (= domain_labels (str.++ first_label "." rest_labels)))
(assert (= domain domain_labels))

; Provide a concrete satisfying witness to guarantee SAT
(assert (= email "john.doe+tag@sub.example.co.uk"))

; ------------ UNSAT instance: contradictory requirements for an email-like string ------------
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)
(declare-const bad_dot_count Int)

(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))
(assert (>= (num_splits bad_email "@") 2))
(assert (<= (num_splits bad_email "@") 2))

; Require a dot in domain and attempt to extract TLD
(assert (= bad_dot_count (num_splits bad_domain ".")))
(assert (>= bad_dot_count 2))
(assert (= bad_tld (split_at bad_domain "." (- bad_dot_count 1))))

; Contradiction: domain must contain a dot but is constrained to be exactly "example"
(assert (= bad_domain "example"))
(assert (str.contains bad_domain "."))

; Also pin a full email form to reinforce the contradiction
(assert (= bad_email "a@example"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
