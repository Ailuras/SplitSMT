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

; Uninterpreted split interface

; Email validation scenario
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)

; Preserve and adapt core regex-based structure from seed (mutated)
; Local-part: only lowercase letters a..u, non-empty
(assert (str.in_re local (re.+ (re.range "a" "u"))))

; Additional structured local constraint: must contain an 'a', and then only a/b afterwards
(assert (str.in_re local (re.++ (re.* (re.union (str.to_re "b") (re.range "c" "u"))) (re.++ (str.to_re "a") (re.* (re.union (str.to_re "a") (str.to_re "b")))))))

; Domain: lowercase letters and dots, must include at least one dot
(assert (str.in_re domain (re.++ (re.+ (re.range "a" "z")) (re.++ (str.to_re ".") (re.+ (re.range "a" "z"))))))

; Whole email must have exactly one '@' (two segments when split)
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Domain must split into exactly two labels by '.' (host.tld)
(assert (= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Host label constraints
(assert (str.in_re host (re.+ (re.range "a" "z"))))
(assert (>= (str.len host) 2))

; TLD constraints: 2 to 6 lowercase letters
(assert (str.in_re tld (re.++ (re.range "a" "z") (re.+ (re.range "a" "z")))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))

; Link email string structurally
(assert (= email (str.++ local (str.++ "@" domain))))

; Keep a seed-like sanity assertion
(assert (not (str.in_re "" re.none)))

; UNSAT tweak: require an impossible split count for the same domain
(assert (= (num_splits domain ".") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
