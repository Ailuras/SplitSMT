(set-logic ALL)

; Uninterpreted interface functions for string splitting
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

; Primitive string/integer variables
(declare-const req String)
(declare-const header_block String)
(declare-const body String)
(declare-const cl_line String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const host_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const user_agent_line String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const content_length Int)

; === Overall HTTP request decomposition (satisfiable core) ===
; Split request into header block and body using CRLFCRLF
(assert (= header_block (split_at req "\r\n\r\n" 0)))
(assert (= body (split_at req "\r\n\r\n" 1)))
(assert (>= (num_splits req "\r\n\r\n") 2))

; Header block must contain at least a request-line and two header lines
(assert (>= (num_splits header_block "\r\n") 3))

; Parse the request line: METHOD SP PATH SP HTTP/VERSION
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "/" path))
(assert (str.prefixof "HTTP/" version))

; === Parse Host header line (index 1) ===
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key "Host"))
; host_val may start with a space; require it contains a dot or a colon (hostname or host:port)
(assert (or (str.contains host_val ".") (str.contains host_val ":")))

; === Parse Content-Length header line (index 2) ===
(assert (= cl_line (split_at header_block "\r\n" 2)))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key "Content-Length"))

; Validate content-length: allow optional leading space in value, only digits after trimming one optional leading space
(declare-const cl_val_trim String)
(assert (= cl_val_trim (ite (and (> (str.len cl_val) 0) (= (str.at cl_val 0) " ")) (str.substr cl_val 1 (- (str.len cl_val) 1)) cl_val)))
(assert (str.in_re cl_val_trim (re.+ (re.range "0" "9"))))
(assert (= content_length (str.to_int cl_val_trim)))
(assert (>= content_length 0))

; Body length must match Content-Length
(assert (= (str.len body) content_length))

; === Parse User-Agent header line (optional, index 3 if present) ===
; If a 4th line exists, constrain it to be User-Agent with a non-empty value
(assert (=> (>= (num_splits header_block "\r\n") 4)
            (and (= user_agent_line (split_at header_block "\r\n" 3))
                 (= ua_key (split_at user_agent_line ":" 0))
                 (= ua_val (split_rest user_agent_line ":" 1))
                 (>= (num_splits user_agent_line ":") 2)
                 (= ua_key "User-Agent")
                 (> (str.len ua_val) 0))))

; === Additional sanity constraints to avoid degenerate parses ===
(assert (> (str.len header_block) 0))
(assert (not (str.contains request_line "\r")))
(assert (not (str.contains request_line "\n")))

; === UNSAT slice (separate named block): inconsistent content-length ===
; This creates an intentional contradiction while keeping the rest realistic.
; Under this assertion, sat should become unsat.
(declare-const force_unsat Bool)
(assert (= force_unsat false))
(assert (=> force_unsat
            (and (= content_length (+ (str.len body) 1))
                 (= (str.len body) content_length))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
