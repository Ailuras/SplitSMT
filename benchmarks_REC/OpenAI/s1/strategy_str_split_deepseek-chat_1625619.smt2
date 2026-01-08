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

; Email Validation scenario using str_split interface

(declare-fun key1 () String)
(declare-fun value2 () String)
(declare-fun key2 () String)
(declare-fun value1 () String)

(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)

; Preserve some seed structure (cache-control keys) but repurpose values as unrelated headers
(assert (= key1 "cache-control"))
(assert (= key2 "cache-control"))

; Keep a lightweight mutation of the seed idea: value1 contains '=' and ',' (header-like)
(assert (str.contains value1 "="))
(assert (not (= (str.indexof value1 "=" 0) (- 1))))
(assert (str.contains value1 ","))
(assert (> (str.len value1) 3))

; Constrain value2 to be non-empty and contain some uppercase marker (kept from seed but simplified)
(assert (> (str.len value2) 0))
(assert (str.contains value2 "A"))
(assert (str.contains value2 "Z"))

; Core email constraints
(assert (> (str.len email) 5))
(assert (str.contains email "@"))
(assert (= (num_splits email "@") 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_at email "@" 1)))

; local-part must be non-empty and cannot contain '@'
(assert (> (str.len local_part) 0))
(assert (= (str.indexof local_part "@" 0) (- 1)))

; domain must contain at least one dot and have at least 2 labels
(assert (str.contains domain_part "."))
(assert (>= (num_splits domain_part ".") 2))

; enforce at least three labels: e.g., sub.example.tld
(assert (>= (num_splits domain_part ".") 3))
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." 2)))

; labels non-empty
(assert (> (str.len domain_label0) 0))
(assert (> (str.len domain_label1) 0))
(assert (> (str.len tld) 1))

; disallow empty labels caused by leading/trailing/consecutive dots
(assert (not (= (str.at domain_part 0) ".")))
(assert (not (= (str.at domain_part (- (str.len domain_part) 1)) ".")))
(assert (= (str.indexof domain_part ".." 0) (- 1)))

; simple structural reconstruction check
(assert (= reconstructed (str.++ local_part "@" domain_part)))
(assert (= email reconstructed))

; Mix in a regex-based policy: local-part chars and basic domain/tld policy
(declare-const re_atom RegLan)
(declare-const re_local RegLan)
(declare-const re_label RegLan)
(declare-const re_tld RegLan)
(declare-const re_domain RegLan)

(assert (= re_atom (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_") (str.to_re "-") (str.to_re "."))))
(assert (= re_local (re.++ re_atom (re.* re_atom))))
(assert (= re_label (re.++ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")) (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-"))) )))
(assert (= re_tld (re.++ (re.range "a" "z") (re.* (re.range "a" "z")))))
(assert (= re_domain (re.++ re_label (str.to_re ".") re_label (str.to_re ".") re_tld)))

(assert (str.in_re local_part re_local))
(assert (str.in_re domain_part re_domain))

; UNSAT twist: simultaneously require two different TLDs
(assert (= tld "com"))
(assert (= tld "org"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
