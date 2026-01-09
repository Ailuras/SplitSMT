(set-logic ALL)

; Uninterpreted interface for split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core request/header blob
(declare-const X String)

; Derived header fields
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const user_agent_line String)
(declare-const header_name String)
(declare-const header_value String)
(declare-const content_length_str String)
(declare-const content_length_int Int)
(declare-const body String)

; Keep some of the seed's structure: forbid specific weird patterns
(assert (not (str.in_re X (str.to_re "Subject:User-Agent:iebarSubject:\u{a}"))))

; Still forbid a family of newline-terminated suspicious tokens (seed-mutation)
(assert (not (str.in_re X
  (re.++
    (re.union
      (re.++ (str.to_re "N") (re.union (str.to_re "B") (str.to_re "L") (str.to_re "S") (str.to_re "T") (str.to_re "U")))
      (re.++ (re.union (str.to_re "A") (str.to_re "M") (str.to_re "N")) (str.to_re "B"))
      (re.++ (re.union (str.to_re "B") (str.to_re "Q")) (str.to_re "C"))
      (str.to_re "ON")
      (str.to_re "PE")
      (str.to_re "SK"))
    (str.to_re "\u{a}")))))

; HTTP header parsing constraints using split_at/split_rest
(assert (= request_line (split_at X "\u{a}" 0)))
(assert (= headers_block (split_rest X "\u{a}" 1)))
(assert (>= (num_splits X "\u{a}") 3))

; Request line sanity: METHOD SP PATH SP HTTP/1.1
(assert (str.in_re request_line
  (re.++
    (re.union (str.to_re "GET") (str.to_re "POST") (str.to_re "HEAD"))
    (str.to_re " ")
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "/") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "?") (str.to_re "=") (str.to_re "&")))
    (str.to_re " HTTP/1.1"))))

; Identify some header lines by position in the newline split
(assert (= host_line (split_at X "\u{a}" 1)))
(assert (= user_agent_line (split_at X "\u{a}" 2)))
(assert (= content_length_line (split_at X "\u{a}" 3)))
(assert (>= (num_splits X "\u{a}") 5))

; Host header: "Host: " then a conservative hostname/port pattern
(assert (str.in_re host_line
  (re.++
    (str.to_re "Host:")
    (re.* (re.union (str.to_re " ") (str.to_re "\u{9}")))
    (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re ".") (str.to_re "-") ))
    (re.opt (re.++ (str.to_re ":") (re.+ (re.range "0" "9")))))))

; User-Agent header must contain a colon and some visible content
(assert (str.contains user_agent_line "User-Agent:"))
(assert (> (str.len user_agent_line) (str.len "User-Agent:")))

; Generic split of one header line at ':' to get name/value (apply to Content-Length line)
(assert (= header_name (split_at content_length_line ":" 0)))
(assert (= header_value (split_rest content_length_line ":" 1)))
(assert (>= (num_splits content_length_line ":") 2))

; Enforce it is the Content-Length header
(assert (= header_name "Content-Length"))

; Header value: optional SP/HT then digits only
(assert (str.in_re header_value (re.++ (re.* (re.union (str.to_re " ") (str.to_re "\u{9}"))) (re.+ (re.range "0" "9")))))

; Extract the digits portion by removing leading whitespace using a relaxed constraint
; (approximation: content_length_str is a suffix of header_value and is all digits)
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
(assert (str.contains header_value content_length_str))
(assert (<= (str.len content_length_str) (str.len header_value)))

; Define the body as everything after the empty line separator "\n\n" (two \u{a})
(assert (= body (split_rest X "\u{a}\u{a}" 1)))
(assert (>= (num_splits X "\u{a}\u{a}") 2))

; Content-Length integer constraints tied to body length
(assert (= content_length_int (str.to_int content_length_str)))
(assert (>= content_length_int 0))
(assert (<= content_length_int 1024))
(assert (= (str.len body) content_length_int))

; Preserve a mutated version of the seed's final positive regex, adapted for HTTP header parsing
; Require the request contains "HTTP/" and at least one newline
(assert (str.in_re X (re.++ re.allchar (str.to_re "HTTP/") re.allchar (str.to_re "\u{a}") re.allchar)))

; --- UNSAT core: contradict the content-length/body relation for all models ---
; If body length equals content_length_int and also must be different, the instance is UNSAT.
(assert (not (= (str.len body) content_length_int)))

(check-sat)


; [GENERATION STATUS: SUCCESS]