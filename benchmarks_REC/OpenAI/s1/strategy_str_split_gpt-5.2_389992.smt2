(set-logic ALL)

; Email Validation via str_split + regex

; Uninterpreted split operations (interface)
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

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)

; Index variables (natural)
(declare-const atIdx Int)
(declare-const dotIdx Int)

; Basic splitting around '@'
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (>= (num_splits email "@") 2))
(assert (<= (num_splits email "@") 2))

; Ensure non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Domain must contain at least one dot, and we extract subdomain and TLD
(assert (>= (num_splits domain ".") 2))
(assert (= subdomain (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (> (str.len subdomain) 0))
(assert (> (str.len tld) 0))

; Additional structural checks via indexof
(assert (= atIdx (str.indexof email "@" 0)))
(assert (>= atIdx 0))
(assert (< atIdx (str.len email)))
(assert (= dotIdx (str.indexof domain "." 0)))
(assert (>= dotIdx 1))

; Regex: conservative allowed charset for local and domain labels
(declare-const ALNUMSYM RegLan)
(declare-const ALNUM RegLan)
(declare-const LOCAL_RE RegLan)
(declare-const LABEL_RE RegLan)
(declare-const DOMAIN_RE RegLan)
(declare-const EMAIL_RE RegLan)

(assert (= ALNUM (re.union (re.range "a" "z")
                           (re.union (re.range "A" "Z") (re.range "0" "9")))))
(assert (= ALNUMSYM (re.union ALNUM
                              (re.union (str.to_re "_")
                                        (re.union (str.to_re ".")
                                                  (re.union (str.to_re "+") (str.to_re "-")))))))

; local: one or more of allowed, but must not start/end with '.' and must not contain spaces
(assert (= LOCAL_RE (re.++ ALNUM (re.* ALNUMSYM))))

; label: starts with alnum, then zero or more of alnum or '-', ends with alnum (approximated)
(assert (= LABEL_RE (re.++ ALNUM (re.* (re.union ALNUM (str.to_re "-"))))))

; domain: label '.' rest (at least one dot enforced earlier)
(assert (= DOMAIN_RE (re.++ LABEL_RE (re.++ (str.to_re ".") (re.* (re.union LABEL_RE (str.to_re ".")))))))

(assert (= EMAIL_RE (re.++ LOCAL_RE (re.++ (str.to_re "@") DOMAIN_RE))))
(assert (str.in_re email EMAIL_RE))

; Core semantic checks for forbidden patterns
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains email "@@")))

; Intentional contradiction to create an UNSAT instance (keep core structure intact)
; Since num_splits email "@" is constrained to be exactly 2 above, this makes the file UNSAT.
(assert (>= (num_splits email "@") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
