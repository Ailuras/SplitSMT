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

; Scenario: Email Validation using '@' and '.' as delimiters
; Core seed structure preserved: keep sigmaStar_0, literals, epsilon, x_3, x_6; extend with email-specific constraints.

(declare-fun sigmaStar_0 () String)
(declare-fun literal_2 () String)
(declare-fun x_3 () String)
(declare-fun x_6 () String)
(declare-fun epsilon () String)
(declare-fun literal_5 () String)

; str_split interface (uninterpreted)

; Email-related variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sld String)
(declare-const domain_left String)
(declare-const domain_mid String)
(declare-const domain_right String)
(declare-const dot_count_domain Int)
(declare-const at_count_email Int)
(declare-const domain_len Int)
(declare-const local_len Int)
(declare-const tld_len Int)

; Seed literals (mutated into email-centric anchors)
(assert (= literal_2 "@"))
(assert (= x_3 (str.++ sigmaStar_0 literal_2)))
(assert (= epsilon ""))
(assert (= literal_5 "."))

; Keep a seed-like disjunction, but repurpose x_6 to be either empty or '.'
(assert (or (= x_6 epsilon) (= x_6 literal_5)))

; Email must contain '@' as a separator and not begin/end with it
(assert (= at_count_email (num_splits email "@")))
(assert (= at_count_email 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (= (str.at email 0) "@")))
(assert (not (= (str.at email (- (str.len email) 1)) "@")))

; Local-part constraints: no empty, no spaces, no additional '@'
(assert (= local_len (str.len local)))
(assert (>= local_len 1))
(assert (= (num_splits local "@") 1))
(assert (not (str.contains local " ")))

; Domain structure: require at least one '.' and exactly 2 or 3 labels
(assert (= dot_count_domain (num_splits domain ".")))
(assert (or (= dot_count_domain 2) (= dot_count_domain 3)))

; Extract domain labels for 2- or 3-label domains
(assert (= sld (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- dot_count_domain 1))))
(assert (= domain_len (str.len domain)))
(assert (> domain_len 2))

; Ensure no empty labels around '.'
(assert (> (str.len sld) 0))
(assert (> (str.len tld) 0))

; TLD basic sanity: length 2..24, only letters (approx via regex of allchar minus easy exclusions is not available)
; Use a conservative regex for [A-Za-z]+ by explicit union ranges.
(declare-const reLower RegLan)
(declare-const reUpper RegLan)
(assert (= reLower (re.union (re.range "a" "z") (re.range "a" "z"))))
(assert (= reUpper (re.union (re.range "A" "Z") (re.range "A" "Z"))))
(assert (= tld_len (str.len tld)))
(assert (and (>= tld_len 2) (<= tld_len 24)))
(assert (str.in_re tld (re.+ (re.union reLower reUpper))))

; Domain must not contain spaces or '@'
(assert (not (str.contains domain " ")))
(assert (= (num_splits domain "@") 1))

; Additional structure for possible 3-label domains
(assert (= domain_left (split_at domain "." 0)))
(assert (= domain_mid (split_at domain "." 1)))
(assert (= domain_right (split_at domain "." 2)))
(assert (=> (= dot_count_domain 3) (and (> (str.len domain_left) 0) (> (str.len domain_mid) 0) (> (str.len domain_right) 0))))

; Avoid consecutive dots by requiring that splitting by '.' yields no empty second label when 3 labels
(assert (=> (= dot_count_domain 3) (not (= domain_mid ""))))

; Tie seed variable sigmaStar_0 to local part prefix for structural preservation
(assert (str.prefixof sigmaStar_0 local))

; SAT instance anchor: set a concrete satisfiable email
(assert (= email "alice.smith@dept.example.com"))

; Also include a separate UNSAT-like constraint on x_6 to ensure diversity without breaking satisfiable email
; x_6 must be either empty or '.', and we additionally require it to contain a character 'X' (impossible)
(declare-const mustContainX Bool)
(assert (= mustContainX true))
(assert (=> mustContainX (str.contains x_6 "X")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
