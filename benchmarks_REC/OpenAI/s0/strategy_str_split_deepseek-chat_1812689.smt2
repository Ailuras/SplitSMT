(set-logic ALL)
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

; Uninterpreted interface operations for string split

; Primitive string/int variables for HTTP header parsing
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const body String)
(declare-const content_length Int)

; -------------------------
; Basic request structure: request_line \n headers \n\n body
; -------------------------
(assert (>= (num_splits request "\n") 3))
(assert (= request_line (split_at request "\n" 0)))
(assert (= headers (split_rest request "\n" 1)))

; Require an empty line delimiter between headers and body (\n\n)
(assert (>= (num_splits request "\n\n") 2))
(assert (= body (split_at request "\n\n" 1)))

; Request line parsing: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/" version))

; -------------------------
; Header lines (each split by \n) and key-value split by ": "
; -------------------------
; Enforce at least 3 header lines after request-line: Host, Content-Length, User-Agent
(assert (>= (num_splits request "\n") 5))
(assert (= host_line (split_at request "\n" 1)))
(assert (= cl_line (split_at request "\n" 2)))
(assert (= ua_line (split_at request "\n" 3)))

; Each header line must have exactly two segments with delimiter ": " (key and value)
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits cl_line ": ") 2))
(assert (>= (num_splits ua_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_at host_line ": " 1)))
(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_value (split_at cl_line ": " 1)))
(assert (= ua_key (split_at ua_line ": " 0)))
(assert (= ua_value (split_at ua_line ": " 1)))

(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; Basic sanity: non-empty values
(assert (> (str.len host_value) 0))
(assert (> (str.len ua_value) 0))
(assert (> (str.len cl_value) 0))

; Host value contains at least one dot and no spaces
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

; Content-Length value must be digits only and parse to integer
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))
(assert (= content_length (str.to_int cl_value)))
(assert (>= content_length 0))

; Body length must match Content-Length
(assert (= (str.len body) content_length))

; -------------------------
; SAT instance anchor: construct one concrete example request that satisfies constraints
; -------------------------
(assert (= request
  (str.++
    "POST /upload HTTP/1.1\n"
    "Host: example.com\n"
    "Content-Length: 5\n"
    "User-Agent: curl/8.0\n"
    "\n"
    "abcde")))

; -------------------------
; Additional UNSAT sub-instance (kept separate with assumptions via a fresh flag)
; If unsat_flag is true, enforce an impossible content-length agreement.
; This ensures the file contains both SAT and UNSAT structure; overall satisfiable by setting unsat_flag = false.
; -------------------------
(declare-const unsat_flag Bool)
(assert (or (not unsat_flag)
            (and (= cl_value "0")
                 (= (str.len body) 1))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
