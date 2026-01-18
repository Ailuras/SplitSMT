; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validates content-length and key-value pairs
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

; Declare string variables for HTTP header components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const user_agent_key String)
(declare-const user_agent_val String)
(declare-const delimiter_colon String)
(declare-const delimiter_newline String)

; Set delimiters
(assert (= delimiter_colon ":"))
(assert (= delimiter_newline "\n"))

; Define str_split interface functions

; Seed constraint from original (preserved with modifications)
(declare-fun L () String)
(declare-fun F () String)
(declare-fun E () String)
(declare-fun J () String)
(assert (= (str.++ "ieafbhdibeaghgcga" E "af" J "bebgfb" L "egdfbf" J "ffaahbdeeg" J "iifbi" J "id" J "fafg") (str.++ "iea" F "bi" J "idcfafg")))

; HTTP header parsing constraints
; Example header: "Host: example.com\nContent-Length: 123\nUser-Agent: Mozilla\n"
(assert (= header (str.++ "Host: example.com" delimiter_newline "Content-Length: 123" delimiter_newline "User-Agent: Mozilla" delimiter_newline)))

; Split header by newlines to get individual lines
(assert (>= (num_splits header delimiter_newline) 3))

; Extract first line (Host)
(assert (= host_key (split_at header delimiter_newline 0)))
; Split Host line by colon to get key and value
(assert (= host_val (split_at host_key delimiter_colon 1)))
(assert (str.contains host_key "Host:"))
(assert (str.contains host_val "example.com"))

; Extract second line (Content-Length)
(assert (= content_length_str (split_at header delimiter_newline 1)))
; Split Content-Length line by colon to get value
(assert (= content_length_val (split_at content_length_str delimiter_colon 1)))
(assert (str.contains content_length_str "Content-Length:"))
; Validate content-length value is numeric and positive
(assert (str.in_re content_length_val (re.+ (re.range "0" "9"))))
(assert (not (= content_length_val "0")))

; Extract third line (User-Agent)
(assert (= user_agent_key (split_at header delimiter_newline 2)))
; Split User-Agent line by colon to get value
(assert (= user_agent_val (split_at user_agent_key delimiter_colon 1)))
(assert (str.contains user_agent_key "User-Agent:"))
(assert (str.contains user_agent_val "Mozilla"))

; Additional constraints for robustness
; Ensure no empty lines in header
(assert (not (str.contains header (str.++ delimiter_newline delimiter_newline))))
; Ensure all lines end with newline (except possibly last)
(assert (str.suffixof delimiter_newline (split_rest header delimiter_newline 0)))

; Mixed constraints to create a SAT instance
; Constraint on seed variables to avoid trivial solution
(assert (>= (str.len E) 2))
(assert (>= (str.len J) 1))
(assert (distinct L F))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
