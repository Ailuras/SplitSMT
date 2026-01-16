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

; Uninterpreted functions for str_split interface

; Email validation scenario variables
(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const firstLabel String)
(declare-const secondLabel String)
(declare-const tld String)
(declare-const tldFirst String)
(declare-const tldSecond String)
(declare-const plusTag String)

; Preserve core structure: keep the seed's complex blocking constraints
(assert (not (str.in_re X (re.union
  (re.++ (str.to_re "/")
        (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "&")))
        (str.to_re "@")
        (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")))
        (str.to_re ".")
        ((_ re.loop 3 3) (re.union (re.range "a" "z") (re.range "A" "Z"))))
  (re.++ (str.to_re "/\u{a}") re.allchar ((_ re.loop 2 2) (re.union (re.range "a" "z") (re.range "A" "Z"))) (str.to_re ".") ((_ re.loop 2 2) (re.union (re.range "a" "z") (re.range "A" "Z"))))
))))

(assert (not (str.in_re X (str.to_re "Subject:User-Agent:iebarSubject:\u{a}"))))

(assert (not (str.in_re X (re.++
  (re.union (re.++ (str.to_re "N") (re.union (str.to_re "B") (str.to_re "L") (str.to_re "S") (str.to_re "T") (str.to_re "U")))
            (re.++ (re.union (str.to_re "A") (str.to_re "M") (str.to_re "N")) (str.to_re "B"))
            (re.++ (re.union (str.to_re "B") (str.to_re "Q")) (str.to_re "C"))
            (str.to_re "ON")
            (str.to_re "PE")
            (str.to_re "SK"))
  (str.to_re "\u{a}")))))

; Mutate/extend: instead of forcing the seed HTTP-ish regex, block it to focus on email constraints
(assert (not (str.in_re X (re.++ (str.to_re "//3/") ((_ re.loop 2 2) (re.range "A" "Z")) (str.to_re "/") ((_ re.loop 32 32) (re.union (re.range "a" "f") (re.range "0" "9"))) (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")) (str.to_re "HTTP/\u{a}")))))

; Email split structure using '@' and '.' delimiters
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= "" (split_rest X "@" 2)))
(assert (= (num_splits X "@") 2))

; Local part constraints: non-empty, basic allowed chars, optional plus-tag
(assert (> (str.len local) 0))
(assert (not (str.contains local "..")))
(assert (not (str.contains local "@")))
(assert (str.in_re local
  (re.++
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re ".")))
    (re.opt (re.++ (str.to_re "+") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-"))))))))

; Domain must have at least 3 segments: label1.label2.tld, and no empty labels
(assert (>= (num_splits domain ".") 3))
(assert (= firstLabel (split_at domain "." 0)))
(assert (= secondLabel (split_at domain "." 1)))
(assert (= tld (split_rest domain "." 2)))
(assert (> (str.len firstLabel) 0))
(assert (> (str.len secondLabel) 0))
(assert (> (str.len tld) 0))

; Labels: alnum and hyphen, but not starting/ending with hyphen
(assert (str.in_re firstLabel (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (str.in_re secondLabel (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (= (str.at firstLabel 0) "-")))
(assert (not (= (str.at secondLabel 0) "-")))
(assert (not (= (str.at firstLabel (- (str.len firstLabel) 1)) "-")))
(assert (not (= (str.at secondLabel (- (str.len secondLabel) 1)) "-")))

; TLD: exactly 2 segments separated by '.', where last is 2..6 letters and first is 1..63 label
(assert (= (num_splits tld ".") 2))
(assert (= tldFirst (split_at tld "." 0)))
(assert (= tldSecond (split_at tld "." 1)))
(assert (> (str.len tldFirst) 0))
(assert (<= (str.len tldFirst) 63))
(assert (str.in_re tldFirst (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))
(assert (not (= (str.at tldFirst 0) "-")))
(assert (not (= (str.at tldFirst (- (str.len tldFirst) 1)) "-")))
(assert (str.in_re tldSecond ((_ re.loop 2 6) (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Additional sanity: no spaces in full email, and must contain exactly one '@'
(assert (not (str.contains X " ")))
(assert (str.contains X "@"))

; Ensure X is reconstructed from parts (consistency)
(assert (= X (str.++ local "@" domain)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
