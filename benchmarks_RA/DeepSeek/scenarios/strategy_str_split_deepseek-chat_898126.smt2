; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validating content-length and handling key-value pairs
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

; Declare string variables for headers and components
(declare-const header_block String)
(declare-const content_length_key String)
(declare-const content_length_value String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const user_agent_key String)
(declare-const user_agent_value String)
(declare-const parsed_content_length Int)

; Declare str_split interface functions

; Assert that header_block contains multiple lines separated by newline
(assert (>= (num_splits header_block "\n") 3))

; Extract first line as host header
(assert (= host_key (split_at (split_at header_block "\n" 0) ":" 0)))
(assert (= host_value (split_at (split_at header_block "\n" 0) ":" 1)))
(assert (>= (num_splits (split_at header_block "\n" 0) ":") 2))

; Extract second line as user-agent header
(assert (= user_agent_key (split_at (split_at header_block "\n" 1) ":" 0)))
(assert (= user_agent_value (split_at (split_at header_block "\n" 1) ":" 1)))
(assert (>= (num_splits (split_at header_block "\n" 1) ":") 2))

; Extract third line as content-length header
(assert (= content_length_key (split_at (split_at header_block "\n" 2) ":" 0)))
(assert (= content_length_value (split_at (split_at header_block "\n" 2) ":" 1)))
(assert (>= (num_splits (split_at header_block "\n" 2) ":") 2))

; Validate key names
(assert (= host_key "Host"))
(assert (= user_agent_key "User-Agent"))
(assert (= content_length_key "Content-Length"))

; Content-length value must be a non-negative integer
(assert (str.in_re content_length_value (re.+ (re.range "0" "9"))))
(assert (>= (str.len content_length_value) 1))

; Parse content-length value to integer
(assert (= parsed_content_length (str.to_int content_length_value)))
(assert (>= parsed_content_length 0))
(assert (<= parsed_content_length 10000))

; Additional constraints for realistic header values
(assert (str.contains host_value "."))
(assert (>= (str.len host_value) 5))
(assert (str.contains user_agent_value "Mozilla"))

; Ensure no extra colons in values (simple validation)
(assert (not (str.contains host_value ":")))
(assert (not (str.contains user_agent_value ":")))

; Check that header_block ends properly (optional)
(assert (str.suffixof "\n" (split_rest header_block "\n" 3)))

; Make it SAT by allowing reasonable values
(assert (>= (str.len header_block) 50))
(assert (<= (str.len header_block) 500))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
