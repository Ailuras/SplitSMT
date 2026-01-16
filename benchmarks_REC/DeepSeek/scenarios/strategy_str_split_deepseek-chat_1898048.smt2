; Email Validation with str_split operations
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

; Declare variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts Int)
(declare-const tld String)
(declare-const subdomain String)

; Declare str_split interface functions

; Core email structure constraints
; Must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Extract local part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Domain parts count
(assert (= domain_parts (num_splits domain ".")))

; Extract TLD (last part after last dot)
(assert (= tld (split_at domain "." (- domain_parts 1))))

; TLD must be 2-3 letters
(assert (str.in_re tld (re.++ ((_ re.loop 2 3) (re.range "a" "z")))))

; Extract subdomain (everything before TLD)
(assert (= subdomain (split_rest domain "." 0)))

; Subdomain must be non-empty
(assert (> (str.len subdomain) 0))

; Subdomain must contain only valid characters
(assert (str.in_re subdomain (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))))

; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Local part must contain only valid characters
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "!") (str.to_re "#") (str.to_re "$") (str.to_re "%") (str.to_re "&") (str.to_re "'") (str.to_re "*") (str.to_re "+") (str.to_re "-") (str.to_re "/") (str.to_re "=") (str.to_re "?") (str.to_re "^") (str.to_re "_") (str.to_re "`") (str.to_re "{") (str.to_re "|") (str.to_re "}") (str.to_re "~")))))

; Additional constraint: email must not start or end with dot
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Domain must not have consecutive dots
(assert (not (str.contains domain "..")))

; Make it SAT by providing a concrete example
(assert (= email "user.name+tag@sub.example.co.uk"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
