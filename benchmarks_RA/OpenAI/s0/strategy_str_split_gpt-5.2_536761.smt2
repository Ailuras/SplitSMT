(set-logic ALL)

; Email Validation using split operations with '@' and '.' delimiters

; --- Uninterpreted split interface (str_split) ---
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

; --- Common variables ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const tld String)
(declare-const domain_rest String)
(declare-const local_first_token String)
(declare-const local_rest String)

(declare-const atSegs Int)
(declare-const dotDomainSegs Int)
(declare-const dotLocalSegs Int)

; =====================
; SAT instance: well-formed email constraints
; =====================

; Basic structure: exactly one '@' => 2 segments when splitting by '@'
(assert (= atSegs (num_splits email "@")))
(assert (= atSegs 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Non-empty local and domain
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Local-part constraints (simple but non-trivial):
; - no spaces
; - does not start with '.' and does not end with '.'
(assert (not (str.contains local " ")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Allow local to contain dots but not consecutive dots (approximated via split count and non-empty tokens)
(assert (= dotLocalSegs (num_splits local ".")))
(assert (>= dotLocalSegs 1))
(assert (> (str.len (split_at local "." 0)) 0))
(assert (=> (>= dotLocalSegs 2) (> (str.len (split_at local "." 1)) 0)))

; Domain constraints:
; - at least one dot (e.g., example.com)
; - last label (TLD) length between 2 and 24
; - no spaces
(assert (not (str.contains domain " ")))
(assert (= dotDomainSegs (num_splits domain ".")))
(assert (>= dotDomainSegs 2))

(assert (= domain_first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dotDomainSegs 1))))
(assert (= domain_rest (split_rest domain "." 1)))

; Domain labels non-empty: first label and tld must be non-empty
(assert (> (str.len domain_first_label) 0))
(assert (> (str.len tld) 0))

; TLD length constraint
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Additional domain structure sanity:
; - domain does not start with '.' and does not end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Restrict to a realistic pattern (regex): local@domain with allowed chars (approximation)
; Local: letters/digits/._+- ; Domain labels: letters/digits/- ; dots between labels
(define-fun is_alnum ((c String)) Bool
  (str.in_re c (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))))

; Stronger regex for overall email (still an approximation, but useful)
(assert
  (str.in_re email
    (re.++
      (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-")))
      (str.to_re "@")
      (re.++
        (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
        (re.+
          (re.++
            (str.to_re ".")
            (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
        ))))

; Provide a witness via concrete example to ensure SAT
(assert (= email "john.doe+tag@example.co.uk"))

(check-sat)

; =====================
; UNSAT instance: contradictory email constraints
; (Separate check using push/pop)
; =====================

(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const badAtSegs Int)
(declare-const badDotDomainSegs Int)

; Force exactly one '@'
(assert (= badAtSegs (num_splits email_bad "@")))
(assert (= badAtSegs 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Force at least one dot in domain
(assert (= badDotDomainSegs (num_splits domain_bad ".")))
(assert (>= badDotDomainSegs 2))
(assert (= tld_bad (split_at domain_bad "." (- badDotDomainSegs 1))))

; Contradictory TLD constraints: length >= 2 and length = 1
(assert (>= (str.len tld_bad) 2))
(assert (= (str.len tld_bad) 1))

; Also pin email_bad to a specific string that would otherwise be valid-ish
(assert (= email_bad "a@b.co"))

(check-sat)
(exit)
