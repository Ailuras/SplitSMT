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

; --- Uninterpreted interface for str_split ---

; --- Seed-preserved literals and regex structure (mutated/extended) ---
(declare-const literal_4 String)
(assert (= literal_4 "\u{74}\u{61}\u{6b}\u{65}\u{6e}\u{3a}"))
; Keep the overall pattern: anything then a specific marker then anything
(assert (str.in_re literal_4
  (re.++ (re.* re.allchar)
    (re.++ (str.to_re "\u{5c}\u{3c}\u{53}\u{43}\u{52}\u{49}\u{50}\u{54}") (re.* re.allchar)))))

; --- Scenario: Email Validation using '@' and '.' delimiters ---
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const host String)
(declare-const tld String)
(declare-const firstLabel String)
(declare-const secondLabel String)

; Basic split at '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= "" (split_at email "@" 2)))
(assert (= 2 (num_splits email "@")))

; Local part non-empty, domain non-empty
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; No nested '@' inside local or domain
(assert (= 1 (num_splits local "@")))
(assert (= 1 (num_splits domain "@")))

; Domain split by '.' must have at least 2 labels: host + tld
(assert (>= (num_splits domain ".") 2))
(assert (= host (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (> (str.len host) 0))
(assert (> (str.len tld) 0))

; Ensure tld itself has no '.' (i.e., exactly one segment when split)
(assert (= 1 (num_splits tld ".")))

; Constrain domain to have at most 3 labels (e.g., a.b.c is allowed, a.b.c.d not)
(assert (<= (num_splits domain ".") 3))

; If 3 labels, expose them; otherwise secondLabel may be empty
(assert (= firstLabel (split_at domain "." 0)))
(assert (= secondLabel (split_at domain "." 1)))
(assert (> (str.len firstLabel) 0))
(assert (> (str.len secondLabel) 0))

; Character-level approximations via regex: forbid spaces in email
(assert (not (str.contains email " ")))

; SAT vs UNSAT diversity block: force an UNSAT condition when a flag is true
(declare-const force_unsat Bool)

; When forcing UNSAT, require both exactly one '.' in domain AND at least three labels simultaneously
(assert (=> force_unsat (and (= 2 (num_splits domain ".")) (>= (num_splits domain ".") 3))))

; Provide a satisfiable instantiation when not forcing UNSAT
(assert (=> (not force_unsat)
  (and
    (= email "alice.smith@example.com")
    (= local "alice.smith")
    (= domain "example.com")
    (= host "example")
    (= tld "com"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
