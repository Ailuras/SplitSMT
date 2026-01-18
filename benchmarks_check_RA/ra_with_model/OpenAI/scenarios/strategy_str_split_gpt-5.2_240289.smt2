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

; Email Validation via str_split (uninterpreted split operations)


; -----------------------------
; SAT instance: plausible complex email structure
; -----------------------------
(declare-const email_sat String)
(declare-const local_sat String)
(declare-const domain_sat String)
(declare-const dot_count_sat Int)
(declare-const tld_sat String)
(declare-const subdomain_first_sat String)
(declare-const domain_rest_sat String)
(declare-const first_label_len_sat Int)

(assert (= local_sat (split_at email_sat "@" 0)))
(assert (= domain_sat (split_at email_sat "@" 1)))
(assert (>= (num_splits email_sat "@") 2))
(assert (< (num_splits email_sat "@") 3))

; local part constraints
(assert (> (str.len local_sat) 0))
(assert (not (str.contains local_sat " ")))
(assert (not (str.contains local_sat "@")))
(assert (not (str.contains local_sat "..")))
(assert (not (str.prefixof "." local_sat)))
(assert (not (str.suffixof "." local_sat)))

; domain constraints
(assert (> (str.len domain_sat) 0))
(assert (not (str.contains domain_sat "@")))
(assert (not (str.contains domain_sat "..")))
(assert (not (str.prefixof "." domain_sat)))
(assert (not (str.suffixof "." domain_sat)))

; ensure domain has at least one dot => at least 2 labels
(assert (>= (num_splits domain_sat ".") 2))
(assert (= dot_count_sat (num_splits domain_sat ".")))

; extract first subdomain label and the rest
(assert (= subdomain_first_sat (split_at domain_sat "." 0)))
(assert (= domain_rest_sat (split_rest domain_sat "." 1)))
(assert (> (str.len subdomain_first_sat) 0))

; last label as TLD (use index dot_count-1)
(assert (>= dot_count_sat 2))
(assert (= tld_sat (split_at domain_sat "." (- dot_count_sat 1))))

; TLD constraints (typical: 2..24, alphabetic-ish via regex)
(assert (>= (str.len tld_sat) 2))
(assert (<= (str.len tld_sat) 24))
(assert (str.in_re tld_sat (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z")
                                               (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z")))))

; overall email shape constraints (weak, but useful)
(assert (not (str.contains email_sat " ")))
(assert (not (str.contains email_sat "@@")))
(assert (not (str.prefixof "@" email_sat)))
(assert (not (str.suffixof "@" email_sat)))
(assert (str.contains email_sat "@"))

; tie a concrete satisfying witness while still exercising split constraints
(assert (= email_sat "john.doe+tag@sub.mail.example.COM"))
(assert (= first_label_len_sat (str.len subdomain_first_sat)))
(assert (> first_label_len_sat 0))

(assert (= subdomain_first_sat "@"))
(assert (= domain_sat "["))
(assert (= email_sat "john.doe+tag@sub.mail.example.COM"))
(assert (= tld_sat "Za"))
(assert (= first_label_len_sat 1))
(assert (= domain_rest_sat ""))
(assert (= local_sat "["))
(assert (= dot_count_sat 21657))
(check-sat)
(exit)
