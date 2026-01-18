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

; Uninterpreted interface for string split operations

; HTTP Header Parsing scenario
(declare-const X String)
(declare-const header_line0 String)
(declare-const header_name0 String)
(declare-const header_value0 String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const content_length_value String)
(declare-const ua_line String)
(declare-const parsed_len Int)

; Core structure preserved: keep some seed regex constraints, but make them consistent with an HTTP-like header block
; Require at least 3 lines separated by LF
(assert (>= (num_splits X "\u{a}") 3))
(assert (= header_line0 (split_at X "\u{a}" 0)))
(assert (= host_line (split_at X "\u{a}" 0)))
(assert (= content_length_line (split_at X "\u{a}" 1)))
(assert (= ua_line (split_at X "\u{a}" 2)))

; Each header line is key:value form (split at colon)
(assert (>= (num_splits host_line ":") 2))
(assert (>= (num_splits content_length_line ":") 2))
(assert (>= (num_splits ua_line ":") 2))

(assert (= header_name0 (split_at host_line ":" 0)))
(assert (= header_value0 (split_rest host_line ":" 1)))

; Host header name fixed
(assert (= header_name0 "Host"))

; Host value: simple host token (no spaces), plus specific suffix to preserve seed flavor
(assert (str.in_re header_value0 (re.++ (re.* (str.to_re " ")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") )) (re.* (str.to_re " ")))))
(assert (str.contains header_value0 "A-311"))

; User-Agent line close to seed but made consistent with line splitting
(assert (= ua_line "User-Agent:etbuviaebe/eqv.bvv"))

; Content-Length parsing
(assert (= (split_at content_length_line ":" 0) "Content-Length"))
(assert (= content_length_value (split_rest content_length_line ":" 1)))

; Trim-like allowance: optional spaces then digits only
(assert (str.in_re content_length_value (re.++ (re.* (str.to_re " ")) (re.+ (re.range "0" "9")) (re.* (str.to_re " ")))))

; Parse length as an Int via constraint coupling (modeling: content_length_value must be the decimal form of parsed_len)
(assert (>= parsed_len 0))
(assert (<= parsed_len 99999))
(assert (str.in_re (str.from_int parsed_len) (re.+ (re.range "0" "9"))))
; enforce that after stripping spaces, the content_length_value equals the decimal form
(assert (= (str.replace (str.replace content_length_value " " "") " " "") (str.from_int parsed_len)))

; Ensure X has CRLF or LF structure and ends with a blank line after headers (typical HTTP)
; We model it by requiring that the rest after line2 begins with an empty line (i.e., line3 is empty)
(assert (>= (num_splits X "\u{a}") 4))
(assert (= (split_at X "\u{a}" 3) ""))

; Compose additional constraints using regex to ensure header formatting
(assert (str.in_re host_line (re.++ (str.to_re "Host") (str.to_re ":") (re.* (str.to_re " ")) (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") )))))
(assert (str.in_re content_length_line (re.++ (str.to_re "Content-Length") (str.to_re ":") (re.* (str.to_re " ")) (re.+ (re.range "0" "9")))))

; SAT instance constraints (consistent)
(assert (= parsed_len 42))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
