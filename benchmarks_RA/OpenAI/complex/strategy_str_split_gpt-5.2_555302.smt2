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

; Uninterpreted split interface

; Seed-style booleans preserved/mutated
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)

; HTTP header parsing scenario variables
(declare-const var_0xINPUT_10301 String) ; raw HTTP request headers (and possibly request line)
(declare-const headers String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const content_length Int)

; Core structure from seed: T_1 denotes non-empty input
(assert (= T_1 (not (= "" var_0xINPUT_10301))))
; Mutated: require non-empty input (so T_1 is true)
(assert T_1)

; Extract header section before first blank line (CRLFCRLF)
(assert (= headers (split_at var_0xINPUT_10301 "\r\n\r\n" 0)))
(assert (>= (num_splits var_0xINPUT_10301 "\r\n\r\n") 1))

; Ensure there are multiple header lines
(assert (>= (num_splits headers "\r\n") 3))

; Host and Content-Length lines appear as specific header lines (modeling assumption)
(assert (= host_line (split_at headers "\r\n" 1)))
(assert (= cl_line (split_at headers "\r\n" 2)))

; Both lines must contain a colon delimiter for key-value parsing
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; Keys are fixed for this scenario
(assert (= (split_at host_line ":" 0) "Host"))
(assert (= (split_at cl_line ":" 0) "Content-Length"))

; Values after the first ':' (may include leading spaces)
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_value (split_rest cl_line ":" 1)))

; Host value must be non-empty after trimming assumption: disallow empty or just a single space
(assert (not (= host_value "")))
(assert (not (= host_value " ")))

; Content-Length value constraints: at least one digit and no CR/LF embedded
(assert (not (= cl_value "")))
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))

; Numeric interpretation of content length
(assert (>= content_length 0))
; Bind a concrete parsed value for this instance
(assert (= content_length 42))

; Create both SAT and UNSAT instances via T_2: force an impossible relationship with content length
(assert (= T_2 (and (= cl_value "0") (= content_length 42))))
(assert T_2)



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
