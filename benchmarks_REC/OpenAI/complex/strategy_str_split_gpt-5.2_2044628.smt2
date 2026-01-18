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

; Uninterpreted split interface

; Seed structure (mutated/extended) with meaningful variables
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-const var_0xINPUT_130984 String)

; Email-specific variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)
(declare-const firstLabel String)
(declare-const secondLabel String)
(declare-const restLabels String)
(declare-const atCount Int)
(declare-const dotCount Int)

; Preserve core structure: T_1, T_2, and a final assertion that drives satisfiability
(assert (= T_1 (not (= "file:" var_0xINPUT_130984))))
(assert (= T_2 (not T_1)))

; Connect input to email scenario
(assert (= email var_0xINPUT_130984))

; Email must have exactly one '@' (2 segments after split)
(assert (= atCount (num_splits email "@")))
(assert (= atCount 2))
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Local-part basic sanity (non-empty, no spaces, no extra '@')
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (= (num_splits local "@") 1))

; Domain must contain at least one '.' and have at least two labels
(assert (= dotCount (num_splits domain ".")))
(assert (>= dotCount 2))

; Extract labels and suffix structure
(assert (= firstLabel (split_at domain "." 0)))
(assert (= secondLabel (split_at domain "." 1)))
(assert (= restLabels (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- dotCount 1))))
(assert (= subdomain (split_rest domain "." 0)))

; Label constraints: non-empty, no spaces
(assert (> (str.len firstLabel) 0))
(assert (> (str.len secondLabel) 0))
(assert (not (str.contains domain " ")))

; TLD constraints: length between 2 and 24, cannot contain '.'
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))
(assert (= (num_splits tld ".") 1))

; Forbid obvious malformed cases
(assert (not (str.contains email "..")))
(assert (not (str.contains email "@@")))
(assert (not (str.contains email "@.")))
(assert (not (str.contains email ".@")))

; Create a deliberate contradiction tied to the domain segmentation:
; If domain has >=2 labels then split_rest from 1 must contain a '.', but simultaneously force it to have no '.'
(assert (str.contains restLabels "."))
(assert (= (num_splits restLabels ".") 1))

; Drive UNSAT through preserved seed gate: T_2 is (not T_1)
; This forces email == "file:" but that violates the email structure above (atCount must be 2)
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
