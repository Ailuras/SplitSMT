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

; Email Validation scenario using '@' and '.' delimiters with str_split interface

(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom_first String)

; Preserve core structure: X is constrained by a couple of complex regexes, but now aligned with email-like content
; Require exactly one '@' => splitting on '@' yields 2 segments
(assert (= (num_splits X "@") 2))
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))

; Local-part constraints: non-empty, no spaces, no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))

; Domain constraints: contains at least one '.', no spaces, does not start or end with '.'
(assert (>= (num_splits domain ".") 2))
(assert (not (str.contains domain " ")))
(assert (not (= (split_at domain "." 0) "")))
(assert (not (= (split_at domain "." (- (num_splits domain ".") 1)) "")))
(assert (= dom_first (split_at domain "." 0)))
(assert (> (str.len dom_first) 0))

; Extract TLD as last segment; require length 2..6 and letters only
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Ensure no empty label in the middle (i.e., forbid ".." in domain)
(assert (not (str.contains domain "..")))

; Mutated/repurposed regex structure: enforce overall email-like shape with allowed characters
; local: [A-Za-z0-9_+.-]+ but must not begin with '.' and must not end with '.'
(assert (str.in_re local
  (re.++
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+"))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".")))
    (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
  )))

; domain: labels [A-Za-z0-9-]+ separated by '.' and ending with alpha TLD
(assert (str.in_re domain
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.+ (re.++ (str.to_re ".") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))))
  )))

; Negative constraints similar to seed style, but now banning clearly non-email artifacts
(assert (not (str.in_re X (re.++ (str.to_re "<title>") (re.* re.allchar) (str.to_re "</title>")))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.* re.allchar)))))
(assert (not (str.contains X "\u{a}")))
(assert (not (str.contains X "\u{d}")))

; SAT instance anchor: enforce a concrete-looking structure without fixing entire X
(assert (str.in_re X
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "_") (str.to_re "+") (str.to_re "-") (str.to_re ".")))
    (str.to_re "@")
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (str.to_re ".")
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))
  )))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
