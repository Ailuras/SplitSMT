(set-logic ALL)

; Email Validation scenario: validate structure using '@' and '.' as delimiters,
; while preserving seed-style negative regex constraints.

(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const dom0 String)
(declare-const dom1 String)
(declare-const dom2 String)
(declare-const recomposed String)

; str_split interface
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

; Preserve core structure: keep the seed's negative regex constraints (mutated minimally)
(assert (not (str.in_re X (re.++ (str.to_re "<b>") (re.+ (re.union (str.to_re "<") (str.to_re ">"))) (str.to_re "</b>\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "User-Agent:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "community") (re.+ (re.range "0" "9")) (str.to_re "\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "\u{5c}s\u{5c}") ((_ re.loop 2 2) (str.to_re "d")) (str.to_re "-\u{5c}") ((_ re.loop 3 3) (str.to_re "w")) (str.to_re "-\u{5c}") ((_ re.loop 4 4) (str.to_re "d")) (str.to_re "\u{a}")))))

; Core email split constraints
(assert (>= (str.len X) 3))
(assert (>= (num_splits X "@") 2))
(assert (= (num_splits X "@") 2))
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 3))

; No spaces or control chars in the email
(assert (not (str.contains X " ")))
(assert (not (str.contains X "\u{9}")))
(assert (not (str.contains X "\u{a}")))
(assert (not (str.contains X "\u{d}")))

; Local part constraints: must not start or end with '.' and must not contain ".."
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; Domain must have at least one dot; constrain segment structure via '.' split
(assert (>= (num_splits domain ".") 2))
(assert (= dom0 (split_at domain "." 0)))
(assert (= dom1 (split_at domain "." 1)))
(assert (= dom2 (split_at domain "." 2)))

; First two domain labels non-empty and must not contain '@'
(assert (>= (str.len dom0) 1))
(assert (>= (str.len dom1) 1))
(assert (not (str.contains dom0 "@")))
(assert (not (str.contains dom1 "@")))

; Basic label sanity: no empty label due to consecutive dots at the beginning
(assert (not (= (str.at domain 0) ".")))
(assert (not (str.contains domain "..")))

; Top-level domain rules (two alternatives):
; - If exactly 2 labels: dom1 is TLD length 2..6
; - If 3+ labels: dom2 is TLD length 2..6 and split_rest from 2 equals dom2 (forces exactly 3 labels)
(assert (or (and (= (num_splits domain ".") 2)
                 (>= (str.len dom1) 2)
                 (<= (str.len dom1) 6))
            (and (= (num_splits domain ".") 3)
                 (= (split_rest domain "." 2) dom2)
                 (>= (str.len dom2) 2)
                 (<= (str.len dom2) 6))))

; Recompose and force equality to ensure split functions are consistent for this instance
(assert (= recomposed (str.++ local "@" domain)))
(assert (= X recomposed))

; Make it concrete enough to be satisfiable: enforce a common domain prefix
(assert (or (str.contains domain "example") (str.contains domain "mail")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
