; HTTP Header Parsing with str_split operations
; Extracting values from HTTP request headers using colons and newlines
; Validates content-length and key-value pairs
(set-logic ALL)

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
(assert (>= (str.num_splits header delimiter_newline) 3))

; Extract first line (Host)
(assert (= host_key (str.split_at header delimiter_newline 0)))
; Split Host line by colon to get key and value
(assert (= host_val (str.split_at host_key delimiter_colon 1)))
(assert (str.contains host_key "Host:"))
(assert (str.contains host_val "example.com"))

; Extract second line (Content-Length)
(assert (= content_length_str (str.split_at header delimiter_newline 1)))
; Split Content-Length line by colon to get value
(assert (= content_length_val (str.split_at content_length_str delimiter_colon 1)))
(assert (str.contains content_length_str "Content-Length:"))
; Validate content-length value is numeric and positive
(assert (str.in_re content_length_val (re.+ (re.range "0" "9"))))
(assert (not (= content_length_val "0")))

; Extract third line (User-Agent)
(assert (= user_agent_key (str.split_at header delimiter_newline 2)))
; Split User-Agent line by colon to get value
(assert (= user_agent_val (str.split_at user_agent_key delimiter_colon 1)))
(assert (str.contains user_agent_key "User-Agent:"))
(assert (str.contains user_agent_val "Mozilla"))

; Additional constraints for robustness
; Ensure no empty lines in header
(assert (not (str.contains header (str.++ delimiter_newline delimiter_newline))))
; Ensure all lines end with newline (except possibly last)
(assert (str.suffixof delimiter_newline (str.split_rest header delimiter_newline 0)))

; Mixed constraints to create a SAT instance
; Constraint on seed variables to avoid trivial solution
(assert (>= (str.len E) 2))
(assert (>= (str.len J) 1))
(assert (distinct L F))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
