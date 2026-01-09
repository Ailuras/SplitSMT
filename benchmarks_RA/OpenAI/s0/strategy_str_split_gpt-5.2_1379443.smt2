(set-logic ALL)

; Uninterpreted split interface
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

; ======================
; SAT instance: valid-ish email structure
; ======================
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const tld_sat String)
(declare-const domain_tail_sat String)
(declare-const label0_sat String)
(declare-const label1_sat String)
(declare-const label2_sat String)

; Exactly one '@' => two segments
(assert (= (num_splits email_sat "@") 2))
(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))

; Local part constraints (non-empty, no spaces, no extra '@')
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (= (num_splits local_sat "@") 1))

; Domain constraints (at least 2 labels separated by '.')
(assert (>= (num_splits domain_sat ".") 2))
(assert (= label0_sat (split_at domain_sat "." 0)))
(assert (= label1_sat (split_at domain_sat "." 1)))
(assert (= domain_tail_sat (split_rest domain_sat "." 1)))
(assert (= tld_sat (split_at domain_sat "." (- (num_splits domain_sat ".") 1))))

; Domain label constraints: non-empty, no spaces
(assert (> (str.len label0_sat) 0))
(assert (> (str.len label1_sat) 0))
(assert (not (str.contains domain_sat " ")))

; TLD constraints: length 2..24 and alphabetic lowercase only
(assert (and (>= (str.len tld_sat) 2) (<= (str.len tld_sat) 24)))
(assert (str.in_re tld_sat (re.+ (re.range "a" "z"))))

; Additional realistic domain shape: allow multiple labels, but require last two labels exist
(assert (>= (num_splits domain_sat ".") 2))

; Concrete witness to ensure satisfiable
(assert (= email_sat "john.doe+tag@sub.example.co"))

; ======================
; UNSAT instance: contradictory segment-count / structure requirements
; ======================
(declare-const email_unsat String)
(declare-const local_unsat String)
(declare-const domain_unsat String)
(declare-const tld_unsat String)
(declare-const label0_unsat String)
(declare-const label1_unsat String)

; Force exactly one '@'
(assert (= (num_splits email_unsat "@") 2))
(assert (= local_unsat (split_at email_unsat "@" 0)))
(assert (= domain_unsat (split_at email_unsat "@" 1)))

; Also (contradiction): force zero '@' splits
(assert (= (num_splits email_unsat "@") 1))

; Domain wants at least two '.' labels
(assert (>= (num_splits domain_unsat ".") 2))
(assert (= label0_unsat (split_at domain_unsat "." 0)))
(assert (= label1_unsat (split_at domain_unsat "." 1)))
(assert (> (str.len label0_unsat) 0))
(assert (> (str.len label1_unsat) 0))

; TLD wants to be purely lowercase letters
(assert (= tld_unsat (split_at domain_unsat "." (- (num_splits domain_unsat ".") 1))))
(assert (str.in_re tld_unsat (re.+ (re.range "a" "z"))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
