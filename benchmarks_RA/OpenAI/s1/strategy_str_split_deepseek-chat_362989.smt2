; Email Validation scenario: validate complex email formats using '@' and '.' as delimiters
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

; str_split interface

; Variables
(declare-const value String) ; the email address
(declare-const key String)
(declare-const local String)
(declare-const domain String)
(declare-const sld String)  ; second-level domain
(declare-const tld String)  ; top-level domain
(declare-const subrest String)

; Preserve some core structure from seed while adapting to email setting
(assert (and
  ; key fixed to mimic header-like context but email scenario
  (not (= (ite (= key "email") 1 0) 0))

  ; non-empty overall value
  (not (not (= (ite (= (str.len value) 0) 1 0) 0)))
  (not (= (ite (not (= (str.len value) 0)) 1 0) 0))

  ; must contain '@' and not contain spaces
  (not (= (ite (str.contains value "@") 1 0) 0))
  (not (not (= (ite (str.contains value " ") 1 0) 0)))

  ; split around '@' into exactly 2 segments (local and domain)
  (= (num_splits value "@") 2)
  (= local (split_at value "@" 0))
  (= domain (split_at value "@" 1))

  ; local and domain non-empty
  (> (str.len local) 0)
  (> (str.len domain) 0)

  ; local cannot start/end with '.' and cannot contain '@'
  (not (= (str.at local 0) "."))
  (not (= (str.at local (- (str.len local) 1)) "."))
  (not (str.contains local "@"))

  ; domain must contain at least one '.'
  (>= (num_splits domain ".") 2)

  ; set TLD as last split; and SLD as penultimate split for structure
  (= tld (split_at domain "." (- (num_splits domain ".") 1)))
  (= sld (split_at domain "." (- (num_splits domain ".") 2)))

  ; tld constraints: 2..6 letters only
  (>= (str.len tld) 2)
  (<= (str.len tld) 6)
  (str.in_re tld (re.++ (re.+ (re.range "a" "z")) (re.* (re.range "a" "z"))))

  ; sld non-empty and no empty labels in domain
  (> (str.len sld) 0)

  ; domain labels: no leading/trailing '.' and no consecutive '..'
  (not (= (str.at domain 0) "."))
  (not (= (str.at domain (- (str.len domain) 1)) "."))
  (not (str.contains domain ".."))

  ; optional subdomains: if there are more than 2 labels, enforce each non-empty by forbidding '..'
  (= subrest (split_rest domain "." 0))

  ; index bounds-style constraints echoing seed's arithmetic checks
  (>= (str.indexof value "@" 0) 0)
  (>= (- (str.len value) (+ (str.indexof value "@" 0) 1)) 0)
  (>= 0 0)
))

; UNSAT branch to ensure diversity: require both exactly one '@' via split count AND also forbid '@'
(assert (and
  (= (num_splits value "@") 2)
  (not (str.contains value "@"))
))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
