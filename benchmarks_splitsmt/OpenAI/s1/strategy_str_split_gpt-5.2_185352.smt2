(set-logic ALL)

; Scenario: HTTP Header Parsing
; Extract key/value pairs from request headers using ':' and newlines, and validate Content-Length.

; --- str_split interface (uninterpreted) ---

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
(assert (>= (str.num_splits headers "\n") 3))
(assert (= header0 (str.split_at headers "\n" 0)))
(assert (= header1 (str.split_at headers "\n" 1)))
(assert (= header2 (str.split_at headers "\n" 2)))

; First header line kept close to seed's idea but as a well-formed HTTP header
(assert (str.in_re header0 (str.to_re "WindowsAcmeReferer: a")))

; Parse second header as key:value (colon delimiter)
(assert (>= (str.num_splits header1 ":") 2))
(assert (= key1 (str.split_at header1 ":" 0)))
(assert (= val1 (str.split_rest header1 ":" 1)))

; Key must be non-empty and contain no spaces; value must start with a space
(assert (> (str.len key1) 0))
(assert (not (str.contains key1 " ")))
(assert (and (>= (str.len val1) 1) (= (str.at val1 0) " ")))

; Third header line is Content-Length: <digits>
(assert (>= (str.num_splits header2 ":") 2))
(assert (= (str.split_at header2 ":" 0) "Content-Length"))
(assert (= contentLengthStr (str.split_rest header2 ":" 1)))

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
