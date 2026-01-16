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


; -------------------------
; SAT instance: valid-ish email with structured domain
; -------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_labels_sat Int)
(declare-const tld_sat String)

(assert (= email_sat "john.doe+tag@sub.example.co"))

; Exactly one '@' => two segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part constraints (simple shape properties)
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))

; Domain constraints: contains dots, at least 3 labels (sub + example + tld parts)
(assert (not (str.contains domain_sat "@")))
(assert (>= (str.len domain_sat) 3))
(assert (>= (num_splits domain_sat ".") 3))
(assert (= domain_labels_sat (num_splits domain_sat ".")))

; TLD is last label, length >= 2
(assert (= tld_sat (split_at domain_sat "." (- domain_labels_sat 1))))
(assert (>= (str.len tld_sat) 2))

; No empty labels: each of first three labels has length >= 1 (sufficient for this instance)
(assert (>= (str.len (split_at domain_sat "." 0)) 1))
(assert (>= (str.len (split_at domain_sat "." 1)) 1))
(assert (>= (str.len (split_at domain_sat "." 2)) 1))

; Domain begins with first label and a dot, i.e., first label is a prefix before '.'
(assert (str.prefixof (str.++ (split_at domain_sat "." 0) ".") domain_sat))

; -------------------------
; UNSAT instance: conflicting constraints about '@' placement and segment counts
; -------------------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)

(assert (= email_unsat "alice@@example.com"))

; Force exactly one '@' split (but the concrete email has two '@')
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Additionally require domain to be a normal dotted domain with at least 2 labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (>= (str.len (split_at domain_unsat "." 0)) 1))
(assert (>= (str.len (split_at domain_unsat "." 1)) 2))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
