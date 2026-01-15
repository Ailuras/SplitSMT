(set-logic ALL)

; Email Validation scenario using '@' and '.' delimiters via str_split interface
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

(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const sld String)
(declare-const subdomain String)
(declare-const plus_tag String)
(declare-const dom_label0 String)
(declare-const dom_label1 String)
(declare-const dom_rest_from2 String)

; Core structure: split at '@' into local and domain
(assert (= local (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))
(assert (= (num_splits email "@") 2))

; Basic non-emptiness and no spaces
(assert (> (str.len email) 3))
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (str.contains email " ")))
(assert (not (str.contains email "\u{9}")))
(assert (not (str.contains email "\u{a}")))

; Local-part constraints: forbid consecutive dots and leading/trailing dot
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Permit optional plus-tag in local-part
(assert (= plus_tag (split_at local "+" 1)))
(assert (or (= (num_splits local "+") 1) (= (num_splits local "+") 2)))
(assert (=> (= (num_splits local "+") 2) (> (str.len plus_tag) 0)))
(assert (=> (= (num_splits local "+") 2) (not (str.contains plus_tag "+"))))

; Domain structure: must have at least one '.' and at least two labels
(assert (>= (num_splits domain ".") 2))
(assert (= dom_label0 (split_at domain "." 0)))
(assert (= dom_label1 (split_at domain "." 1)))
(assert (= dom_rest_from2 (split_rest domain "." 2)))

; Require first two labels non-empty and not starting/ending with '-'
(assert (> (str.len dom_label0) 0))
(assert (> (str.len dom_label1) 0))
(assert (not (= (str.at dom_label0 0) "-")))
(assert (not (= (str.at dom_label0 (- (str.len dom_label0) 1)) "-")))
(assert (not (= (str.at dom_label1 0) "-")))
(assert (not (= (str.at dom_label1 (- (str.len dom_label1) 1)) "-")))

; Extract SLD and TLD based on last two labels when there are exactly 3 labels
(assert (=> (= (num_splits domain ".") 3)
            (and (= subdomain dom_label0)
                 (= sld dom_label1)
                 (= tld (split_at domain "." 2)))))

; If exactly 2 labels, treat them as sld.tld
(assert (=> (= (num_splits domain ".") 2)
            (and (= sld dom_label0)
                 (= tld dom_label1))))

; TLD constraints: length bounds and alphabetic-only regex
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 24))
(assert (str.in_re tld (re.+ (re.union (re.range "A" "Z") (re.range "a" "z")))))

; Domain must not contain empty labels (no consecutive dots, no leading/trailing dot)
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))

; Local-part allowed character class (relaxed): letters/digits and . _ - +
(assert (str.in_re local
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "+")))
    (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re ".") (str.to_re "_") (str.to_re "-") (str.to_re "+"))))))

; Domain label regex (relaxed): letters/digits/hyphen and dots separating labels
(assert (str.in_re domain
  (re.++
    (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-")))
    (re.* (re.++ (str.to_re ".") (re.+ (re.union (re.range "A" "Z") (re.range "a" "z") (re.range "0" "9") (str.to_re "-"))))))))

; Create both SAT and UNSAT pressure: forbid a specific bad pattern, but also require one segment structure
(assert (not (str.contains email "@.")))
(assert (not (str.contains email ".@")))

; UNSAT sub-instance trigger: if email contains "example", then require contradictory tld
; (kept conditional to preserve satisfiable overall)
(assert (=> (str.contains domain "example") (and (= tld "com") (= tld "net"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
