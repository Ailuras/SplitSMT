(set-logic ALL)

; Email Validation scenario using str_split interface

; Uninterpreted split operations
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

; Common string variables
(declare-const email_good String)
(declare-const local_good String)
(declare-const domain_good String)
(declare-const tld_good String)
(declare-const sld_good String)
(declare-const rest_domain_good String)

; A second email used to create an UNSAT sub-instance
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Integers for split indices (kept natural)
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)

; -------------------------
; Natural index constraints
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))

; -------------------------
; SAT instance: email_good is a valid complex email

; Exactly one '@' -> exactly two segments
(assert (= (num_splits email_good "@") 2))
(assert (= local_good (split_at email_good "@" k0)))
(assert (= domain_good (split_at email_good "@" k1)))

; Local part constraints: non-empty, no '@', no leading/trailing '.' and basic allowed charset
(assert (> (str.len local_good) 0))
(assert (not (str.contains local_good "@")))
(assert (not (= (str.at local_good 0) ".")))
(assert (not (= (str.at local_good (- (str.len local_good) 1)) ".")))
(assert (str.in_re local_good (re.++ (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789._%+-")) (re.* (str.to_re "")))))

; Domain must contain at least one '.' -> at least two segments
(assert (>= (num_splits domain_good ".") 2))

; Enforce TLD is last segment and at least 2 chars alphabetic
(assert (= tld_good (split_at domain_good "." (- (num_splits domain_good ".") 1))))
(assert (>= (str.len tld_good) 2))
(assert (str.in_re tld_good (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))))

; Enforce second-level domain is segment 0 and non-empty
(assert (= sld_good (split_at domain_good "." 0)))
(assert (> (str.len sld_good) 0))
(assert (not (= (str.at sld_good 0) "-")))
(assert (not (= (str.at sld_good (- (str.len sld_good) 1)) "-")))
(assert (str.in_re sld_good (re.+ (str.to_re "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-"))))

; If there are more than 2 domain segments, ensure the remaining tail exists and is consistent
(assert (= rest_domain_good (split_rest domain_good "." 1)))
(assert (or (= (num_splits domain_good ".") 2)
            (and (> (str.len rest_domain_good) (str.len tld_good))
                 (str.contains rest_domain_good "."))))

; Concrete witness to keep the SAT part grounded
(assert (= email_good "john.doe+tag@sub.example.co"))

; -------------------------
; UNSAT instance: email_bad is forced to violate '@' segment constraints

; Force email_bad to be a typical-looking email...
(assert (= email_bad "a@b.com"))

; ...but also require it to have 3 segments when splitting by '@' (impossible for the concrete string)
(assert (= (num_splits email_bad "@") 3))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= tld_bad (split_at domain_bad "." 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
