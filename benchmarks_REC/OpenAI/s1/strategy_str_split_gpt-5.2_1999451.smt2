(set-logic ALL)

; Uninterpreted interface for string split constraints
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

; HTTP Header Parsing scenario variables
(declare-const req String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const host_name String)
(declare-const cl_line String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)
(declare-const X String)

; Preserve core structure from seed: keep the same regex-negated assertion but apply it to a header value placeholder X
(assert (not (str.in_re X
  (re.++
    (re.opt
      (re.++
        (re.opt
          (re.++
            (str.to_re "+")
            ((_ re.loop 1 1) (re.range "1" "9"))
            ((_ re.loop 0 3) (re.range "0" "9"))
          )
        )
        (re.opt
          (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
        )
        (str.to_re "(")
        ((_ re.loop 1 1) (re.range "1" "9"))
        ((_ re.loop 0 3) (re.range "0" "9"))
        (str.to_re ")")
      )
    )
    (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
    ((_ re.loop 1 9) (re.range "0" "9"))
    (str.to_re "\u{a}")
  )
)))

; Basic request structure: request-line, headers, blank line, body
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= headers (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))

; Header block: request-line then header lines
(assert (>= (num_splits headers "\r\n") 2))
(assert (= request_line (split_at headers "\r\n" 0)))

; Constrain request line to begin with method token and space (simple structural check)
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line " "))

; Find specific header lines by position (a common simplified parsing model)
(assert (= host_line (split_at headers "\r\n" 1)))
(assert (= cl_line (split_at headers "\r\n" 2)))

; Each of these must contain a colon separating key/value
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))

; Parse Host: value after first ':'
(assert (>= (num_splits host_line ":") 2))
(assert (= host_name (split_at host_line ":" 1)))

; Parse Content-Length: value after first ':'
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_value (split_at cl_line ":" 1)))

; Relate X to the parsed content-length value to preserve seed structure around X
(assert (= X cl_value))

; Content-Length value should be digits possibly preceded by a single space
; Also ensure it does not contain CR/LF
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))
(assert (str.in_re cl_value (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; Numeric interpretation constraints (modeling validated content-length)
(assert (>= cl_int 0))
(assert (<= cl_int 1000))
(assert (= (str.len body) cl_int))

; Additional header well-formedness: Host header key must mention Host
(assert (str.contains host_line "Host"))

; Create an UNSAT corner: content-length must match body length but also contradict via fixed body length
(assert (= (str.len body) 5))
(assert (= cl_int 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
