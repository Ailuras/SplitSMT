(set-logic ALL)

; Uninterpreted interface for string splitting
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

; Input HTTP request (headers section)
(declare-const req String)

; Extracted header lines (split by LF)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const line3 String)

; Header names and values (split by ":")
(declare-const host_name String)
(declare-const host_val String)
(declare-const cl_name String)
(declare-const cl_val String)

; A numeric content-length parsed elsewhere
(declare-const content_len Int)

; Preserve core structure: a regex-based disequality over in_re, now applied to req
(assert (let ((_let_0 (re.* re.allchar)))
  (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "B" "A"))) _let_0 (str.to_re "A") _let_0))
          (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "B")) _let_0 (str.to_re (str.++ "A" "A")) _let_0))))))

; HTTP header parsing: split request into lines by "\n"
(assert (= line0 (split_at req "\n" 0)))
(assert (= line1 (split_at req "\n" 1)))
(assert (= line2 (split_at req "\n" 2)))
(assert (= line3 (split_at req "\n" 3)))
(assert (>= (num_splits req "\n") 4))

; Basic structure constraints for header lines
(assert (str.contains line1 ":"))
(assert (str.contains line2 ":"))
(assert (not (str.contains line3 ":")))

; Parse Host header: "Host: <value>"
(assert (= host_name (split_at line1 ":" 0)))
(assert (= host_val (split_rest line1 ":" 1)))
(assert (= host_name "Host"))
(assert (> (str.len host_val) 0))
(assert (not (str.contains host_val "\n")))

; Parse Content-Length header: "Content-Length: <digits>"
(assert (= cl_name (split_at line2 ":" 0)))
(assert (= cl_val (split_rest line2 ":" 1)))
(assert (= cl_name "Content-Length"))

; cl_val must contain at least one digit somewhere
(assert (str.in_re cl_val (re.++ (re.* re.allchar) (re.range "0" "9") (re.* re.allchar))))

; Trim-like restriction: forbid spaces in cl_val to simplify numeric validation
(assert (not (str.contains cl_val " ")))

; content_len matches cl_val exactly, but also enforce an impossible extra condition to make this UNSAT
(assert (= cl_val (str.from_int content_len)))
(assert (>= content_len 0))

; Intentional contradiction for diversity (UNSAT instance):
; If cl_val equals from_int(content_len) and content_len>=0, then cl_val cannot be empty.
; Force empty anyway.
(assert (= cl_val ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
