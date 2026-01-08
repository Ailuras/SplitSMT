(set-logic ALL)

; Uninterpreted interface for string split

; HTTP header parsing variables
(declare-const req String)
(declare-const request_line String)
(declare-const headers_block String)
(declare-const host_line String)
(declare-const content_length_line String)
(declare-const host_key String)
(declare-const host_value String)
(declare-const cl_key String)
(declare-const cl_value String)
(declare-const cl_int Int)
(declare-const body String)
(declare-const body_len Int)

; Keep core structure: let-bound regex star and nested concatenations with in_re comparisons
(assert
  (let ((_let_0 (re.* re.allchar)))
    (let ((_let_1 (str.++ "B" (str.++ "B" "B"))))
      (and
        ; Request must contain at least one ':' and at least one newline to resemble headers
        (str.contains req ":")
        (str.contains req "\n")

        ; Parse request line and header block by newline
        (>= (str.num_splits req "\n") 3)
        (= request_line (str.split_at req "\n" 0))
        (= headers_block (str.split_rest req "\n" 1))

        ; Extract specific header lines by newline splitting
        (= host_line (str.split_at headers_block "\n" 0))
        (= content_length_line (str.split_at headers_block "\n" 1))

        ; Each header line must be key:value form
        (>= (str.num_splits host_line ":") 2)
        (>= (str.num_splits content_length_line ":") 2)

        ; Extract keys and values
        (= host_key (str.split_at host_line ":" 0))
        (= host_value (str.split_rest host_line ":" 1))
        (= cl_key (str.split_at content_length_line ":" 0))
        (= cl_value (str.split_rest content_length_line ":" 1))

        ; Validate header keys
        (= host_key "Host")
        (= cl_key "Content-Length")

        ; Host value non-empty and must not contain newline
        (> (str.len host_value) 0)
        (not (str.contains host_value "\n"))

        ; Content-Length value must be digits only and non-empty
        (> (str.len cl_value) 0)
        (str.in_re cl_value (re.+ (re.range "0" "9")))

        ; Body is everything after two header lines (and their trailing newlines), simplified via split
        (= body (str.split_rest headers_block "\n" 2))
        (= body_len (str.len body))

        ; Content length integer bounds and relation (approximate validation)
        (>= cl_int 0)
        (<= cl_int 2048)

        ; SAT core: require either exact match or body longer than declared length
        (or (= body_len cl_int) (> body_len cl_int))

        ; Core seed-style constraints: compare in_re booleans with complex regexes
        (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 (str.to_re "B") _let_0 (str.to_re (str.++ "A" (str.++ "C" "B"))) _let_0))
                (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (str.to_re (str.++ "C" (str.++ "C" (str.++ "B" "C"))) ) _let_0))))
        (not (= (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (re.++ (str.to_re _let_1) re.allchar) _let_0))
                (str.in_re req (re.++ _let_0 re.allchar _let_0 re.allchar _let_0 (str.to_re (str.++ "B" _let_1)) _let_0))))

        ; Additional header sanity: forbid CR and require request line starts with a method token
        (not (str.contains req "\r"))
        (or (str.prefixof "GET " request_line)
            (str.prefixof "POST " request_line)
            (str.prefixof "HEAD " request_line))

        ; UNSAT branch gated by impossible conjunction is avoided; keep overall SAT
        (not (and (= host_value "") (= host_value (str.++ "x" host_value))))
      ))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
