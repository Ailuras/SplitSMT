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

; Uninterpreted interface operations for str_split

; ------------
; SAT instance: a complex but valid email structure
; ------------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const first_label_ok String)
(declare-const tld_ok String)
(declare-const remainder_ok String)
(declare-const at_count_ok Int)
(declare-const dot_count_ok Int)

(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= at_count_ok (num_splits email_ok "@")))
(assert (= at_count_ok 2))

; local part sanity: non-empty, no spaces, does not contain '@'
(assert (> (str.len local_ok) 0))
(assert (not (str.contains local_ok " ")))
(assert (= (num_splits local_ok "@") 1))

; domain constraints: at least one dot, non-empty labels, and structured tail
(assert (= dot_count_ok (num_splits domain_ok ".")))
(assert (>= dot_count_ok 2))
(assert (= first_label_ok (split_at domain_ok "." 0)))
(assert (= remainder_ok (split_rest domain_ok "." 1)))
(assert (> (str.len first_label_ok) 0))
(assert (not (str.contains first_label_ok " ")))

; last segment as TLD: take last label via split_rest indexing
(assert (= tld_ok (split_at domain_ok "." (- dot_count_ok 1))))
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 24))

; enforce a concrete witness shape: user.name+tag@sub.example.co
(assert (= email_ok "user.name+tag@sub.example.co"))

; ------------
; UNSAT instance: impossible email structure (conflicting split constraints)
; ------------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const at_count_bad Int)
(declare-const dot_count_bad Int)
(declare-const tld_bad String)

(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= at_count_bad (num_splits email_bad "@")))

; claim exactly one '@' exists (i.e., only one segment), but also force segment 1 to be non-empty -> contradiction
(assert (= at_count_bad 1))
(assert (> (str.len domain_bad) 0))

; additionally force there to be at least one dot in the domain and a TLD of length >= 2
(assert (= dot_count_bad (num_splits domain_bad ".")))
(assert (>= dot_count_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- dot_count_bad 1))))
(assert (>= (str.len tld_bad) 2))

; provide an explicit bad-looking candidate to strengthen inconsistency with the segment-count claim
(assert (= email_bad "a@b.c"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
