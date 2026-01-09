(set-logic ALL)

; Uninterpreted functions for str_split interface
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

; -------------------------------
; Scenario: Email Validation
; We create two instances:
;  - SAT instance: an email that satisfies structural constraints
;  - UNSAT instance: contradictory requirements on the local-part
; Both validate complex formats using '@' and '.' delimiters.
; -------------------------------

; ===== SAT instance variables =====
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const tld_ok String)
(declare-const domain_no_tld_ok String)
(declare-const host1_ok String)
(declare-const host2_ok String)

; Email must have exactly one '@' => 2 segments when split by '@'
(assert (= (num_splits email_ok "@") 2))
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))

; Non-empty local and domain
(assert (>= (str.len local_ok) 1))
(assert (>= (str.len domain_ok) 1))

; Local-part restrictions (simple, realistic structure):
; - cannot contain '@'
; - cannot start with '.'
; - cannot end with '.'
; - no consecutive dots (approximated by forbidding "..")
(assert (not (str.contains local_ok "@")))
(assert (not (= (str.at local_ok 0) ".")))
(assert (not (= (str.at local_ok (- (str.len local_ok) 1)) ".")))
(assert (not (str.contains local_ok "..")))

; Force local-part to match a complex pattern using regex:
; starts with an alnum, followed by alnum or [._+-] and alnum, repeated.
; This avoids trailing special characters without overcomplicating.
(assert (str.in_re local_ok
  (re.++
    (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9"))
    (re.*
      (re.++
        (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
        (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))
      )
    )
  )
))

; Domain must have at least one '.' separating TLD
(assert (>= (num_splits domain_ok ".") 2))

; Define the TLD as the last dot-segment, and the rest as everything before it
(assert (= tld_ok (split_at domain_ok "." (- (num_splits domain_ok ".") 1))))
(assert (= domain_no_tld_ok (split_rest domain_ok "." 0)))

; TLD constraints: length 2..6 and letters only
(assert (>= (str.len tld_ok) 2))
(assert (<= (str.len tld_ok) 6))
(assert (str.in_re tld_ok (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Domain structure: at least two labels before TLD for "complex" domains
; e.g., host1.host2.tld (3 segments minimum)
(assert (>= (num_splits domain_ok ".") 3))
(assert (= host1_ok (split_at domain_ok "." 0)))
(assert (= host2_ok (split_at domain_ok "." 1)))

; Host labels are non-empty, cannot contain '@', cannot start/end with '-'
(assert (>= (str.len host1_ok) 1))
(assert (>= (str.len host2_ok) 1))
(assert (not (str.contains domain_ok "@")))
(assert (not (= (str.at host1_ok 0) "-")))
(assert (not (= (str.at host2_ok 0) "-")))
(assert (not (= (str.at host1_ok (- (str.len host1_ok) 1)) "-")))
(assert (not (= (str.at host2_ok (- (str.len host2_ok) 1)) "-")))

; Also forbid consecutive dots in domain
(assert (not (str.contains domain_ok "..")))

; Make SAT instance concrete enough to avoid vacuity
(assert (= email_ok "john.doe+tag@sub.mail.Example.com"))

; ===== UNSAT instance variables =====
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)

; Email has exactly one '@'
(assert (= (num_splits email_bad "@") 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))

; Domain has at least one '.' and has a valid-looking TLD
(assert (>= (num_splits domain_bad ".") 2))
(assert (= tld_bad (split_at domain_bad "." (- (num_splits domain_bad ".") 1))))
(assert (>= (str.len tld_bad) 2))
(assert (<= (str.len tld_bad) 6))
(assert (str.in_re tld_bad (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Contradictory local-part constraints to force UNSAT:
; local_bad must contain ".." but also must NOT contain ".."
(assert (str.contains local_bad ".."))
(assert (not (str.contains local_bad "..")))

; Make other parts reasonable (these do not resolve the contradiction)
(assert (>= (str.len local_bad) 1))
(assert (>= (str.len domain_bad) 1))
(assert (not (str.contains local_bad "@")))
(assert (not (str.contains domain_bad "@")))

; Provide a concrete candidate (still UNSAT due to contradiction)
(assert (= email_bad "a..b@example.com"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
