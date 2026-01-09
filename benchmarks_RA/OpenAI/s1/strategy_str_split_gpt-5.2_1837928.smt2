(set-logic ALL)

; Email Validation scenario with split-based constraints and regex structure

; --- str_split interface ---
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

; --- Core strings ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const leftmost String)
(declare-const reconstructed String)

; --- Regex building blocks (mutated from seed) ---
(declare-const local_re RegLan)
(declare-const label_re RegLan)
(declare-const domain_re RegLan)
(declare-const email_re RegLan)

; Split constraints using '@' and '.' delimiters
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= reconstructed (str.++ local "@" domain)))
(assert (= email reconstructed))
(assert (= (num_splits email "@") 2))

; Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))
(assert (= leftmost (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Index bounds / naturality (interface discipline)
(assert (>= (num_splits domain ".") 2))
(assert (>= (- (num_splits domain ".") 1) 0))

; Local and domain must be non-empty
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))
(assert (>= (str.len tld) 2))

; Disallow spaces and additional '@'
(assert (not (str.contains email " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

; Disallow empty labels: no leading '.', no trailing '.', no '..'
(assert (not (= (split_at domain "." 0) "")))
(assert (not (= tld "")))
(assert (not (str.contains domain "..")))

; Regex for local part: [A-Za-z0-9_+.-]+ but not starting or ending with '.'
(assert (= local_re
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".") ))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
  )))

; Regex for a domain label: [A-Za-z0-9]([A-Za-z0-9-]*[A-Za-z0-9])?
(assert (= label_re
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.opt
      (re.++
        (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
      ))
  )))

; Domain regex: label ('.' label)+
(assert (= domain_re
  (re.++
    label_re
    (re.+ (re.++ (str.to_re ".") label_re))
  )))

; Full email regex
(assert (= email_re (re.++ local_re (str.to_re "@") domain_re)))
(assert (str.in_re email email_re))

; Additional semantic constraints: leftmost label can't start with '-' and tld must be alphabetic-only
(assert (not (str.contains leftmost "-")))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Create both SAT and UNSAT pressure: enforce a dot in local, but also forbid any '.' in local -> UNSAT
(assert (str.contains local "."))
(assert (not (str.contains local ".")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
