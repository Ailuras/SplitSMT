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

; Uninterpreted split interface for header parsing

; Seed-style declarations preserved
(declare-fun I0_5 () Int)
(declare-fun PCTEMP_LHS_1 () Int)
(declare-fun T0_5 () String)
(declare-fun T1_5 () String)
(declare-fun T2_5 () String)
(declare-fun T3_5 () String)
(declare-fun T4_5 () String)
(declare-fun T5_5 () String)
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_SELECT_1 () Bool)
(declare-fun var_0xINPUT_35568 () String)

; New variables for HTTP header parsing scenario
(declare-const request String)
(declare-const headers String)
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)
(declare-const body String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Mutate seed: var_0xINPUT_35568 models the raw header block
(assert (= var_0xINPUT_35568 headers))

; Keep seed core structure but avoid direct contradiction: not "-" and not empty
(assert (= T_1 (= "-" var_0xINPUT_35568)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_35568)))
(assert (not T_3))

; Split request into lines by \r\n, basic shape: request-line, Host, Content-Length, blank line, body
(assert (>= (num_splits request "\r\n") 5))
(assert (= request_line (split_at request "\r\n" 0)))
(assert (= host_line (split_at request "\r\n" 1)))
(assert (= cl_line (split_at request "\r\n" 2)))
(assert (= "" (split_at request "\r\n" 3)))
(assert (= body (split_rest request "\r\n" 4)))
(assert (= headers (str.++ host_line (str.++ "\r\n" (str.++ cl_line "\r\n")))))

; Request line parsing: METHOD SP PATH SP HTTP/VERSION
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (= "POST" method))
(assert (str.prefixof "/" path))
(assert (str.prefixof "HTTP/" version))

; Header line parsing: key: value
(assert (>= (num_splits host_line ":") 2))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= "Host" host_key))
; Ensure leading space on value, and some content
(assert (str.prefixof " " host_value))
(assert (>= (str.len host_value) 2))

(assert (>= (num_splits cl_line ":") 2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (= "Content-Length" cl_key))
(assert (str.prefixof " " cl_value))

; Mutated seed-style concatenation constraints (repurposed for header assembly)
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_1 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_1 (+ I0_5 0))
    (= headers (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    (= I0_5 (str.len T4_5))
    (= T1_5 (str.++ T2_5 T3_5))
    (= T2_5 (str.++ T4_5 T5_5))
    ; Interpret T5_5 as the fixed header name for this scenario
    (= T5_5 "Content-Length")
    ; Forbid a suspicious token inside T4_5
    (not (str.in_re T4_5 (re.++ (str.to_re "\r") (str.to_re "\n"))))
  )
  (and
    (= PCTEMP_LHS_1 (- 1))
    (= headers (str.++ T0_5 T1_5))
    (= 0 (str.len T0_5))
    ; Also forbid injection in the remaining suffix
    (not (str.contains T1_5 "\r\n\r\n"))
  )
))

(assert (= T_5 (< (- 1) PCTEMP_LHS_1)))
(assert (= T_6 (not T_5)))
(assert T_6)

; Content-Length validation (lightweight due to lack of str.to_int):
; Constrain to a concrete well-formed value and relate it to body length.
(assert (= cl_value " 4"))
(assert (= content_length 4))
(assert (= (str.len body) content_length))

; Ensure body content is present and simple
(assert (= body "DATA"))

; Additional safety: Host value must not contain newlines or colon
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains host_value ":")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
