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

; Scenario: Email Validation using '@' and '.' delimiters

; str_split interface

; Variables
(declare-const X String)            ; candidate email
(declare-const local String)
(declare-const domain String)
(declare-const dom_first String)
(declare-const dom_rest String)
(declare-const tld String)
(declare-const second_level String)

; Preserve some core structure from seed: keep negative regex membership constraints (mutated to be email-related)
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".pui/i\u{a}")))))
(assert (not (str.in_re X (str.to_re "pjpoptwql/rlnjsportsHost:Subject:YAHOOdestroyed!\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "<")
                               (re.+ (re.union (str.to_re "\u{22}") (str.to_re " ") (str.to_re "'") (str.to_re "#")
                                              (str.to_re "*") (str.to_re "=") (str.to_re ",") (str.to_re ".")
                                              (str.to_re "\u{5c}") (str.to_re "(") (str.to_re ")") (str.to_re "/")
                                              (str.to_re "-") (str.to_re "$") (str.to_re "{") (str.to_re "}")
                                              (str.to_re "[") (str.to_re "]") (str.to_re "|") (str.to_re "?")
                                              (str.to_re "+") (str.to_re "^") (str.to_re "&") (str.to_re ":")
                                              (str.to_re "%") (str.to_re ";") (str.to_re "!")
                                              (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_")))
                               (str.to_re ">\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "now") (re.+ (re.range "0" "9")) (str.to_re "/bar_pl/shdoclc.fcgiareHost:e2give.com\u{a}")))))

; Email split constraints
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= "" (split_at X "@" 2)))
(assert (= 2 (num_splits X "@")))
(assert (= (str.++ local "@" domain) X))

; Basic well-formedness
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain "..")))
(assert (not (str.contains domain ".")))

; Domain must contain at least one '.' and have a TLD segment
(assert (>= (num_splits domain ".") 2))
(assert (= dom_first (split_at domain "." 0)))
(assert (= dom_rest (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len dom_first) 1))
(assert (>= (str.len tld) 2))

; If domain has exactly two labels, the first is second-level; otherwise second-level is penultimate
(assert (ite (= (num_splits domain ".") 2)
            (= second_level (split_at domain "." 0))
            (= second_level (split_at domain "." (- (num_splits domain ".") 2)))))
(assert (>= (str.len second_level) 1))

; Character constraints via regex: local part and labels are limited to common email-safe chars
(declare-const local_safe_re RegLan)
(declare-const label_safe_re RegLan)

(assert (= local_safe_re
           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")
                           (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))
(assert (= label_safe_re
           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

(assert (str.in_re local local_safe_re))
(assert (str.in_re dom_first label_safe_re))
(assert (str.in_re second_level label_safe_re))
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Additional structure: local cannot start or end with '.' and cannot contain consecutive dots
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; UNSAT core: contradictory domain constraints (forces no '.' but also requires at least one '.')
; These two together make the instance UNSAT.
(assert (not (str.contains domain ".")))
(assert (>= (num_splits domain ".") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
