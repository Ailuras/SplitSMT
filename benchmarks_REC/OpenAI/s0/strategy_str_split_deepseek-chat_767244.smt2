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

; Uninterpreted interface for string split

; ------------ SAT instance: plausible email validation -------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const host_sat String)
(declare-const domain_label0_sat String)
(declare-const domain_label1_sat String)
(declare-const local_len_sat Int)
(declare-const tld_len_sat Int)

; Basic split around '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= (num_splits email_sat "@") 2))
(assert (= (split_rest email_sat "@" 1) domain_sat))

; Local-part constraints: non-empty, no spaces, no consecutive dots, basic allowed chars
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))
(assert (str.in_re local_sat (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re "."))) (re.* (str.to_re "")))))

; Domain constraints: must contain at least one dot, no consecutive dots, no spaces
(assert (str.contains domain_sat "."))
(assert (not (str.contains domain_sat "..")))
(assert (not (str.contains domain_sat " ")))

; Split domain by '.' with at least two labels (host + tld)
(assert (>= (num_splits domain_sat ".") 2))
(assert (= domain_label0_sat (split_at domain_sat "." 0)))
(assert (= domain_label1_sat (split_at domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))
(assert (= host_sat (split_rest domain_sat "." 0)))

; Domain labels should be non-empty and avoid leading/trailing hyphen for first label
(assert (> (str.len domain_label0_sat) 0))
(assert (> (str.len domain_label1_sat) 0))
(assert (not (= (str.at domain_label0_sat 0) "-")))
(assert (not (= (str.at domain_label0_sat (- (str.len domain_label0_sat) 1)) "-")))

; TLD constraints: length 2..10 and alphabetic only
(assert (= tld_len_sat (str.len tld_sat)))
(assert (and (>= tld_len_sat 2) (<= tld_len_sat 10)))
(assert (str.in_re tld_sat (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Entire email basic structure must match local@domain syntactically
(assert (= email_sat (str.++ local_sat "@" domain_sat)))

; Add a concrete satisfying example to anchor SAT
(assert (= email_sat "alice.smith_01@example-domain.com"))

; ------------ UNSAT instance: contradictory requirements -------------
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= (num_splits email_unsat "@") 2))
(assert (= email_unsat (str.++ local_unsat "@" domain_unsat)))

; Force a concrete email with exactly one '.' in the domain (two labels)
(assert (= email_unsat "bob@host.com"))
(assert (= domain_unsat "host.com"))
(assert (= (num_splits domain_unsat ".") 2))
(assert (= tld_unsat (split_at domain_unsat "." 1)))

; Contradiction: require at least 3 labels in the domain (impossible with above)
(assert (>= (num_splits domain_unsat ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
