(set-logic ALL)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; We use split_at/num_splits/split_rest as an abstract split interface.

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

(declare-const X String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hms String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const tag String)

; Preserve core structure from seed: keep a negated regex membership constraint on X.
(assert
  (not
    (str.in_re
      X
      (re.++
        (str.to_re "/")
        (re.union (str.to_re "\u{19}\u{0}") (str.to_re "\u{0}\u{5c}"))
        (str.to_re "\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")
      )
    )
  )
)

; Parse log format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (>= (num_splits X " ") 3))
(assert (= ts (str.++ (split_at X " " 0) " " (split_at X " " 1))))
(assert (= level (split_at X " " 2)))
(assert (= msg (split_rest X " " 3)))

; The 2nd token should contain a colon-separated time; overall timestamp uses a space.
(assert (>= (num_splits ts " ") 2))
(assert (= date (split_at ts " " 0)))
(assert (= time (split_at ts " " 1)))

; Validate date format YYYY-MM-DD with digits only.
(assert (str.in_re date (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; Validate time format HH:MM:SS with digits only.
(assert (str.in_re time (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))

; Extract HH,MM,SS via split on ':'
(assert (>= (num_splits time ":") 3))
(assert (= hh (split_at time ":" 0)))
(assert (= mm (split_at time ":" 1)))
(assert (= ss (split_at time ":" 2)))

; Constrain log level and require a colon appears after it in the remaining message.
(assert (str.in_re level (re.union (str.to_re "INFO")
                                   (re.union (str.to_re "WARN")
                                             (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; The rest-of-line message should be non-empty and include a tag before a ':' such as "auth:".
(assert (>= (str.len msg) 1))
(assert (>= (num_splits msg ":") 2))
(assert (= tag (split_at msg ":" 0)))
(assert (str.in_re tag (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9"))))
                               (re.* (str.to_re "-")))))

; Create diversity: add a concrete SAT witness pattern for X consistent with constraints.
(assert (= X "2025-01-09 12:34:56 INFO auth: login ok"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
