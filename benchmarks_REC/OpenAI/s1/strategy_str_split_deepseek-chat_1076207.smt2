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

; Non-primitive interface operations (uninterpreted)

; Primary input
(declare-const s String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const dom_first String)
(declare-const dom_mid String)

; Preserve core “length/at/ite” structure from seed, but simplify and align with email validation
(assert
  (and
    (not (= (ite (> (str.len s) 0) 1 0) 0))
    (not (= (ite (> (str.len s) 5) 1 0) 0))
    (not (= (ite (>= (- (str.len s) 1) 0) 1 0) 0))
    (not (not (= (ite (<= (str.len s) 0) 1 0) 0)))
    (not (not (= (ite (< (- (str.len s) 1) 0) 1 0) 0)))
    (not (not (= (ite (<= (- (str.len s) 1) 0) 1 0) 0)))
    (not (= (ite (= (str.at s 0) "@") 1 0) 0))
    (not (= (ite (= (str.at s (- (str.len s) 1)) "@") 1 0) 0))
    (not (= (ite (= (str.at s (- (str.len s) 1)) ".") 1 0) 0))
  )
)

; Split around '@' exactly once: local@domain
(assert (= (num_splits s "@") 2))
(assert (= local (split_at s "@" 0)))
(assert (= domain (split_at s "@" 1)))
(assert (= (split_rest s "@" 1) domain))

; Local part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain must contain dots and have at least 2 labels (e.g., example.com)
(assert (>= (num_splits domain ".") 2))
(assert (= dom_first (split_at domain "." 0)))
(assert (= dom_mid (split_rest domain "." 1)))
(assert (> (str.len dom_first) 0))
(assert (not (= (str.at dom_first 0) "-")))
(assert (not (= (str.at dom_first (- (str.len dom_first) 1)) "-")))

; Require TLD to be the last segment after splitting domain by '.'
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))

; Disallow empty labels by forbidding leading/trailing '.' and consecutive '..'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))
(assert (= (str.indexof domain ".." 0) (- 1)))

; Mixed constraints: ensure the original string reconstructs from parts
(assert (= s (str.++ local "@" domain)))

; Also require a basic overall regex-style property: exactly one '@' and at least one '.' after it
(assert (str.contains domain "."))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
