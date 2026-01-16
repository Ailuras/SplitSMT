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

; Uninterpreted interface for split operations

; Header parsing scenario variables
(declare-const raw_headers String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const content_length Int)

; Preserve core structure: boolean guards about a key input string
(declare-fun T_1 () Bool)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun T_4 () Bool)
(declare-fun var_0xINPUT_143519 () String)
(assert (= T_1 (= "-" var_0xINPUT_143519)))
(assert (= T_2 (not T_1)))
(assert T_2)
(assert (= T_3 (= "" var_0xINPUT_143519)))
(assert (= T_4 (not T_3)))
(assert T_4)

; Basic shape: at least two header lines separated by CRLF
(assert (>= (num_splits raw_headers "\r\n") 2))
(assert (= host_line (split_at raw_headers "\r\n" 0)))
(assert (= content_length_line (split_at raw_headers "\r\n" 1)))

; Each line is a key-value pair separated by ": "
(assert (>= (num_splits host_line ": ") 2))
(assert (>= (num_splits content_length_line ": ") 2))
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_value (split_rest host_line ": " 1)))
(assert (= cl_key (split_at content_length_line ": " 0)))
(assert (= cl_value (split_rest content_length_line ": " 1)))

; Require exact keys
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value must be non-empty and contain no CR or LF
(assert (> (str.len host_value) 0))
(assert (not (str.contains host_value "\r")))
(assert (not (str.contains host_value "\n")))

; Content-Length value must be non-empty and contain only digits
(assert (> (str.len cl_value) 0))
(assert (forall ((i Int))
  (=> (and (<= 0 i) (< i (str.len cl_value)))
      (str.in_re (str.at cl_value i) (re.range "0" "9")))))

; Bind an integer content_length and validate it consistently (relational, not full parsing)
(assert (>= content_length 0))
(assert (<= content_length 1000000))

; Relate digit-count to magnitude (sound necessary conditions)
(assert (=> (= (str.len cl_value) 1) (<= content_length 9)))
(assert (=> (= (str.len cl_value) 2) (<= content_length 99)))
(assert (=> (= (str.len cl_value) 3) (<= content_length 999)))
(assert (=> (>= (str.len cl_value) 4) (>= content_length 1000)))

; Ensure the header block terminator is present (empty line after at least two lines)
(assert (>= (num_splits raw_headers "\r\n\r\n") 2))

; Tie the seed input to header content to keep mutation connected
(assert (str.contains raw_headers var_0xINPUT_143519))

; Additional consistency: Host line must begin with "Host" and include ": "
(assert (str.contains host_line ": "))
(assert (= (str.substr host_line 0 4) "Host"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
