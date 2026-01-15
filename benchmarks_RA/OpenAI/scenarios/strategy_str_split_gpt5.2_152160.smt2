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

; Uninterpreted interface for string splitting

; Email validation variables
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const sld_sat String)
(declare-const left_of_dot_sat String)
(declare-const remainder_dot_sat String)

; Additional components for subdomain reasoning
(declare-const first_label_sat String)
(declare-const after_first_label_sat String)

; UNSAT instance variables
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const domain_label0_unsat String)
(declare-const tld_unsat String)

; -----------------------------
; SAT instance: should be satisfiable
; Intuition: local@sub.example.com with strong structural constraints
; -----------------------------

; Basic split at '@'
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (= 2 (num_splits email_sat "@")))

; Local part constraints
(assert (>= (str.len local_sat) 1))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "..")))
(assert (not (= (str.at local_sat 0) ".")))
(assert (not (= (str.at local_sat (- (str.len local_sat) 1)) ".")))

; Domain part constraints (must contain at least two '.'-separated labels)
(assert (>= (num_splits domain_sat ".") 2))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat " ")))
(assert (not (str.contains domain_sat "..")))
(assert (not (= (str.at domain_sat 0) ".")))
(assert (not (= (str.at domain_sat (- (str.len domain_sat) 1)) ".")))

; Enforce a concrete, complex-looking domain structure
(assert (= first_label_sat (split_at domain_sat "." 0)))
(assert (= after_first_label_sat (split_rest domain_sat "." 1)))
(assert (>= (str.len first_label_sat) 1))
(assert (not (str.contains first_label_sat "-")))

; Split remainder into SLD and TLD, ensuring at least one dot in remainder
(assert (>= (num_splits after_first_label_sat ".") 2))
(assert (= sld_sat (split_at after_first_label_sat "." 0)))
(assert (= tld_sat (split_at after_first_label_sat "." 1)))
(assert (= remainder_dot_sat (split_rest after_first_label_sat "." 1)))

; Force exactly one dot in after_first_label_sat so tld_sat is the last label
(assert (= 2 (num_splits after_first_label_sat ".")))

; Additional constraints on SLD and TLD
(assert (>= (str.len sld_sat) 1))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (not (str.contains tld_sat "-")))
(assert (not (str.contains tld_sat ".")))

; Ensure the concatenation matches a canonical shape: local@first.sld.tld
(assert (= domain_sat (str.++ first_label_sat "." sld_sat "." tld_sat)))
(assert (= email_sat (str.++ local_sat "@" domain_sat)))

; Also constrain for realism via regex: local allowed chars (approx), domain labels allowed (approx)
(define-fun re_alnum () RegLan (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9"))))
(define-fun re_local_char () RegLan (re.union re_alnum (re.union (str.to_re "_") (re.union (str.to_re "+") (re.union (str.to_re "-") (str.to_re "."))))))
(define-fun re_label_char () RegLan (re.union re_alnum (str.to_re "-")))

; local_sat: at least 1 char, no spaces already enforced, no leading/trailing dot already enforced
(assert (str.in_re local_sat (re.++ re_local_char (re.* re_local_char))))

; labels: at least 1 char for first_label_sat and sld_sat; tld length constrained
(assert (str.in_re first_label_sat (re.++ re_label_char (re.* re_label_char))))
(assert (str.in_re sld_sat (re.++ re_label_char (re.* re_label_char))))
(assert (str.in_re tld_sat (re.++ re_alnum (re.* re_alnum))))

; -----------------------------
; UNSAT instance: should be unsatisfiable
; Contradiction: enforce exactly one '@' and also force local part to contain '@'
; Additionally require domain has at least one '.' but also no '.'
; -----------------------------

(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))
(assert (= 2 (num_splits email_unsat "@")))

; Contradiction 1: local part cannot contain '@' if there is exactly one split at '@'
(assert (str.contains local_unsat "@"))

; Domain structure requirements combined with impossibility
(assert (>= (num_splits domain_unsat ".") 2))
(assert (not (str.contains domain_unsat ".")))

; Some extra constraints to make the instance look like validation logic
(assert (>= (str.len local_unsat) 1))
(assert (not (str.contains local_unsat " ")))
(assert (= domain_label0_unsat (split_at domain_unsat "." 0)))
(assert (= tld_unsat (split_at domain_unsat "." 1)))
(assert (>= (str.len tld_unsat) 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
