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

; HTTP Header Parsing via str_split: request line + header lines + blank line + body

(declare-const req String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const headers_and_body String)
(declare-const headers_block String)
(declare-const body String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const content_length Int)
(declare-const sat_case Bool)

; non-primitive interface ops

; helper to parse int from string (uninterpreted, constrained by regex)
(declare-fun str_to_int (String) Int)

; Structural constraints
(assert (>= (str.len req) 20))
(assert (str.contains req "\r\n"))

; Split request into request-line and the rest
(assert (= (split_at req "\r\n" 0) (str.++ method " " path " " version)))
(assert (= headers_and_body (split_rest req "\r\n" 1)))
(assert (>= (num_splits req "\r\n") 4))

; Request-line basics
(assert (or (= method "GET") (= method "POST")))
(assert (str.in_re path (re.++ (str.to_re "/") (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/"))))))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Find header/body boundary using CRLFCRLF
(assert (str.contains headers_and_body "\r\n\r\n"))
(assert (= headers_block (split_at headers_and_body "\r\n\r\n" 0)))
(assert (= body (split_rest headers_and_body "\r\n\r\n" 1)))
(assert (>= (num_splits headers_and_body "\r\n\r\n") 2))

; At least 3 header lines
(assert (>= (num_splits headers_block "\r\n") 3))

; Extract specific header lines by position (order simplified)
(assert (= host_line (split_at headers_block "\r\n" 0)))
(assert (= cl_line   (split_at headers_block "\r\n" 1)))
(assert (= ua_line   (split_at headers_block "\r\n" 2)))

; Each header line must contain a colon
(assert (str.contains host_line ":"))
(assert (str.contains cl_line ":"))
(assert (str.contains ua_line ":"))

; Parse key/value around ':' and an optional leading space in value
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))

; Normalize common pattern: ": " (value starts with a space)
(assert (or (= host_value (str.++ " " (split_rest host_line ": " 1))) (= host_value (split_rest host_line ":" 1))))
(assert (or (= cl_value   (str.++ " " (split_rest cl_line   ": " 1))) (= cl_value   (split_rest cl_line   ":" 1))))
(assert (or (= ua_value   (str.++ " " (split_rest ua_line   ": " 1))) (= ua_value   (split_rest ua_line   ":" 1))))

; Header keys expected (case-sensitive simplification)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Host value must include at least one dot, and be reasonably sized
(assert (>= (str.len host_value) 2))
(assert (<= (str.len host_value) 80))
(assert (str.contains host_value "."))

; Content-Length value is digits possibly prefixed by a single space
(assert (str.in_re cl_value (re.++ (re.opt (str.to_re " ")) (re.+ (re.range "0" "9")))))

; UA non-empty, no CR/LF inside
(assert (> (str.len ua_value) 1))
(assert (not (str.contains ua_value "\r")))
(assert (not (str.contains ua_value "\n")))

; Map cl_value to integer and validate bounds
(assert (= content_length (str_to_int cl_value)))
(assert (>= content_length 0))
(assert (<= content_length 4096))

; SAT/UNSAT fork: enforce exact length when sat_case, contradict when not sat_case
(assert (or sat_case (not sat_case)))
(assert (ite sat_case
            (= (str.len body) content_length)
            (and (= (str.len body) content_length)
                 (not (= (str.len body) content_length)))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
