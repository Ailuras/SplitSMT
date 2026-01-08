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

; Scenario: Email Validation using str_split

; Uninterpreted interface operations for string splitting

; Variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const host String)
(declare-const reconstructed String)

; Keep a mutated version of the seed-style constraint (now about email/local)
(assert (not (= (str.replace email (str.replace local local "") email) (str.++ email email))))

; Basic email structure: must contain exactly one '@' (2 segments after splitting)
(assert (= (num_splits email "@") 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local part constraints: non-empty, cannot contain '@', and cannot start/end with '.'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: must contain at least one '.', with non-empty host and tld
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len host) 0))
(assert (> (str.len tld) 0))

; Domain must not start or end with '.'
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Subdomain/rest constraints: take everything after the first dot
(assert (= subdomain (split_rest domain "." 1)))
(assert (> (str.len subdomain) 0))

; Require a plausible TLD length (e.g., 2..24)
(assert (and (>= (str.len tld) 2) (<= (str.len tld) 24)))

; Reconstruct and ensure it matches (structural sanity)
(assert (= reconstructed (str.++ local "@" domain)))
(assert (= email reconstructed))

; SAT branch: allow either exactly two domain labels OR multiple labels
(assert (or (= (num_splits domain ".") 2) (>= (num_splits domain ".") 3)))

; UNSAT instance embedded: force contradictory TLD length simultaneously
(assert (and (<= (str.len tld) 1) (>= (str.len tld) 2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
