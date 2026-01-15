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

; Uninterpreted interface functions for string split

; Core HTTP request/header inputs
(declare-const raw_request String)
(declare-const header_block String)
(declare-const request_line String)
(declare-const headers_only String)
(declare-const method String)
(declare-const uri String)
(declare-const version String)

; Specific header lines
(declare-const host_line String)
(declare-const cl_line String)
(declare-const ct_line String)
(declare-const ua_line String)

; Header keys/values
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ct_key String)
(declare-const ct_value String)
(declare-const ua_key String)
(declare-const ua_value String)

; Body and content-length numeric value
(declare-const body String)
(declare-const content_length Int)

; Auxiliary integers for indices and counts
(declare-const n_lines Int)
(declare-const idx_host Int)
(declare-const idx_cl Int)
(declare-const idx_ct Int)
(declare-const idx_ua Int)

; === High-level HTTP message structure ===
; header_block = request_line + "\r\n" + headers_only
(assert (= header_block (split_at raw_request "\r\n\r\n" 0)))
(assert (= body (split_at raw_request "\r\n\r\n" 1)))
(assert (>= (num_splits raw_request "\r\n\r\n") 2))

(assert (= request_line (split_at header_block "\r\n" 0)))
(assert (= headers_only (split_rest header_block "\r\n" 1)))

; request_line = "METHOD URI VERSION" with spaces
(assert (= method (split_at request_line " " 0)))
(assert (= uri (split_at request_line " " 1)))
(assert (= version (split_at request_line " " 2)))
(assert (>= (num_splits request_line " ") 3))
(assert (or (= version "HTTP/1.1") (= version "HTTP/1.0")))

; Some basic sanity properties
(assert (> (str.len method) 0))
(assert (> (str.len uri) 0))
(assert (str.prefixof "/" uri))

; === Header lines are split by CRLF ===
(assert (= n_lines (num_splits header_block "\r\n")))
(assert (>= n_lines 2))

; Choose positions for a few relevant header lines (within bounds)
(assert (>= idx_host 1))
(assert (>= idx_cl 1))
(assert (>= idx_ct 1))
(assert (>= idx_ua 1))
(assert (< idx_host n_lines))
(assert (< idx_cl n_lines))
(assert (< idx_ct n_lines))
(assert (< idx_ua n_lines))

; Bind concrete lines by index
(assert (= host_line (split_at header_block "\r\n" idx_host)))
(assert (= cl_line   (split_at header_block "\r\n" idx_cl)))
(assert (= ct_line   (split_at header_block "\r\n" idx_ct)))
(assert (= ua_line   (split_at header_block "\r\n" idx_ua)))

; Require they are distinct indices so lines can differ
(assert (distinct idx_host idx_cl idx_ct idx_ua))

; === Parse each header line as "Key: Value" using split ':' ===
; Host
(assert (= host_key (split_at host_line ":" 0)))
(assert (= host_value (split_rest host_line ":" 1)))
(assert (>= (num_splits host_line ":") 2))

; Content-Length
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= cl_value (split_rest cl_line ":" 1)))
(assert (>= (num_splits cl_line ":") 2))

; Content-Type
(assert (= ct_key (split_at ct_line ":" 0)))
(assert (= ct_value (split_rest ct_line ":" 1)))
(assert (>= (num_splits ct_line ":") 2))

; User-Agent
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= ua_value (split_rest ua_line ":" 1)))
(assert (>= (num_splits ua_line ":") 2))

; === Header name validation (case-sensitive for simplicity) ===
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))
(assert (= ct_key "Content-Type"))
(assert (= ua_key "User-Agent"))

; Values should be non-empty (after ':')
(assert (> (str.len host_value) 0))
(assert (> (str.len cl_value) 0))
(assert (> (str.len ct_value) 0))
(assert (> (str.len ua_value) 0))

; Content-Type must mention json or text as a simple validation
(assert (or (str.contains ct_value "json") (str.contains ct_value "text")))

; === Content-Length validation against body length ===
(assert (>= content_length 0))
(assert (= content_length (str.to_int cl_value)))

; SAT branch: well-formed numeric content-length equals body length
(declare-const sat_ok Bool)
(assert sat_ok)
(assert (= content_length (str.len body)))

; Additional consistency constraints
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))
(assert (not (str.contains cl_value "\r")))
(assert (not (str.contains cl_value "\n")))

; === UNSAT branch: contradictory constraint (kept separate by a guard) ===
(declare-const unsat_mode Bool)
; Force unsat_mode to false to keep overall instance SAT, but still include an UNSAT sub-instance pattern.
(assert (not unsat_mode))
; If unsat_mode were true, we'd require an impossible length mismatch.
(assert (=> unsat_mode (and (= content_length (str.len body)) (not (= content_length (str.len body))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
