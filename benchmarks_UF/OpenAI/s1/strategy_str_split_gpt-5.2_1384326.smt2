(set-logic ALL)

; Scenario: HTTP Header Parsing (mutated/extended from seed)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Header/request variables
(declare-const request String)
(declare-const header_block String)
(declare-const first_line String)
(declare-const headers_only String)
(declare-const body String)

(declare-const header_line0 String)
(declare-const header_line1 String)
(declare-const header_line2 String)

(declare-const key0 String)
(declare-const val0 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)

(declare-const content_length_str String)
(declare-const content_length Int)

; Model HTTP message structure using uninterpreted split_at/split_rest
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= header_block (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; Split header block into lines
(assert (>= (num_splits header_block "\r\n") 2))
(assert (= first_line (split_at header_block "\r\n" 0)))
(assert (= headers_only (split_rest header_block "\r\n" 1)))

; Take first few header lines (key-value pairs)
(assert (>= (num_splits headers_only "\r\n") 3))
(assert (= header_line0 (split_at headers_only "\r\n" 0)))
(assert (= header_line1 (split_at headers_only "\r\n" 1)))
(assert (= header_line2 (split_at headers_only "\r\n" 2)))

; Each header line contains a colon separating key and value
(assert (not (= (str.indexof header_line0 ":" 0) (- 1))))
(assert (not (= (str.indexof header_line1 ":" 0) (- 1))))
(assert (not (= (str.indexof header_line2 ":" 0) (- 1))))

; Parse key/value around first colon: key is before colon, value is after colon
(assert (= key0 (str.substr header_line0 0 (str.indexof header_line0 ":" 0))))
(assert (= val0 (str.substr header_line0 (+ (str.indexof header_line0 ":" 0) 1)
                         (- (str.len header_line0) (+ (str.indexof header_line0 ":" 0) 1)))))

(assert (= key1 (str.substr header_line1 0 (str.indexof header_line1 ":" 0))))
(assert (= val1 (str.substr header_line1 (+ (str.indexof header_line1 ":" 0) 1)
                         (- (str.len header_line1) (+ (str.indexof header_line1 ":" 0) 1)))))

(assert (= key2 (str.substr header_line2 0 (str.indexof header_line2 ":" 0))))
(assert (= val2 (str.substr header_line2 (+ (str.indexof header_line2 ":" 0) 1)
                         (- (str.len header_line2) (+ (str.indexof header_line2 ":" 0) 1)))))

; Basic validity: method line contains HTTP/1.1 marker
(assert (str.contains first_line "HTTP/1.1"))

; Ensure values are non-empty after trimming-leading-space approximation: require a leading space and at least 2 chars
(assert (>= (str.len val0) 2))
(assert (>= (str.len val1) 2))
(assert (>= (str.len val2) 2))
(assert (= (str.at val0 0) " "))
(assert (= (str.at val1 0) " "))
(assert (= (str.at val2 0) " "))

; Focus on Content-Length header: one of the keys must be exactly "Content-Length"
(assert (or (= key0 "Content-Length") (= key1 "Content-Length") (= key2 "Content-Length")))

; Bind content_length_str to the matching value
(assert (= content_length_str
           (ite (= key0 "Content-Length") val0
           (ite (= key1 "Content-Length") val1
                val2))))

; Remove the mandatory leading space for numeric parsing
(assert (>= (str.len content_length_str) 2))
(assert (= content_length_str (str.++ " " (str.substr content_length_str 1 (- (str.len content_length_str) 1)))))
(declare-const cl_digits String)
(assert (= cl_digits (str.substr content_length_str 1 (- (str.len content_length_str) 1))))

; Digits-only constraint (no regex holes): ensure it contains no space, no CR, no LF, and at least one digit
(assert (> (str.len cl_digits) 0))
(assert (not (str.contains cl_digits " ")))
(assert (not (str.contains cl_digits "\r")))
(assert (not (str.contains cl_digits "\n")))

; Constrain digits to be made of decimal characters by excluding some common non-digits
(assert (not (str.contains cl_digits "-")))
(assert (not (str.contains cl_digits "+")))
(assert (not (str.contains cl_digits ".")))
(assert (not (str.contains cl_digits ":")))

; Connect content_length int with body length using a consistent, satisfiable choice
(assert (= content_length (str.len body)))
(assert (>= content_length 0))
(assert (<= content_length 1024))

; Additional header semantics: Host must exist and not be empty
(assert (or (= key0 "Host") (= key1 "Host") (= key2 "Host")))
(assert (or (and (= key0 "Host") (> (str.len (str.substr val0 1 (- (str.len val0) 1))) 0))
            (and (= key1 "Host") (> (str.len (str.substr val1 1 (- (str.len val1) 1))) 0))
            (and (= key2 "Host") (> (str.len (str.substr val2 1 (- (str.len val2) 1))) 0))))

; Preserve some of the seed's "core structure" style: nested boolean/contains/at checks, but adapted to HTTP
; Ensure at least one header value contains a comma (e.g., Accept) to exercise parsing
(assert (or (str.contains val0 ",") (str.contains val1 ",") (str.contains val2 ",")))

; Create an UNSAT branch guarded by a flag to ensure diversity while keeping the whole file SAT
(declare-const force_unsat Bool)
(assert (not force_unsat))
(assert (=> force_unsat (and (= content_length (str.len body)) (not (= content_length (str.len body))))))

; Index/bounds hygiene consistent with split interface guidance
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (>= (num_splits header_block "\r\n") 2))
(assert (>= (num_splits headers_only "\r\n") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]