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

; Uninterpreted interface for str_split

; Seed variables (kept) and extended variables for HTTP header parsing
(declare-const x1 String)
(declare-const x2 String)
(declare-const z1 String)
(declare-const z2 String)
(declare-const z3 String)
(declare-const t1 String)
(declare-const t2 String)

(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const header_host_line String)
(declare-const header_cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_len Int)

; Mutated core structure from the seed: still a big concatenation equality, but adapted to header-like tokens
(assert
  (= (str.++ (str.++ (str.++ (str.++ x1 "Host" ) x2)
                      (str.++ (str.++ z1 t1) z2))
               (str.++ "\r\n" z3))
     (str.++ (str.++ (str.++ (str.++ x2 "Content-Length") x1)
                      (str.++ (str.++ z2 t2) z1))
               (str.++ z3 "\r\n"))))

; Basic request shape: request line then headers then blank line
(assert (= req (str.++ request_line (str.++ "\r\n" (str.++ headers_block "\r\n\r\n")))))

; Ensure at least two header lines exist (split by CRLF)
(assert (>= (num_splits headers_block "\r\n") 2))
(assert (>= (num_splits headers_block "\r\n") 3))

; Pin two specific header lines to positions 0 and 1
(assert (= header_host_line (split_at headers_block "\r\n" 0)))
(assert (= header_cl_line   (split_at headers_block "\r\n" 1)))

; Each header line must contain a colon delimiter into at least two segments
(assert (>= (num_splits header_host_line ":") 2))
(assert (>= (num_splits header_cl_line ":") 2))

; Keys and values extracted via split_at ("Key: Value" simplified as "Key:Value" or with leading spaces in value)
(assert (= "Host" (split_at header_host_line ":" 0)))
(assert (= host_value (split_rest header_host_line ":" 1)))

(assert (= "Content-Length" (split_at header_cl_line ":" 0)))
(assert (= cl_value (split_rest header_cl_line ":" 1)))

; Ensure values are non-empty
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))

; Content-Length must be digits only and consistent with an integer variable (lightweight via a few cases)
(assert (str.in_re cl_value (re.++ (str.to_re "") (re.+ (re.range "0" "9")))))

; Tie cl_len to a small set of allowed lengths to keep constraints decidable and meaningful
(assert (or (= cl_len 0) (= cl_len 1) (= cl_len 2) (= cl_len 3) (= cl_len 4) (= cl_len 5) (= cl_len 10) (= cl_len 12)))

; Map cl_value strings to cl_len for those cases (partial mapping)
(assert
  (or (and (= cl_len 0) (= cl_value "0"))
      (and (= cl_len 1) (= cl_value "1"))
      (and (= cl_len 2) (= cl_value "2"))
      (and (= cl_len 3) (= cl_value "3"))
      (and (= cl_len 4) (= cl_value "4"))
      (and (= cl_len 5) (= cl_value "5"))
      (and (= cl_len 10) (= cl_value "10"))
      (and (= cl_len 12) (= cl_value "12"))))

; Ensure headers_block actually contains the constructed key/value lines (order enforced by earlier split_at constraints)
(assert (= header_host_line (str.++ "Host:" host_value)))
(assert (= header_cl_line   (str.++ "Content-Length:" cl_value)))

; Connect seed variables into the request so they influence parsing
(assert (str.contains request_line x1))
(assert (str.contains request_line x2))
(assert (str.contains headers_block z1))
(assert (str.contains headers_block z2))
(assert (str.contains headers_block z3))

; Add a sanity constraint about request_line shape
(assert (str.contains request_line "HTTP/1.1"))
(assert (str.contains request_line "GET"))

; Make sure the host_value does not contain CRLF (single-line value)
(assert (not (str.contains host_value "\r\n")))

; SAT/UNSAT mix: force a contradiction on Content-Length mapping for UNSAT instance
; cl_value is a digit string, but we force an impossible combination
(assert (= cl_value "12"))
(assert (= cl_len 10))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
