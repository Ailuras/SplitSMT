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

; --- Uninterpreted interface: str_split ---

; --- Core variables for HTTP header parsing ---
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const method String)
(declare-const uri String)
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

(declare-const content_length Int)
(declare-const body String)

; --- Extra variables to create both SAT and UNSAT sub-instances ---
(declare-const request_sat String)
(declare-const headers_sat String)
(declare-const body_sat String)
(declare-const cl_value_sat String)
(declare-const content_length_sat Int)

(declare-const request_unsat String)
(declare-const headers_unsat String)
(declare-const body_unsat String)
(declare-const cl_value_unsat String)
(declare-const content_length_unsat Int)

; --- Helper constraints: basic structural well-formedness ---
; request = request_line + "\n" + headers + "\n\n" + body
(assert (= request (str.++ request_line "\n" headers "\n\n" body)))

; request line fields split by spaces: "METHOD URI VERSION"
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

; constrain plausible HTTP version
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; method restricted to common verbs
(assert (or (= method "GET") (= method "POST") (= method "PUT") (= method "HEAD")))

; headers split by newline should have at least 3 lines (host, content-length, user-agent)
(assert (>= (num_splits headers "\n") 3))
(assert (= host_line (split_at headers "\n" 0)))
(assert (= cl_line (split_at headers "\n" 1)))
(assert (= ua_line (split_at headers "\n" 2)))

; each header line is "Key: Value" (split by ":")
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))

(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))

(assert (>= (num_splits ua_line ":") 2))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))

; exact keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))

; tolerate optional leading space after ':' by allowing either " X" or "X" forms
(assert (or (= host_value (str.++ " " (str.replace host_value " " ""))) (= host_value (str.replace host_value " " ""))))
(assert (or (= ua_value (str.++ " " (str.replace ua_value " " ""))) (= ua_value (str.replace ua_value " " ""))))

; content-length value should be digits possibly preceded by a single space; we model trimmed digits via replace
(assert (= cl_value (str.++ " " cl_value_sat)) )

; NOTE: We keep numeric parsing abstract: content_length relates to cl_value through constraints in SAT/UNSAT instances.

; --- Global content-length constraints ---
(assert (>= content_length 0))
(assert (= content_length (str.len body)))

; =====================
; SAT instance: a consistent request with correct content-length
; =====================
(assert (= request_sat (str.++ "POST /submit HTTP/1.1\n" headers_sat "\n\n" body_sat)))
(assert (= headers_sat (str.++ "Host: example.com\n" "Content-Length: " cl_value_sat "\n" "User-Agent: test-agent")))
(assert (= body_sat "hello"))
(assert (= content_length_sat (str.len body_sat)))
(assert (= content_length_sat 5))
(assert (= cl_value_sat "5"))

; tie SAT instance into the general variables by allowing request to be request_sat
(assert (= request request_sat))
(assert (= headers headers_sat))
(assert (= body body_sat))
(assert (= content_length content_length_sat))

; ensure cl_line and cl_value match the constructed SAT headers
(assert (= cl_line "Content-Length: 5"))
(assert (= cl_value (str.++ " " cl_value_sat)))

; =====================
; UNSAT instance (separate variables): contradictory content-length
; This does NOT constrain the main request; it's a parallel unsat core for diversity.
; =====================
(assert (= request_unsat (str.++ "POST /x HTTP/1.1\n" headers_unsat "\n\n" body_unsat)))
(assert (= headers_unsat (str.++ "Host: a\n" "Content-Length: " cl_value_unsat "\n" "User-Agent: ua")))
(assert (= body_unsat "abcd"))
(assert (= content_length_unsat (str.len body_unsat)))
(assert (= cl_value_unsat "10"))
; contradictory: length("abcd")=4 but claimed numeric length is 10
(assert (= content_length_unsat 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
