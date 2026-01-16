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

; Email Validation scenario using str_split with '@' and '.' delimiters

; Uninterpreted interface functions for split constraints

; Variables
(declare-const X String)              ; full email candidate
(declare-const local String)          ; local-part before '@'
(declare-const domain String)         ; domain after '@'
(declare-const label0 String)         ; first domain label
(declare-const label1 String)         ; second domain label
(declare-const tld String)            ; top-level domain (last label)

; Preserve seed core structure: keep a negated regex membership constraint (mutated to email-related format)
; Disallow a specific newline-terminated numeric pattern to avoid confusing addresses like "05########\n"
(assert (not (str.in_re X (re.++ (str.to_re "05") ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Basic split structure around '@'
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= "" (split_rest X "@" 2)))

; Exactly one '@' (i.e., two segments)
(assert (= (num_splits X "@") 2))

; Local-part constraints: non-empty and does not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))

; Domain constraints: must contain at least one '.' and have at least two labels
(assert (>= (num_splits domain ".") 2))

; Pull out domain labels (supporting multi-label domains)
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))

; Define TLD as last label by requiring exactly 3 labels (this makes it more structured)
(assert (= (num_splits domain ".") 3))
(assert (= tld (split_at domain "." 2)))
(assert (= "" (split_rest domain "." 3)))

; No empty labels in domain
(assert (> (str.len label0) 0))
(assert (> (str.len label1) 0))
(assert (> (str.len tld) 0))

; Simple syntactic restrictions: no '.' in any single label
(assert (not (str.contains label0 ".")))
(assert (not (str.contains label1 ".")))
(assert (not (str.contains tld ".")))

; TLD must be alphabetic and length 2..6
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Additional local-part pattern: allow letters/digits and '.', '_', '+', '-' (no leading/trailing '.')
; This is a relaxed approximation using regex and split checks.
(assert (str.in_re local (re.++
  (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") )
  (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".") ))
)))

; No consecutive dots in local-part
(assert (not (str.contains local "..")))

; ----------
; Include both SAT and UNSAT instances in one file:
; If X starts with "bad@", enforce a contradiction: domain must have exactly 3 labels AND exactly 1 label.
; Otherwise, constraints above allow typical emails like "user.name+tag@sub.example.com".
; ----------
(assert (=> (str.prefixof "bad@" X)
            (and (= (num_splits domain ".") 1)
                 (= (num_splits domain ".") 3))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
