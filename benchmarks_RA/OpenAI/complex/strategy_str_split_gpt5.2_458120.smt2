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

; Uninterpreted interface for string split

; HTTP header parsing variables
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_int Int)
(declare-const body String)
(declare-const body_len Int)

; Keep core structure: let-bound regex star and nested concatenations with in_re comparisons
(assert
  (let ((_let_0 (re.* re.allchar)))
    (let ((_let_1 (str.++ "B" (str.++ "B" "B"))))
      (and
        ; Request must contain at least one ':' and at least one newline to resemble headers
        (str.contains req ":")
        (str.contains req "\n")

        ; Parse request line and header block by newline
        (>= (num_splits req "\n") 3)
        (= request_line (split_at req "\n" 0))
        (= headers_block (split_rest req "\n" 1))

        ; Extract specific header lines by newline splitting
        (= host_line (split_at headers_block "\n" 0))
        (= content_length_line (split_at headers_block "\n" 1))

        ; Each header line must be key:value form
        (>= (num_splits host_line ":") 2)
        (>= (num_splits content_length_line ":") 2)

        ; Extract keys and values
        (= host_key (split_at host_line ":" 0))
        (= host_value (split_rest host_line ":" 1))
        (= cl_key (split_at content_length_line ":" 0))
        (= cl_value (split_rest content_length_line ":" 1))

        ; Validate header keys
        (= host_key "Host")
        (= cl_key "Content-Length")

        ; Host value non-empty and must not contain newline
        (> (str.len host_value) 0)
        (not (str.contains host_value "\n"))

        ; Content-Length value must be digits only and non-empty
        (> (str.len cl_value) 0)
        (str.in_re cl_value (re.+ (re.range "0" "9")))

        ; Body is everything after two header lines (and their trailing newlines), simplified via split
        (= body (split_rest headers_block "\n" 2))
        (= body_len (str.len body))

        ; Content length integer bounds and relation (approximate validation)
        (>= cl_int 0)
        (<= cl_int 2048)

        ; SAT core: require either exact match or body longer than declared length
        (or (= body_len cl_int) (> body_len cl_int))

        ; Core seed-style constraints: compare in_re booleans with complex regexes
        (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re "B") _let_0 (str.to_re (str.++ "A" (str.++ "C" "B"))) _let_0))
                (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (str.to_re (str.++ "C" (str.++ "C" (str.++ "B" "C"))) ) _let_0))))
        (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (re.++ (str.to_re _let_1) re.allchar) _let_0))
                (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (str.to_re (str.++ "B" _let_1)) _let_0))))

        ; Additional header sanity: forbid CR and require request line starts with a method token
        (not (str.contains req "\r"))
        (or (str.prefixof "GET " request_line)
            (str.prefixof "POST " request_line)
            (str.prefixof "HEAD " request_line))

        ; UNSAT branch gated by impossible conjunction is avoided; keep overall SAT
        (not (and (= host_value "") (= host_value (str.++ "x" host_value))))
      ))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
