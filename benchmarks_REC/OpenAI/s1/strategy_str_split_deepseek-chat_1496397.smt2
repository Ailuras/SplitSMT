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

; Uninterpreted functions for str_split interface

; Core input email string
(declare-const X String)

; Derived parts using split constraints
(declare-const local String)
(declare-const domain String)
(declare-const domain_head String)
(declare-const tld String)
(declare-const subdomain String)

; Keep seed-like “negative regex” structure but adapted to email validation
(assert (not (str.in_re X (str.to_re "pjpoptwql/rlnjsportsHost:Subject:YAHOOdestroyed!\u{a}"))))

; Disallow URL-like prefixes in email
(assert (not (str.in_re X (re.++ (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_") (str.to_re "-") (str.to_re ".")))
                              (str.to_re "://")
                              (re.* re.allchar)))))

; Require a linefeed at end (seed preserved motif), but ensure it's an email-like line
(assert (str.in_re X (re.++ (re.* re.allchar) (str.to_re "\u{a}"))))

; Basic split by '@' to obtain local and domain
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (>= (num_splits X "@") 2))
(assert (<= (num_splits X "@") 2))

; Local part constraints: non-empty, no spaces, no additional '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (= (num_splits local "@") 1))

; Domain constraints: must contain at least one '.' and at least two segments when split on '.'
(assert (> (str.len domain) 0))
(assert (= domain (split_rest X "@" 1)))
(assert (>= (num_splits domain ".") 2))

; Extract domain head and last label (TLD)
(assert (= domain_head (split_at domain "." 0)))
(assert (= tld (split_at domain "." 1)))

; Additionally reason about a potential subdomain part (everything after first '.')
(assert (= subdomain (split_rest domain "." 1)))
(assert (> (str.len domain_head) 0))
(assert (> (str.len subdomain) 0))

; TLD must be alphabetic and at least length 2 (apply to subdomain end via regex on subdomain)
(declare-const alpha String)
(assert (= alpha "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"))
(assert (str.in_re subdomain (re.++ (re.* re.allchar) (re.+ (re.union (re.range "A" "Z") (re.range "a" "z"))))))
(assert (>= (str.len tld) 2))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Reject common invalid patterns: consecutive dots, leading dot in local, trailing dot in local, and domain ending with '.'
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Preserve another seed-like negative regex but tuned away from IP-ish payloads
(assert (not (str.in_re X (re.++ (str.to_re "phpinfo") (re.* (re.union (str.to_re "\u{a}") (str.to_re "\u{d}"))) (re.* re.allchar)))))

; SAT/UNSAT diversity: ensure it is a valid email-like structure while forbidding a specific domain
(assert (not (str.contains domain "aresflashdownloader.com")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
