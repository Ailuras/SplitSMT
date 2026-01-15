(set-logic ALL)

; Uninterpreted interface for string split methodology
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

; HTTP header parsing scenario
(declare-const req String)
(declare-const start_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const ua_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const ua_value String)
(declare-const cl_value String)
(declare-const body String)
(declare-const cl_int Int)
(declare-const X String)

; Preserve seed core structure: constrain X against a specific literal regex
(assert (not (str.in_re X (str.to_re "comUser-Agent:si=PORT=/pagead/ads?Host:/desktop/\u{a}"))))

; Request must contain header/body delimiter CRLFCRLF
(assert (>= (num_splits req "\r\n\r\n") 2))
(assert (= headers_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_rest req "\r\n\r\n" 1)))

; Split header block by CRLF: first line is start line
(assert (>= (num_splits headers_block "\r\n") 3))
(assert (= start_line (split_at headers_block "\r\n" 0)))
(assert (str.in_re start_line (str.to_re "GET /index.html HTTP/1.1")))

; Identify specific header lines by position (simplified parsing)
(assert (= host_line (split_at headers_block "\r\n" 1)))
(assert (= ua_line (split_at headers_block "\r\n" 2)))
(assert (= cl_line (split_at headers_block "\r\n" 3)))

; Each header line contains a colon and a space after it
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits ua_line ": ") 2))
(assert (>= (num_splits cl_line ": ") 2))

; Keys must match expected header names
(assert (= (split_at host_line ": " 0) "Host"))
(assert (= (split_at ua_line ": " 0) "User-Agent"))
(assert (= (split_at cl_line ": " 0) "Content-Length"))

; Extract values
(assert (= host_value (split_rest host_line ": " 1)))
(assert (= ua_value (split_rest ua_line ": " 1)))
(assert (= cl_value (split_rest cl_line ": " 1)))

; Basic validation: host contains a dot, UA non-empty, Content-Length digits only
(assert (str.contains host_value "."))
(assert (> (str.len ua_value) 0))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Link Content-Length string to integer and validate against body length
(assert (>= cl_int 0))
(assert (= cl_int (str.to_int cl_value)))
(assert (= (str.len body) cl_int))

; Additional diversity constraints (still satisfiable)
(assert (not (str.contains ua_value "\\r")))
(assert (not (str.contains ua_value "\\n")))
(assert (not (str.contains host_value " ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
