(set-logic ALL)

; --- Uninterpreted interface for HTTP header parsing (split-based) ---
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

; --- Core variables (preserve seed structure) ---
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

; --- Scenario-specific variables ---
(declare-const request String)
(declare-const request_line String)
(declare-const headers_blob String)
(declare-const body String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_int Int)

; --- Seed-derived core regex constraint on attack (mutated for header setting) ---
(assert (str.in_re attack (re.++ prefix ((_ re.loop 32 32) infix) postfix)))

(assert (= prefix
  (re.++
    (re.union
      ; "Host" or "Content-Length" header keys (two alternatives)
      (re.++ (str.to_re "Host") (str.to_re ": "))
      (re.++ (str.to_re "Content-Length") (str.to_re ": ")))
    ; a small digit-run then CRLF, then another header-like prefix marker
    (re.++ (re.+ (re.range "0" "9")) (str.to_re "\r\n")))))

(assert (= infix
  ; digits, optional dot, optional a|b, then digits (seed-like), but allow LF too
  (re.inter
    (re.++ (re.+ (re.range "0" "9")) (re.+ (re.range "0" "9")))
    (re.++
      (re.+ (re.range "0" "9"))
      (re.++
        (re.++ (re.opt (str.to_re ".")) (re.opt (re.union (str.to_re "a") (str.to_re "b"))))
        (re.+ (re.range "0" "9")))))))

(assert (= postfix
  ; require end marker that resembles end of headers
  (re.++ (str.to_re "\r\n\r\n") (re.* (re.union (str.to_re "A") (str.to_re "a"))))))

(assert (str.in_re postfixs postfix))
(assert (>= (str.len postfixs) 4))

; result is still attack ++ postfixs, but now result is embedded into request
(assert (= result (str.++ attack postfixs)))

; --- HTTP header parsing constraints using split operations ---
; request = request_line + CRLF + headers + CRLFCRLF + body
(assert (= request (str.++ request_line (str.++ "\r\n" (str.++ headers_blob (str.++ "\r\n\r\n" body))))))

; place the seed-generated result somewhere inside the headers
(assert (str.contains headers_blob result))

; split headers into lines
(assert (>= (num_splits headers_blob "\r\n") 3))
(assert (= host_line (split_at headers_blob "\r\n" 0)))
(assert (= cl_line (split_at headers_blob "\r\n" 1)))

; require key-value format with colon delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

; extract values (trim handled by requiring a leading space)
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (str.prefixof " " host_value))
(assert (str.prefixof " " cl_value))

; host must be non-empty and not contain CR/LF
(assert (>= (str.len host_value) 2))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; content-length value must be digits after the leading space
(assert (str.in_re cl_value (re.++ (str.to_re " ") (re.+ (re.range "0" "9")))))

; connect to integer content-length and validate against body length
(assert (= cl_int (str.to_int (str.substr cl_value 1 (- (str.len cl_value) 1)))))
(assert (>= cl_int 0))
(assert (= cl_int (str.len body)))

; request line must look like a minimal HTTP request
(assert (str.in_re request_line (re.++ (str.to_re "GET ") (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (str.to_re "/"))))) (str.to_re " HTTP/1.1")))))

; --- Add one UNSAT branch guarded by contradiction on purpose ---
; If cl_int is 0 then body length must be > 0 (contradiction when cl_int=0)
(assert (=> (= cl_int 0) (> (str.len body) 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
