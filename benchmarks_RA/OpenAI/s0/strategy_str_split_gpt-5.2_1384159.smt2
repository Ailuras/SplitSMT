(set-logic ALL)

; Uninterpreted interface for str_split
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

; Primary email variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain_part String)
(declare-const domain_label0 String)
(declare-const domain_label1 String)
(declare-const tld String)
(declare-const reconstructed String)

; Additional variables for mixed constraints
(declare-const email2 String)
(declare-const local2 String)
(declare-const domain2 String)
(declare-const bad_email String)
(declare-const bad_local String)
(declare-const bad_domain String)

; -------------------------
; SAT instance: plausible complex email validation constraints
; -------------------------

; email should have exactly one '@' meaning two segments when split
(assert (= (num_splits email "@") 2))
(assert (= local_part (split_at email "@" 0)))
(assert (= domain_part (split_at email "@" 1)))

; local part: non-empty, no spaces, no additional '@'
(assert (>= (str.len local_part) 1))
(assert (not (str.contains local_part " ")))
(assert (= (num_splits local_part "@") 1))

; local part: must not start or end with '.' (simple sanity)
(assert (not (= (str.at local_part 0) ".")))
(assert (not (= (str.at local_part (- (str.len local_part) 1)) ".")))

; domain part must contain at least one '.' => at least two labels
(assert (>= (num_splits domain_part ".") 2))

; first two labels and TLD via split_at
(assert (= domain_label0 (split_at domain_part "." 0)))
(assert (= domain_label1 (split_at domain_part "." 1)))
(assert (= tld (split_at domain_part "." (- (num_splits domain_part ".") 1))))

; domain labels: non-empty
(assert (>= (str.len domain_label0) 1))
(assert (>= (str.len domain_label1) 1))
(assert (>= (str.len tld) 2))

; domain labels should not contain '@' or spaces
(assert (= (num_splits domain_part "@") 1))
(assert (not (str.contains domain_part " ")))

; reconstructed email equals local@domain
(assert (= reconstructed (str.++ local_part "@" domain_part)))
(assert (= reconstructed email))

; additional: constrain email to match a permissive regex for sanity
; local: letters/digits and ._%+- at least 1
; domain: labels of letters/digits/hyphen with dots, TLD letters length >=2 (approximated)
(assert (str.in_re email
  (re.++
    (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                    (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                    (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                    (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                    (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                    (str.to_re "z")
                    (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                    (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                    (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                    (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                    (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                    (str.to_re "Z")
                    (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                    (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                    (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-") ))
    (str.to_re "@")
    (re.++
      (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                      (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                      (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                      (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                      (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                      (str.to_re "z")
                      (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                      (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                      (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                      (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                      (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                      (str.to_re "Z")
                      (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                      (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                      (str.to_re "-") ))
      (re.* (re.++ (str.to_re ".")
                   (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                                   (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                                   (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                                   (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                                   (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                                   (str.to_re "z")
                                   (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                                   (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                                   (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                                   (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                                   (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                                   (str.to_re "Z")
                                   (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4")
                                   (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9")
                                   (str.to_re "-") ))))
      (str.to_re ".")
      (re.++
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")
                  (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                  (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                  (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                  (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                  (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                  (str.to_re "Z"))
        (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                  (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                  (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                  (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                  (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                  (str.to_re "z")
                  (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                  (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                  (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                  (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                  (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                  (str.to_re "Z"))
        (re.* (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e")
                        (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j")
                        (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o")
                        (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t")
                        (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y")
                        (str.to_re "z")
                        (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E")
                        (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J")
                        (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O")
                        (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T")
                        (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y")
                        (str.to_re "Z"))))))))

; Ensure email has at least one '.' after '@' by relating to split_rest
(assert (= (split_rest email "@" 1) domain_part))
(assert (str.contains domain_part "."))

; -------------------------
; Second SAT instance: another email with stricter domain label count
; -------------------------
(assert (= (num_splits email2 "@") 2))
(assert (= local2 (split_at email2 "@" 0)))
(assert (= domain2 (split_at email2 "@" 1)))
(assert (>= (str.len local2) 3))
(assert (>= (num_splits domain2 ".") 3))
(assert (>= (str.len (split_at domain2 "." 0)) 1))
(assert (>= (str.len (split_at domain2 "." 1)) 1))
(assert (>= (str.len (split_at domain2 "." 2)) 2))
(assert (not (str.contains email2 " ")))

; -------------------------
; UNSAT instance: contradictory constraints for a "bad" email
; -------------------------
(assert (= (num_splits bad_email "@") 2))
(assert (= bad_local (split_at bad_email "@" 0)))
(assert (= bad_domain (split_at bad_email "@" 1)))

; Force no dots in domain but also require at least two dot-splits -> contradiction
(assert (= (num_splits bad_domain ".") 1))
(assert (>= (num_splits bad_domain ".") 2))

; Additional contradiction: local part non-empty but equal to empty
(assert (>= (str.len bad_local) 1))
(assert (= bad_local ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
