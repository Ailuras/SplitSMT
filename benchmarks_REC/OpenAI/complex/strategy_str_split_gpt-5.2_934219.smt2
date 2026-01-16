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

; Seed booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)

; Inputs / derived segments
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const domain_left String)

; Core seed-like sanity constraints (mutated from original)
(assert (= T_1 (= "-" email)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" email)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Email split at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= T_5 (= (num_splits email "@") 2)))
(assert T_5)

; Basic local-part constraints
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (str.contains local " ")))
(assert (not (str.prefixof "." local)))
(assert (not (str.suffixof "." local)))

; Domain constraints and '.' structure
(assert (> (str.len domain) 0))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain " ")))
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))

; Split domain by '.' and require at least one dot (>=2 segments)
(assert (>= (num_splits domain ".") 2))
(assert (= domain_left (split_at domain "." 0)))
(assert (= subdomain (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))

; Segment-level constraints
(assert (> (str.len domain_left) 0))
(assert (not (str.contains domain_left ".")))
(assert (> (str.len tld) 1))
(assert (< (str.len tld) 25))

; Some allowed-structure constraints via regex (avoid digits-only TLD)
(assert (str.in_re tld (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z"))) (re.* (re.union (re.range "a" "z") (re.range "A" "Z"))))) )

; Ensure domain has no consecutive dots by forbidding ".." substring
(assert (not (str.contains domain "..")))

; Additional derived predicate: domain must have at least 3 total segments OR local contains '+'
(assert (= T_6 (or (>= (num_splits domain ".") 3) (str.contains local "+"))))
(assert T_6)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
