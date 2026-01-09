(set-logic ALL)

; Uninterpreted str_split interface
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

; Primary inputs
(declare-const email String)
(declare-const email_unsat String)

; Derived components (intended parsing)
(declare-const local String)
(declare-const domain String)
(declare-const domain_label0 String)
(declare-const domain_rest1 String)
(declare-const tld String)
(declare-const subdomain String)

; Auxiliary integers
(declare-const at_splits Int)
(declare-const dot_splits Int)
(declare-const dot_splits_unsat Int)

; -------------------------------
; SAT instance: complex email validation
; -------------------------------

; Basic sanity: non-empty email and must contain exactly one '@'
(assert (> (str.len email) 5))
(assert (= at_splits (num_splits email "@")))
(assert (= at_splits 2))

; Bind local and domain parts via split_at
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Domain constraints: must have at least one '.' (i.e., >= 2 segments)
(assert (= dot_splits (num_splits domain ".")))
(assert (>= dot_splits 2))

; Bind first domain label and the rest
(assert (= domain_label0 (split_at domain "." 0)))
(assert (= domain_rest1 (split_rest domain "." 1)))
(assert (> (str.len domain_label0) 0))

; Domain labels should not contain '@' or spaces
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain " ")))

; Require at least one subdomain label before TLD when there are >= 3 labels
; (if exactly 2 labels, subdomain is empty and domain_rest1 is just the TLD)
(assert (= subdomain (split_at domain_rest1 "." 0)))

; TLD: last segment (approximated by taking last segment of domain_rest1)
; For dot_splits >= 2, domain_rest1 has at least 1 segment.
(assert (= tld (split_at domain_rest1 "." (- (num_splits domain_rest1 ".") 1))))

; TLD constraints: length 2..6, no digits (approx via regex), no hyphen at start (weak check)
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Enforce that domain starts with a letter and contains at least one dot (already via dot_splits)
(assert (str.in_re domain_label0 (re.++ (re.range "a" "z") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))

; Provide a witness shape to ensure satisfiable and "complex": local contains a '+' tag
(assert (str.contains local "+"))
(assert (str.in_re local (re.++ (re.+ (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))) (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))))))

; Make the overall email lower-case and constrained (single '@' already)
(assert (= email (str.++ local "@" domain)))
(assert (str.in_re email (re.++ (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-"))) (str.to_re "@") (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re "-") (str.to_re "."))))))

; -------------------------------
; UNSAT instance: contradictory constraints about '@' and '.' structure
; -------------------------------

; Force exactly one '@' but also require the email to have no '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (not (str.contains email_unsat "@")))

; Additionally require a domain part after '@' while claiming no '.' segments exist
(assert (= dot_splits_unsat (num_splits (split_at email_unsat "@" 1) ".")))
(assert (>= dot_splits_unsat 2))
(assert (= dot_splits_unsat 1))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
