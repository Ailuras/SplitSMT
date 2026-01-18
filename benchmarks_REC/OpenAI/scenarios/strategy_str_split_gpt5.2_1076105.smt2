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

; Uninterpreted interface for string split operations

; =====================
; Scenario: Email Validation
; =====================

; ---------- SAT instance: a plausible email meeting constraints ----------
(declare-const email_ok String)
(declare-const local_ok String)
(declare-const domain_ok String)
(declare-const dom_label0_ok String)
(declare-const dom_tail_ok String)
(declare-const tld_ok String)
(declare-const local_first_ok String)
(declare-const local_second_ok String)

; Shape around '@'
(assert (= local_ok (split_at email_ok "@" 0)))
(assert (= domain_ok (split_at email_ok "@" 1)))
(assert (= "" (split_rest email_ok "@" 2)))
(assert (= (num_splits email_ok "@") 2))

; Domain split around '.' (must have at least one '.')
(assert (= dom_label0_ok (split_at domain_ok "." 0)))
(assert (= dom_tail_ok (split_rest domain_ok "." 1)))
(assert (>= (num_splits domain_ok ".") 2))

; TLD is last segment when exactly 2 labels (one '.')
(assert (= (num_splits domain_ok ".") 2))
(assert (= tld_ok (split_at domain_ok "." 1)))
(assert (= "" (split_rest domain_ok "." 2)))

; Local-part further constraints with '.' (allow either one segment or two segments, but no empty segment)
(assert (or (= (num_splits local_ok ".") 1)
            (= (num_splits local_ok ".") 2)))
(assert (= local_first_ok (split_at local_ok "." 0)))
(assert (or (= (num_splits local_ok ".") 1)
            (= local_second_ok (split_at local_ok "." 1))))

; Non-emptiness and basic structure (use string/regex for concreteness)
(assert (> (str.len local_ok) 0))
(assert (> (str.len domain_ok) 0))
(assert (> (str.len dom_label0_ok) 0))
(assert (> (str.len tld_ok) 0))
(assert (>= (str.len tld_ok) 2))
(assert (not (str.contains local_ok "@")))
(assert (not (str.contains domain_ok "@")))
(assert (not (str.contains domain_ok "..")))
(assert (not (str.contains domain_ok ".-")))
(assert (not (str.contains domain_ok "-.")))
(assert (not (str.contains domain_ok "-")))

; Constrain character classes for local and domain labels (simple relaxed email rules)
(assert (str.in_re local_ok (re.++ (re.+ (re.range "a" "z"))
                                  (re.* (re.union (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "+") (str.to_re "-"))))))
(assert (str.in_re dom_label0_ok (re.+ (re.union (re.range "a" "z") (re.range "0" "9")))))
(assert (str.in_re tld_ok (re.+ (re.range "a" "z"))))

; Force a concrete satisfying example for the SAT block
(assert (= email_ok "alice+dev@acme.io"))

; ---------- UNSAT instance: contradictory email constraints ----------
(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const tld_bad String)
(declare-const dom_label0_bad String)

; Shape around '@' (require exactly one '@')
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= "" (split_rest email_bad "@" 2)))
(assert (= (num_splits email_bad "@") 2))

; Domain must have exactly one '.'
(assert (= dom_label0_bad (split_at domain_bad "." 0)))
(assert (= tld_bad (split_at domain_bad "." 1)))
(assert (= (num_splits domain_bad ".") 2))
(assert (= "" (split_rest domain_bad "." 2)))

; Contradiction: simultaneously enforce no '.' in the domain string
(assert (not (str.contains domain_bad ".")))

; Also pin an example domain that does contain a '.' to intensify inconsistency
(assert (= email_bad "bob@x.y"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
