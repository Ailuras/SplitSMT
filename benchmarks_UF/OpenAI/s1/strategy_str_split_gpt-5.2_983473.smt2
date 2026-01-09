(set-logic ALL)

; Uninterpreted interface for string splitting (per provided methodology)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Seed variables (kept for core structure mutation)
(declare-const x1 String)
(declare-const x2 String)
(declare-const z1 String)
(declare-const z2 String)

; HTTP header parsing variables
(declare-const request String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const body String)

(declare-const h1 String)
(declare-const h2 String)
(declare-const h3 String)

(declare-const host_line String)
(declare-const cl_line String)
(declare-const ua_line String)

(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const ua_key String)
(declare-const ua_value String)

(declare-const tmp1 String)
(declare-const tmp2 String)
(declare-const tmp3 String)

(declare-const content_length Int)

; --- Mutated core structure from seed: keep concatenation/equality shape but adapt to header-like tokens
(assert (= (str.++ (str.++ (str.++ x1 "Host" ) x2)
                   (str.++ z2 (str.++ "Content-Length" z1)))
           (str.++ (str.++ (str.++ x2 "User-Agent") x1)
                   (str.++ z1 (str.++ "Accept" z2)))))

; Relaxed length bound (seed had >16000; keep large-ish but not extreme)
(assert (> (str.len x1) 20))

; --- HTTP request structure: request = request_line \r\n headers \r\n\r\n body
(assert (= request (str.++ (str.++ request_line "\r\n") (str.++ headers_block (str.++ "\r\n\r\n" body)))))

; Request line basic shape: METHOD SP PATH SP HTTP/1.1
(assert (str.prefixof "GET " request_line))
(assert (str.contains request_line " HTTP/1.1"))

; Split headers by CRLF into at least 3 lines (Host, Content-Length, User-Agent)
(assert (>= (num_splits headers_block "\r\n") 3))
(assert (= h1 (split_at headers_block "\r\n" 0)))
(assert (= h2 (split_at headers_block "\r\n" 1)))
(assert (= h3 (split_at headers_block "\r\n" 2)))

; Each header line must have a colon separating key and value
(assert (>= (num_splits h1 ":") 2))
(assert (>= (num_splits h2 ":") 2))
(assert (>= (num_splits h3 ":") 2))

; Parse Host line
(assert (= host_line h1))
(assert (= host_key (split_at host_line ":" 0)))
(assert (= tmp1 (split_rest host_line ":" 1)))
; Accept optional leading space after colon in value
(assert (or (= host_value tmp1) (= host_value (str.substr tmp1 1 (- (str.len tmp1) 1)))))
(assert (= host_key "Host"))
(assert (> (str.len host_value) 0))

; Parse Content-Length line
(assert (= cl_line h2))
(assert (= cl_key (split_at cl_line ":" 0)))
(assert (= tmp2 (split_rest cl_line ":" 1)))
(assert (or (= cl_value tmp2) (= cl_value (str.substr tmp2 1 (- (str.len tmp2) 1)))))
(assert (= cl_key "Content-Length"))

; Parse User-Agent line
(assert (= ua_line h3))
(assert (= ua_key (split_at ua_line ":" 0)))
(assert (= tmp3 (split_rest ua_line ":" 1)))
(assert (or (= ua_value tmp3) (= ua_value (str.substr tmp3 1 (- (str.len tmp3) 1)))))
(assert (= ua_key "User-Agent"))
(assert (str.contains ua_value "Mozilla"))

; Content-Length validation (intentionally contradictory to create UNSAT):
; body length must match content_length, and content_length equals parsed value length,
; but also force a mismatch between body length and cl_value length.
(assert (= content_length (str.len cl_value)))
(assert (= (str.len body) content_length))
(assert (not (= (str.len body) (str.len cl_value))))

(check-sat)


; [GENERATION STATUS: SUCCESS]