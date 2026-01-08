; Email Validation scenario: split-based structural constraints + mutated regex core
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

; str_split interface

; Primary input email
(declare-const var0 String)

; Derived segments
(declare-const local String)
(declare-const domain String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const tld String)

; Helper booleans to create both SAT and UNSAT branches
(declare-const force_unsat Bool)

; Core structure: exactly one '@'
(assert (>= (num_splits var0 "@") 2))
(assert (= 2 (num_splits var0 "@")))
(assert (= local (split_at var0 "@" 0)))
(assert (= domain (split_at var0 "@" 1)))
(assert (= domain (split_rest var0 "@" 1)))

; Local-part constraints: non-empty, no '.' at ends, contains no '@'
(assert (> (str.len local) 0))
(assert (not (str.contains local "@")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: must contain at least one '.' and have at least 2 labels
(assert (>= (num_splits domain ".") 2))
(assert (= dom_label0 (split_at domain "." 0)))
(assert (= dom_label1 (split_at domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (> (str.len dom_label0) 0))
(assert (> (str.len tld) 1))

; Domain must not contain '@' and cannot start/end with '.'
(assert (not (str.contains domain "@")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Mutated/extended seed-like regex core, adapted for email-ish alphabet.
; We define a restricted alphabet and require local and domain pieces to be in it.
(assert (str.in_re local
  (re.++
    (re.union (re.+ (str.to_re "a")) (re.+ (str.to_re "b")))
    (re.* (re.union (str.to_re "0") (str.to_re "1"))))))

(assert (str.in_re domain
  (re.++
    (re.+ (re.union (str.to_re "a") (str.to_re "b")))
    (re.++ (str.to_re ".")
           (re.++ (re.+ (re.union (str.to_re "a") (str.to_re "b")))
                  (re.* (re.union (str.to_re ".") (re.union (str.to_re "a") (str.to_re "b")))))))))

; Ensure the email is exactly local@domain
(assert (= var0 (str.++ local (str.++ "@" domain))))

; Add a mixed SAT/UNSAT feature: if force_unsat then contradict domain splitting
; This preserves overall structure but allows generating UNSAT by setting force_unsat = true.
(assert (=> force_unsat (and (= 1 (num_splits var0 "@")) (= 0 (str.len local)))))

; Also constrain TLD to be alphabetic-like per our reduced alphabet
(assert (str.in_re tld (re.++ (re.+ (str.to_re "a")) (re.* (str.to_re "b")))))

; Make one concrete satisfiable example possible when force_unsat is false
(assert (or force_unsat (= var0 "ab1@ab.ab")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
