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

; Email Validation via split constraints and string reasoning

; --- str_split interface (uninterpreted) ---

; --- Common constants ---
(declare-const at_delim String)
(declare-const dot_delim String)
(assert (= at_delim "@"))
(assert (= dot_delim "."))

; =====================
; SAT instance: complex email must satisfy structural constraints
; =====================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const domain_name_sat String)
(declare-const tld_sat String)
(declare-const first_label_sat String)
(declare-const second_label_sat String)
(declare-const domain_tail_sat String)

; Split around '@' into exactly 2 segments: local and domain
(assert (= local_sat (split_at email_sat at_delim 0)))
(assert (= domain_sat (split_at email_sat at_delim 1)))
(assert (= 2 (num_splits email_sat at_delim)))

; Local-part constraints: non-empty, no '@', no leading/trailing '.', no consecutive '..'
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat at_delim)))
(assert (not (str.prefixof "." local_sat)))
(assert (not (str.suffixof "." local_sat)))
(assert (not (str.contains local_sat "..")))

; Domain constraints: non-empty, no '@', not start/end with '.', no consecutive '..'
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains domain_sat at_delim)))
(assert (not (str.prefixof "." domain_sat)))
(assert (not (str.suffixof "." domain_sat)))
(assert (not (str.contains domain_sat "..")))

; Domain must have at least one dot: at least 2 labels
(assert (>= (num_splits domain_sat dot_delim) 2))

; Extract last label as TLD and the rest as domain_name
; For at least 2 labels, using split_at for first two plus split_rest for tail
(assert (= first_label_sat (split_at domain_sat dot_delim 0)))
(assert (= second_label_sat (split_at domain_sat dot_delim 1)))
(assert (= domain_tail_sat (split_rest domain_sat dot_delim 1)))

; TLD as last segment: if exactly 2 labels then second is tld, else tld is last of tail
; Constrain to 2 or 3 labels for this SAT instance to keep tail manageable
(assert (or (= (num_splits domain_sat dot_delim) 2)
            (= (num_splits domain_sat dot_delim) 3)))

(declare-const third_label_sat String)
(assert (= third_label_sat (split_at domain_sat dot_delim 2)))
(assert (= tld_sat (ite (= (num_splits domain_sat dot_delim) 2)
                        second_label_sat
                        third_label_sat)))

; domain_name_sat is everything except last label (for 2 labels, first; for 3, first.second)
(assert (= domain_name_sat (ite (= (num_splits domain_sat dot_delim) 2)
                                first_label_sat
                                (str.++ first_label_sat dot_delim second_label_sat))))

; Label constraints: labels non-empty, do not contain '.'
(assert (> (str.len first_label_sat) 0))
(assert (not (str.contains first_label_sat dot_delim)))
(assert (> (str.len second_label_sat) 0))
(assert (not (str.contains second_label_sat dot_delim)))
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (not (str.contains tld_sat dot_delim)))

; Use regex to restrict TLD to letters only [A-Za-z]{2,24}
(assert (str.in_re tld_sat (re.++ (re.union (re.range "A" "Z") (re.range "a" "z"))
                                 (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))
; Also enforce min length 2 via length constraint above

; Email should not contain spaces
(assert (not (str.contains email_sat " ")))

; Provide a concrete witness form to ensure satisfiable (one of many)
(assert (= email_sat "user.name+tag@sub.example.com"))


; =====================
; UNSAT instance: contradictions in domain structure and segment counts
; =====================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)

(assert (= local_unsat (split_at email_unsat at_delim 0)))
(assert (= domain_unsat (split_at email_unsat at_delim 1)))

; Force exactly two segments at '@'
(assert (= 2 (num_splits email_unsat at_delim)))

; But also force email to have no '@' at all (contradiction under intended semantics)
(assert (not (str.contains email_unsat at_delim)))

; Additionally, constrain domain to have at least one dot and no dots simultaneously (extra contradiction)
(assert (>= (num_splits domain_unsat dot_delim) 2))
(assert (not (str.contains domain_unsat dot_delim)))

; TLD extracted as last split (inconsistent with "no dots")
(assert (= tld_unsat (split_at domain_unsat dot_delim 1)))
(assert (>= (str.len tld_unsat) 2))

; Fix email_unsat to a string without '@' and without '.'
(assert (= email_unsat "invalid_email"))




; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
