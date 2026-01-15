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

; Email Validation scenario using '@' and '.' as delimiters with str_split interface


(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const label0 String)
(declare-const label1 String)

; Preserve core structure: attack matches a regex built from prefix, a fixed loop of infix, and postfix
(assert (str.in_re attack (re.++ prefix ((_ re.loop 50 50) infix) postfix)))

; Mutated prefix/infix/postfix to align with email-like components
; prefix: literal '1'
(assert (= prefix (str.to_re "\u{31}")))

; infix: allow many local-part characters and separators ('.' '_' '+'), excluding '@' by construction
(assert (= infix (re.+ (re.union (re.range "a" "z")
                                (re.range "A" "Z")
                                (re.range "0" "9")
                                (str.to_re ".")
                                (str.to_re "_")
                                (str.to_re "+")))))

; postfix: end with '@' to ensure result becomes a candidate email when concatenated with postfixs
(assert (= postfix (str.to_re "\u{40}")))

; postfixs: domain part must contain at least one '.' and end with a TLD of length 2..6 alphabetic
(assert (str.in_re postfixs (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
                                  (re.++ (str.to_re ".")
                                         (re.++ (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))
                                                (re.++ (str.to_re ".")
                                                       ((_ re.loop 2 6) (re.union (re.range "a" "z") (re.range "A" "Z")))))))))
(assert (>= (str.len postfixs) 1))

; Construct full email candidate
(assert (= result (str.++ attack postfixs)))
(assert (= email result))

; Split-based validation constraints
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (= (num_splits email "@") 2))
(assert (>= (str.len local) 1))
(assert (>= (str.len domain) 1))

; Domain must have at least two labels when split by '.'
(assert (>= (num_splits domain ".") 2))
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))
(assert (>= (str.len label0) 1))
(assert (>= (str.len label1) 1))

; TLD is last segment: constrain it using a regex and length bounds
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; Basic sanity: local part should not contain '@' and domain should not contain '@'
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
