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

; --- Uninterpreted interface operations: str_split ---

; --- HTTP header parsing variables ---
(declare-const request String)
(declare-const header_block String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const content_len Int)
(declare-const body String)

; Mutated seed core structure: keep a simple contradictory-free string-length fact
(assert (not (not (= (str.len "") 0))))

; Split request into headers and body at CRLFCRLF
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_at request "\r\n\r\n" 1)))
(assert (>= (num_splits request "\r\n\r\n") 2))

; Split header block into lines at CRLF
(assert (>= (num_splits header_block "\r\n") 3))
(assert (= line0 (split_at header_block "\r\n" 0)))
(assert (= line1 (split_at header_block "\r\n" 1)))

; Parse line0 as Host: <value>
(assert (= host_key (split_at line0 ":" 0)))
(assert (= host_val (split_rest line0 ":" 1)))
(assert (= host_key "Host"))
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))
(assert (not (str.contains host_val ":")))
(assert (>= (str.len host_val) 1))

; Parse line1 as Content-Length: <digits>
(assert (= cl_key (split_at line1 ":" 0)))
(assert (= cl_val (split_rest line1 ":" 1)))
(assert (= cl_key "Content-Length"))

; Content-Length value must be numeric digits only (non-empty)
(assert (str.in_re cl_val (re.++ (str.to_re "") (re.+ (re.range "0" "9")))))

; Relate the numeric value to body length (simple integer binding)
(assert (>= content_len 0))
(assert (= (str.len body) content_len))

; Additional sanity: no embedded CRLF in individual header lines
(assert (not (str.contains line0 "\r\n")))
(assert (not (str.contains line1 "\r\n")))

; --- Make this instance UNSAT: contradict Content-Length with body length ---
(assert (= content_len (+ (str.len body) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
