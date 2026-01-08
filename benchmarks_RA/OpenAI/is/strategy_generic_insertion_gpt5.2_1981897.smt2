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
(declare-const X String)
(assert (str.in_re X (re.++ (re.opt (re.++ (str.to_re "CZ") (re.opt (str.to_re "-")))) ((_ re.loop 8 10) (re.range "0" "9")) (str.to_re "\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/cgi/logurl.cgi") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:User-Agent:Surveillance\u{13}com\u{a}")))))

; --- START CONSTRAINT ---

(declare-const prefix String)
(declare-const tail_after_cz String)
(declare-const digits8to10 String)
(declare-const last_char String)

(assert (= prefix (split_at X "CZ" 0)))
(assert (= tail_after_cz (split_at X "CZ" 1)))
(assert (or (= (num_splits X "CZ") 1) (= (num_splits X "CZ") 2)))

; tail_after_cz is either "" (no CZ) or begins with optional "-" then digits then "\n"
(assert (or (= tail_after_cz "") (str.prefixof "-" tail_after_cz) (str.prefixof "0" tail_after_cz) (str.prefixof "1" tail_after_cz) (str.prefixof "2" tail_after_cz) (str.prefixof "3" tail_after_cz) (str.prefixof "4" tail_after_cz) (str.prefixof "5" tail_after_cz) (str.prefixof "6" tail_after_cz) (str.prefixof "7" tail_after_cz) (str.prefixof "8" tail_after_cz) (str.prefixof "9" tail_after_cz)))

; isolate the final LF and ensure it is present as last character
(assert (>= (str.len X) 1))
(assert (= last_char (str.substr X (- (str.len X) 1) 1)))
(assert (= last_char "\n"))

; split using the LF; must end with LF so last segment is empty
(assert (>= (num_splits X "\n") 2))
(assert (= (split_at X "\n" (- (num_splits X "\n") 1)) ""))

; constrain that X does not contain the forbidden CGI prefix by requiring the part before it equals X
(assert (= (num_splits X "/cgi/logurl.cgi") 1))
(assert (= (split_at X "/cgi/logurl.cgi" 0) X))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
