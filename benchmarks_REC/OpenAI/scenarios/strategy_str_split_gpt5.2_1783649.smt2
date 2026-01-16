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

; =========
; Scenario: Email Validation
; =========

; --- Primary variables (intended SAT)
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const domain_first_label String)
(declare-const domain_rest String)
(declare-const tld String)
(declare-const atCount Int)
(declare-const dotCount Int)
(declare-const domainDotCount Int)

; Basic split constraints around '@'
(assert (= atCount (num_splits email "@")))
(assert (>= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (split_rest email "@" 2) ""))

; Non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Email should not start or end with '@'
(assert (not (str.prefixof "@" email)))
(assert (not (str.suffixof "@" email)))

; Some structural constraints on local part (no spaces, no '@')
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))

; Require a dot somewhere in the domain and at least two labels
(assert (= domainDotCount (num_splits domain ".")))
(assert (>= domainDotCount 2))
(assert (= domain_first_label (split_at domain "." 0)))
(assert (= tld (split_at domain "." (- domainDotCount 1))))
(assert (> (str.len domain_first_label) 0))
(assert (> (str.len tld) 1))

; Domain must not start/end with '.' and must not contain '@'
(assert (not (str.prefixof "." domain)))
(assert (not (str.suffixof "." domain)))
(assert (not (str.contains domain "@")))

; Additional domain structure: allow multiple labels; capture rest beyond first label
(assert (= domain_rest (split_rest domain "." 1)))
(assert (> (str.len domain_rest) 0))

; Constrain TLD to be alphabetic-ish via regex (at least 2 letters)
(assert (str.in_re tld (re.++ (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                                       (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))
                     (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                               (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))))

; Global dot count on entire email (at least one dot somewhere overall)
(assert (= dotCount (num_splits email ".")))
(assert (>= dotCount 2))

; Ensure the domain contains at least one '.' explicitly
(assert (str.contains domain "."))

; --- Provide a concrete witness for SAT instance
(assert (= email "alice.smith@example.co"))

; =========
; Additional instance: UNSAT constraints (separate email variable)
; =========

(declare-const email_bad String)
(declare-const local_bad String)
(declare-const domain_bad String)
(declare-const atCount_bad Int)
(declare-const domainDotCount_bad Int)
(declare-const tld_bad String)

(assert (= email_bad "bob@@example"))

; Try to enforce "exactly one @" and domain has a dot + valid TLD, which should conflict with the concrete bad email
(assert (= atCount_bad (num_splits email_bad "@")))
(assert (= atCount_bad 2))
(assert (= local_bad (split_at email_bad "@" 0)))
(assert (= domain_bad (split_at email_bad "@" 1)))
(assert (= (split_rest email_bad "@" 2) ""))

(assert (= domainDotCount_bad (num_splits domain_bad ".")))
(assert (>= domainDotCount_bad 2))
(assert (= tld_bad (split_at domain_bad "." (- domainDotCount_bad 1))))
(assert (> (str.len tld_bad) 1))
(assert (str.contains domain_bad "."))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
