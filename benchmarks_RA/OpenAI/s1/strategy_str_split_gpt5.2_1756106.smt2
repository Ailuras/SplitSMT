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

; Email Validation scenario using str_split and regex constraints

; Uninterpreted split interface

(declare-const X String) ; original seed variable, repurposed as the email string
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const first_label String)
(declare-const after_first_dot String)
(declare-const at_count Int)
(declare-const dot_count Int)

; Core split structure: local@domain
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= at_count (num_splits X "@")))
(assert (= at_count 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; Domain must contain at least one dot and be split into at least 2 labels
(assert (= dot_count (num_splits domain ".")))
(assert (>= dot_count 2))

; Extract first domain label and rest
(assert (= first_label (split_at domain "." 0)))
(assert (= after_first_dot (split_rest domain "." 1)))
(assert (>= (str.len first_label) 1))
(assert (>= (str.len after_first_dot) 3))

; TLD is the last label when splitting by '.'
(assert (= tld (split_at domain "." (- dot_count 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Local part regex: starts/ends with alnum, may contain '.', '_', '+', '-' inside
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9")))))

; Domain overall shape: labels separated by dots, labels are alnum or hyphen, no leading/trailing hyphen per label (approximated)
(assert (str.in_re domain
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
    (re.+
      (re.++
        (str.to_re ".")
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9"))
        (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
        (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9")))))))

; TLD must be alphabetic only
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))) )))

; Disallow consecutive dots in local and domain (string-level approximations)
(assert (not (str.contains local "..")))
(assert (not (str.contains domain "..")))

; Ensure '@' and '.' are used as delimiters in the whole email
(assert (str.contains X "@"))
(assert (str.contains domain "."))

; UNSAT twist: simultaneously require local not to contain '+' but also require it to contain '+'
(assert (not (str.contains local "+")))
(assert (str.contains local "+"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
