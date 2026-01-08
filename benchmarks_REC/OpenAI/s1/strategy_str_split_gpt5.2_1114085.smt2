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

; Uninterpreted interface for str_split

; Email validation scenario
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const rest_labels String)
(declare-const second_label String)

; Core split structure: local@domain
(assert (>= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Reject multiple '@' (UNSAT drive with other constraints below)
(assert (= (num_splits email "@") 2))

; Local part constraints
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain structure constraints using '.' delimiter
(assert (>= (num_splits domain ".") 2))
(assert (= first_label (split_at domain "." 0)))
(assert (= rest_labels (split_rest domain "." 1)))

; Ensure first domain label is non-empty and doesn't contain invalid chars
(assert (>= (str.len first_label) 1))
(assert (not (str.contains first_label "_")))
(assert (not (= (str.at first_label 0) "-")))
(assert (not (= (str.at first_label (- (str.len first_label) 1)) "-")))

; Compute TLD as last label via two-level split: rest_labels has at least one '.' or is just tld
(assert (>= (num_splits rest_labels ".") 1))
(assert (= tld (split_at rest_labels "." (- (num_splits rest_labels ".") 1))))

; TLD constraints: alphabetic only, length 2..6
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Additional domain label constraint: second label (if any) non-empty
(assert (>= (num_splits domain ".") 3))
(assert (= second_label (split_at domain "." 1)))
(assert (>= (str.len second_label) 1))

; Mutated from seed: contradicting constraint that email must be an IPv4-with-newline pattern
; This makes the instance UNSAT given the '@' and '.' email structure requirements.
(assert (not (str.in_re email
  (re.++
    (re.union
      (re.++ (str.to_re "25") (re.range "0" "5"))
      (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
      (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
      ((_ re.loop 1 2) (re.range "0" "9")))
    ((_ re.loop 3 3)
      (re.++ (str.to_re ".")
        (re.union
          (re.++ (str.to_re "25") (re.range "0" "5"))
          (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
          (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
          ((_ re.loop 1 2) (re.range "0" "9")))))
    (str.to_re "\u{a}")))))

; Force email to actually match that IPv4-with-newline regex too (direct contradiction with previous assert)
(assert (str.in_re email
  (re.++
    (re.union
      (re.++ (str.to_re "25") (re.range "0" "5"))
      (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
      (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
      ((_ re.loop 1 2) (re.range "0" "9")))
    ((_ re.loop 3 3)
      (re.++ (str.to_re ".")
        (re.union
          (re.++ (str.to_re "25") (re.range "0" "5"))
          (re.++ (str.to_re "2") (re.range "0" "4") (re.range "0" "9"))
          (re.++ (str.to_re "1") (re.range "0" "9") (re.range "0" "9"))
          ((_ re.loop 1 2) (re.range "0" "9")))))
    (str.to_re "\u{a}"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
