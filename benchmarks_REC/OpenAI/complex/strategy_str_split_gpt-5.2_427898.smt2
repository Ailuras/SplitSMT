(set-logic ALL)

; Uninterpreted interface operations for str_split
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

; Seed-style boolean guards
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun T_5 () Bool)
(declare-fun T_6 () Bool)
(declare-fun T_7 () Bool)

; Input: HTTP header block (request-line + headers)
(declare-fun var_0xINPUT_130232 () String)

; Parsed components
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const method String)
(declare-const path String)
(declare-const version String)

; Numeric content-length (modeled via length of the cl_value string)
(declare-const content_length Int)

; --- Preserve core structure: non-empty input, exclude specific bad constants ---
(assert (= T_1 (not (= "" var_0xINPUT_130232))))
(assert T_1)
(assert (= T_2 (not (= "" var_0xINPUT_130232))))
(assert T_2)

; Mutate T_3 meaning: forbid a specific degenerate header prefix
(assert (= T_3 (str.prefixof "Example:" var_0xINPUT_130232)))
(assert (= T_4 (not T_3)))
(assert T_4)

(assert (= T_5 (not (= var_0xINPUT_130232 "AA1ND6MEXd"))))
(assert T_5)

; --- HTTP header parsing structure using split operations ---
; Require at least request-line + one header line when splitting by newline
(assert (>= (num_splits var_0xINPUT_130232 "\n") 2))
(assert (>= (num_splits var_0xINPUT_130232 "\n") 3))

(assert (= request_line (split_at var_0xINPUT_130232 "\n" 0)))
(assert (= headers_block (split_rest var_0xINPUT_130232 "\n" 1)))

; Parse request-line: "METHOD PATH VERSION"
(assert (>= (num_splits request_line " ") 3))
(assert (= method (split_at request_line " " 0)))
(assert (= path   (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))

; Basic sanity
(assert (not (= method "")))
(assert (not (= path "")))
(assert (not (= version "")))
(assert (or (= method "GET") (= method "POST")))
(assert (str.prefixof "HTTP/" version))

; Identify two specific header lines from headers_block
(assert (= host_line (split_at headers_block "\n" 0)))
(assert (= cl_line   (split_at headers_block "\n" 1)))

; Key-value parsing using ':' delimiter
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits cl_line ":") 2))

(assert (= host_key   (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (= cl_key     (split_at cl_line ":" 0)))
(assert (= cl_value   (split_rest cl_line ":" 1)))

; Normalize expected keys (case-sensitive for simplicity)
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Values must be non-empty and not contain newlines
(assert (not (= host_value "")))
(assert (not (str.contains host_value "\n")))
(assert (not (= cl_value "")))
(assert (not (str.contains cl_value "\n")))

; Content-Length validation (relaxed): value should be digits-only, modeled by forbidding obvious non-digits
(assert (= T_6 (not (str.contains cl_value "-"))))
(assert T_6)
(assert (= T_7 (not (str.contains cl_value "."))))
(assert T_7)

; Content-length numeric proxy: require length between 1 and 10
(assert (= content_length (str.len cl_value)))
(assert (>= content_length 1))
(assert (<= content_length 10))

; Additional constraints to keep instance satisfiable and realistic
(assert (str.prefixof "/" path))
(assert (str.contains host_value "."))
(assert (not (str.contains host_value " ")))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
