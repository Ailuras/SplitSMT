; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines, handling key-value pairs and validating content-length.
; Mutated and extended from seed to incorporate str_split operations and diverse constraints.
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

; Declare string variables for HTTP headers and components
(declare-const header String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare functions for str_split interface

; Constraint 1: Header must contain specific key-value pairs separated by colons and newlines
(assert (str.contains header "User-Agent:"))
(assert (str.contains header "Host:"))
(assert (str.contains header "Content-Length:"))

; Constraint 2: Split header by newline to extract segments
(assert (>= (num_splits header "\u{a}") 3))
(assert (= key1 (split_at header "\u{a}" 0)))
(assert (= value1 (split_rest header "\u{a}" 1)))

; Constraint 3: Further split first segment by colon to get key and value
(assert (>= (num_splits key1 ":") 2))
(assert (= (split_at key1 ":" 0) "User-Agent"))
(assert (>= (str.len (split_at key1 ":" 1)) 1))

; Constraint 4: Extract Content-Length value and validate it as a positive integer
(assert (str.contains header "Content-Length:"))
(assert (= content_length_str (split_at header "Content-Length:" 1)))
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
(assert (>= (str.to_int content_length_str) 0))
(assert (= content_length_val (str.to_int content_length_str)))
(assert (<= content_length_val 10000))

; Constraint 5: Header must match a regex pattern for valid HTTP request structure
(assert (str.in_re header (re.++ (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re "-") (str.to_re ":") (str.to_re " ") (str.to_re "\u{a}"))) (str.to_re "\u{a}\u{a}"))))

; Constraint 6: Ensure no malicious patterns (e.g., Trojan) are present
(assert (not (str.in_re header (re.++ (str.to_re "Trojan:") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "by") (re.+ (re.range "0" "9")) (str.to_re "to") (re.+ (re.union (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_"))) (str.to_re "dddlogin.dudu.comSurveillance\u{13}IPOblivion\u{a}")))))

; Constraint 7: Header must not contain invalid port patterns
(assert (not (str.in_re header (re.++ (str.to_re "01") ((_ re.loop 1 1) (re.range "0" "2")) ((_ re.loop 8 8) (re.range "0" "9")) (str.to_re "\u{a}")))))

; Constraint 8: Header must not contain specific filename patterns
(assert (not (str.in_re header (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".m4b/i\u{a}")))))

; Constraint 9: Additional validation for key2 and value2 using split operations
(assert (= key2 (split_at header "\u{a}" 1)))
(assert (str.contains key2 ":"))
(assert (= value2 (split_rest header "\u{a}" 2)))
(assert (>= (str.len value2) 5))

; Check satisfiability

; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
