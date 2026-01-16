; HTTP Header Parsing Scenario: Extracting values from HTTP request headers using colons and newlines
; Must handle key-value pairs and validate content-length
(set-logic ALL)

; Declare string variables for HTTP request and headers
(declare-const request String)
(declare-const header_line String)
(declare-const key String)
(declare-const value String)
(declare-const content_length_str String)
(declare-const content_length_val Int)

; Declare functions for string split operations

; Constraint 1: Request must contain a header line with key-value pair separated by colon
(assert (str.contains request header_line))
(assert (str.contains header_line ":"))

; Constraint 2: Split header_line by colon to extract key and value
(assert (= key (str.split_at header_line ":" 0)))
(assert (= value (str.split_at header_line ":" 1)))
(assert (>= (str.num_splits header_line ":") 2))

; Constraint 3: Key must be non-empty and not contain whitespace
(assert (> (str.len key) 0))
(assert (not (str.contains key " ")))
(assert (not (str.contains key "\u{9}")))
(assert (not (str.contains key "\u{a}")))

; Constraint 4: Value must be non-empty
(assert (> (str.len value) 0))

; Constraint 5: If key is "Content-Length", validate the value as a positive integer
(assert (=> (str.contains key "Content-Length") (str.contains value content_length_str)))
(assert (=> (str.contains key "Content-Length") (str.in_re content_length_str (re.+ (re.range "0" "9")))))
(assert (=> (str.contains key "Content-Length") (> content_length_val 0)))

; Constraint 6: Request must end with a newline character
(assert (str.suffixof "\u{a}" request))

; Constraint 7: Request must not contain malicious patterns (seed constraints adapted)
(assert (not (str.in_re request (re.++ (str.to_re "dialupvpn_pwd") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "HXDownloadupdailyinformation\u{a}")))))
(assert (not (str.in_re request (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".wri/i\u{a}")))))
(assert (not (str.in_re request (str.to_re "badurl.grandstreetinteractive.comFilteredHost:e2give.com/newsurfer4/\u{a}"))))
(assert (not (str.in_re request (re.++ (str.to_re "www.weepee.com\u{1b}") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "www.webfringe.comwww.123mania.com/0409\u{a}")))))
(assert (not (str.in_re request (re.++ (str.to_re "$") (re.+ (re.union (str.to_re "0") (re.range " " "9"))) (str.to_re "\u{a}")))))

; Constraint 8: Additional validation: header_line must be a substring of request ending before newline
(assert (str.prefixof header_line (str.split_at request "\u{a}" 0)))


; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
