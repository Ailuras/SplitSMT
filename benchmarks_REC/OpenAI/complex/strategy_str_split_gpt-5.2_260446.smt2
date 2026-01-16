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

; HTTP Header Parsing scenario: extract key-value pairs split by newlines and colon-space

; Uninterpreted split interface

; Input request headers blob
(declare-const X String)

; Derived lines and fields
(declare-const request_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_value String)
(declare-const cl_value String)
(declare-const cl_len Int)
(declare-const body String)
(declare-const header_blob String)

; Core structure preserved/mutated from seed: keep the two negative regex constraints (slightly generalized)
(assert (not (str.in_re X (re.++ (str.to_re "search2.ad.shopnav.com/9899/search/results.php") (re.* re.allchar) (str.to_re "Logger") (re.* re.allchar) (str.to_re "Subject:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:Host:\u{a}")))))
(assert (not (str.in_re X (str.to_re "forum=From:comTencentTravelerBackAtTaCkExplorer\u{a}"))))

; Basic HTTP header shape: request line + headers + empty line + body
(assert (>= (num_splits X "\u{a}") 5))
(assert (= request_line (split_at X "\u{a}" 0)))
(assert (= host_line (split_at X "\u{a}" 1)))
(assert (= cl_line (split_at X "\u{a}" 2)))
(assert (= body (split_rest X "\u{a}" 4)))
(assert (= header_blob (split_rest X "\u{a}" 1)))

; Request line should begin with a method token and contain HTTP version marker
(assert (str.contains request_line "HTTP/1."))
(assert (or (str.contains request_line "GET ") (str.contains request_line "POST ") (str.contains request_line "HEAD ")))

; Parse Host header: "Host: " + value
(assert (= (split_at host_line ": " 0) "Host"))
(assert (>= (num_splits host_line ": ") 2))
(assert (= host_value (split_at host_line ": " 1)))
(assert (>= (str.len host_value) 1))
(assert (not (str.contains host_value " ")))
(assert (not (str.contains host_value "\u{a}")))

; Parse Content-Length header: "Content-Length: " + digits
(assert (= (split_at cl_line ": " 0) "Content-Length"))
(assert (>= (num_splits cl_line ": ") 2))
(assert (= cl_value (split_at cl_line ": " 1)))
(assert (str.in_re cl_value (re.+ (re.range "0" "9"))))

; Content-length numeric consistency (string length in bytes/characters)
(assert (= cl_len (str.to_int cl_value)))
(assert (>= cl_len 0))
(assert (= cl_len (str.len body)))

; Additional constraints: ensure there is a blank line separating headers from body
(assert (= (split_at X "\u{a}" 3) ""))

; SAT branch: at least one extra header after Content-Length (not necessarily parsed)
(assert (>= (num_splits header_blob "\u{a}") 3))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
