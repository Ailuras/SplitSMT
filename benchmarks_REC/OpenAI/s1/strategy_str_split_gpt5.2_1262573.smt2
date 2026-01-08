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

; Uninterpreted interface operations for string splitting

; Seed variables (kept to preserve core structure)
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_10 () Bool)
(declare-fun T_11 () String)
(declare-fun T_12 () Bool)
(declare-fun T_13 () Bool)
(declare-fun T_14 () String)
(declare-fun T_15 () Bool)
(declare-fun T_16 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () String)
(declare-fun T_8 () Bool)
(declare-fun T_9 () String)
(declare-fun T_SELECT_1 () Bool)
(declare-fun T_a () Bool)
(declare-fun T_b () String)
(declare-fun T_c () Bool)
(declare-fun T_d () String)
(declare-fun T_e () Bool)
(declare-fun T_f () String)
(declare-fun var_0xINPUT_49847 () String)

; New variables for HTTP header parsing scenario
(declare-const request String)
(declare-const header_block String)
(declare-const body String)
(declare-const request_line String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)
(declare-const accept_line String)

(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const ua_key String)
(declare-const ua_val String)
(declare-const accept_key String)
(declare-const accept_val String)

(declare-const content_length Int)
(declare-const body_len Int)

; Digit regex for Content-Length parsing
(declare-const DIGIT_RE RegLan)
(assert (= DIGIT_RE (re.union (str.to_re "0") (re.union (str.to_re "1") (re.union (str.to_re "2") (re.union (str.to_re "3") (re.union (str.to_re "4") (re.union (str.to_re "5") (re.union (str.to_re "6") (re.union (str.to_re "7") (re.union (str.to_re "8") (str.to_re "9"))))))))))))

; =========================
; Mutated seed core structure (adjusted to avoid trivial UNSAT and to relate to HTTP parsing)
; =========================

; Instead of forcing empty input, tie var_0xINPUT_49847 to the full HTTP request
(assert (= var_0xINPUT_49847 request))

; Keep negation structure but make it consistent with non-empty request
(assert (= T_1 (= "-" var_0xINPUT_49847)))
(assert (= T_2 (not T_1)))
(assert T_2)

(assert (= T_3 (= "" var_0xINPUT_49847)))
(assert (not T_3))

; Keep the conditional skeleton; make it about a known substring ("Content-Length") being absent/present
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_5 0))
    (= var_0xINPUT_49847 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (= T1_5 (str.++ T2_5 T3_5))
    (= T2_5 (str.++ T4_5 T5_5))
    (= T5_5 "\r\n\r\n")
    (= I0_5 (str.len T4_5))
    ; T4_5 is everything before the header/body separator
    (str.contains T4_5 "Content-Length")
    (not (str.in_re T4_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "2") (str.to_re "1") (str.to_re "8") (str.to_re "0") (str.to_re "6") (str.to_re "9") (str.to_re "7") (str.to_re "7") (str.to_re "4") (str.to_re "."))))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= var_0xINPUT_49847 (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (not (str.contains T1_5 "Content-Length"))
    (not (str.in_re T1_5 (re.++ (str.to_re "_") (str.to_re "_") (str.to_re "u") (str.to_re "t") (str.to_re "m") (str.to_re "z") (str.to_re "=") (str.to_re "2") (str.to_re "1") (str.to_re "8") (str.to_re "0") (str.to_re "6") (str.to_re "9") (str.to_re "7") (str.to_re "7") (str.to_re "4") (str.to_re "."))))
  )
))

; Flip the comparison so this instance is satisfiable with PCTEMP_LHS_1 >= 0
(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert T_5)

; Keep some "-" sentinel equalities but connect them to actual header keys/values placeholders
(assert (= T_7 "-"))
(assert (= T_8 (= "-" T_7)))
(assert T_8)

(assert (= T_9 "-"))
(assert (= T_a (= "-" T_9)))
(assert T_a)

(assert (= T_b "-"))
(assert (= T_c (= "-" T_b)))
(assert T_c)

(assert (= T_d "-"))
(assert (= T_e (= "-" T_d)))
(assert T_e)

(assert (= T_f "-"))
(assert (= T_10 (= "-" T_f)))
(assert T_10)

; Ensure these are not "-" to model real extracted values
(assert (= T_12 (= "-" T_11)))
(assert (= T_13 (not T_12)))
(assert T_13)

(assert (= T_15 (= "-" T_14)))
(assert (= T_16 (not T_15)))
(assert T_16)

; =========================
; HTTP header parsing constraints using split_at/num_splits/split_rest
; =========================

; Request is header_block + CRLFCRLF + body
(assert (= request (str.++ header_block "\r\n\r\n" body)))

; Header block has at least a request line and one header line
(assert (>= (num_splits header_block "\r\n") 2))

; Parse request line
(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

(assert (or (= method "GET") (= method "POST")))
(assert (str.contains version "HTTP/1.1"))
(assert (str.prefixof "/" path))

; Extract a few header lines by index (structural assumption typical in tests)
(assert (= host_line (split_at header_block "\r\n" 1)))
(assert (= cl_line   (split_at header_block "\r\n" 2)))
(assert (= ua_line   (split_at header_block "\r\n" 3)))
(assert (= accept_line (split_at header_block "\r\n" 4)))

; Each header line should have a colon separating key and value
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))
(assert (>= (num_splits accept_line ":") 2))

; Parse key/value parts (value may contain additional colons, so use split_rest)
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_val (split_rest host_line ":" 1)))

(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_val (split_rest cl_line ":" 1)))

(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_val (split_rest ua_line ":" 1)))

(assert (= accept_key (split_at accept_line ":" 0)))
(assert (= accept_val (split_rest accept_line ":" 1)))

; Concrete expected keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ua_key "User-Agent"))
(assert (= accept_key "Accept"))

; Values should not be empty after trimming the initial space (simplified: require they contain a space prefix)
(assert (str.prefixof " " host_val))
(assert (str.prefixof " " cl_val))
(assert (str.prefixof " " ua_val))
(assert (str.prefixof " " accept_val))

; Bind T_11 and T_14 to actual extracted values to reuse seed non-"-" constraints
(assert (= T_11 host_val))
(assert (= T_14 ua_val))

; Content-Length validation: cl_val is " <digits>" and matches body length
(assert (str.in_re cl_val (re.++ (str.to_re " ") (re.+ DIGIT_RE))))

; Connect integer content_length to body length; we avoid parsing digits to int by relating to a dedicated Int constant
(assert (= body_len (str.len body)))
(assert (>= content_length 0))
(assert (= content_length body_len))

; Ensure body length is plausible for POST and zero for GET (typical behavior)
(assert (=> (= method "GET") (= body_len 0)))
(assert (=> (= method "POST") (>= body_len 0)))

; Also ensure there are enough CRLF-separated lines to access indices used
(assert (>= (num_splits header_block "\r\n") 5))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
