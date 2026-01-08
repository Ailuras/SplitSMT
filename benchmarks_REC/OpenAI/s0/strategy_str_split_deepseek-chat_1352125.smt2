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

; Uninterpreted string-split interface

; ==========================
; Scenario: Email Validation
; ==========================

; ---------
; SAT part
; ---------
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const host_and_tld String)
(declare-const host String)
(declare-const subdomain0 String)
(declare-const subdomain1 String)

; Basic split around '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (= (num_splits email "@") 2))

; Local-part constraints: non-empty, no spaces, does not contain '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Domain constraints: non-empty, must contain at least one '.', no spaces, does not contain '@'
(assert (> (str.len domain) 0))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "@")))
(assert (>= (num_splits domain ".") 2))

; Extract last label as TLD using split_rest: last segment after '.'
; Enforce 2 segments by '.' for a simple domain: host.tld
(assert (= (num_splits domain ".") 2))
(assert (= host_and_tld domain))
(assert (= host (split_at host_and_tld "." 0)))
(assert (= tld (split_at host_and_tld "." 1)))

; Host label constraints
(assert (> (str.len host) 0))
(assert (not (str.contains host "..")))
(assert (not (str.contains host "-")))

; TLD constraints: length 2..6, only lowercase letters
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 6)))
(assert (str.in_re tld (re.+ (re.range "a" "z"))))

; Constrain full email to be local@host.tld and avoid double '@'
(assert (= email (str.++ local "@" host "." tld)))
(assert (not (str.contains (str.substr email 1 (- (str.len email) 1)) "@")))

; Additional (optional) split checks: subdomain variables unused in host.tld case but declared for diversity
(assert (= subdomain0 (split_at domain "." 0)))
(assert (= subdomain1 (split_at domain "." 1)))
(assert (= subdomain0 host))
(assert (= subdomain1 tld))

; Witness to keep SAT grounded
(assert (= email "user@site.com"))

; -----------
; UNSAT part
; -----------
; A second email intended to be invalid by contradictory constraints
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)
(declare-const bad_tld String)

(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))
(assert (= (num_splits bad_email "@") 2))

; Force bad_email to a concrete value with a 1-character TLD, but also require TLD length >= 2
(assert (= bad_email "a@b.c"))
(assert (= bad_tld (split_at bad_domain "." 1)))
(assert (= (num_splits bad_domain ".") 2))
(assert (>= (str.len bad_tld) 2))
(assert (= bad_tld "c"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
