(set-logic ALL)

; Scenario: HTTP Header Parsing
; Extract key/value pairs from request headers using ':' and newlines, and validate Content-Length.

; --- str_split interface (uninterpreted) ---
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

; --- Core variables ---
(declare-const req String)
(declare-const headers String)
(declare-const header0 String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const contentLengthStr String)
(declare-const body String)
(declare-const contentLength Int)

; Request is headers + blank line + body
(assert (= req (str.++ headers "\n\n" body)))

; At least 3 header lines
(assert (>= (num_splits headers "\n") 3))
(assert (= header0 (split_at headers "\n" 0)))
(assert (= header1 (split_at headers "\n" 1)))
(assert (= header2 (split_at headers "\n" 2)))

; First header line kept close to seed's idea but as a well-formed HTTP header
(assert (str.in_re header0 (str.to_re "WindowsAcmeReferer: a")))

; Parse second header as key:value (colon delimiter)
(assert (>= (num_splits header1 ":") 2))
(assert (= key1 (split_at header1 ":" 0)))
(assert (= val1 (split_rest header1 ":" 1)))

; Key must be non-empty and contain no spaces; value must start with a space
(assert (> (str.len key1) 0))
(assert (not (str.contains key1 " ")))
(assert (and (>= (str.len val1) 1) (= (str.at val1 0) " ")))

; Third header line is Content-Length: <digits>
(assert (>= (num_splits header2 ":") 2))
(assert (= (split_at header2 ":" 0) "Content-Length"))
(assert (= contentLengthStr (split_rest header2 ":" 1)))

; Enforce exactly one leading space then digits only
(assert (>= (str.len contentLengthStr) 2))
(assert (= (str.at contentLengthStr 0) " "))
(assert (str.in_re (str.substr contentLengthStr 1 (- (str.len contentLengthStr) 1)) (re.+ (re.range "0" "9"))))

; Bind integer contentLength to parsed digit string
(assert (= contentLength (str.to_int (str.substr contentLengthStr 1 (- (str.len contentLengthStr) 1)))))
(assert (>= contentLength 0))

; Validate that body length matches Content-Length
(assert (= (str.len body) contentLength))

; Additional structural constraint: ensure no extra blank line inside headers (i.e., headers does not contain "\n\n")
(assert (not (str.contains headers "\n\n")))

; UNSAT component: simultaneously force conflicting body length
; This makes the full instance UNSAT while preserving header parsing structure.
(assert (not (= (str.len body) contentLength)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
