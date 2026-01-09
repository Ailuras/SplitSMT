(set-logic ALL)

; Scenario: HTTP Header Parsing (mutated/extended from seed)
; We keep the core idea: a complex regex-driven constraint on X plus a negative membership assertion.


(declare-const X String)
(declare-const request_line String)
(declare-const headers String)
(declare-const body String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_val String)
(declare-const cl_val String)
(declare-const method String)
(declare-const path String)
(declare-const version String)
(declare-const len_digits String)
(declare-const d0 String)
(declare-const d1 String)
(declare-const d2 String)
(declare-const d3 String)
(declare-const d4 String)

(declare-const n0 Int)
(declare-const n1 Int)
(declare-const n2 Int)
(declare-const n3 Int)
(declare-const n4 Int)
(declare-const content_length Int)

; --- Seed-derived regex: keep large structure but used as a line-level pattern for header values
(declare-const header_payload String)
(assert
  (str.in_re header_payload
    (re.union
      (re.++
        (str.to_re "(")
        (re.union
          (re.++ (re.range "2" "7") ((_ re.loop 2 2) (re.range "0" "9")))
          (re.++
            (str.to_re "8")
            ((_ re.loop 1 1)
              (re.union
                (re.++ (str.to_re "0") (re.comp (str.to_re "0")))
                (re.++ (re.comp (str.to_re "0")) (str.to_re "0"))
                (re.++ (str.to_re "1") (re.range "0" "9"))
                (re.++ (str.to_re "2") (re.comp (str.to_re "2")))
                (re.++ (re.comp (str.to_re "2")) (str.to_re "2"))
                (re.++ (str.to_re "3") (re.comp (str.to_re "3")))
                (re.++ (re.comp (str.to_re "3")) (str.to_re "3"))
                (re.++ (str.to_re "4") (re.comp (str.to_re "4")))
                (re.++ (re.comp (str.to_re "4")) (str.to_re "4"))
                (re.++ (str.to_re "5") (re.comp (str.to_re "5")))
                (re.++ (re.comp (str.to_re "5")) (str.to_re "5"))
                (re.++ (str.to_re "6") (re.comp (str.to_re "6")))
                (re.++ (re.comp (str.to_re "6")) (str.to_re "6"))
                (re.++ (str.to_re "7") (re.comp (str.to_re "7")))
                (re.++ (re.comp (str.to_re "7")) (str.to_re "7"))
                (re.++ (str.to_re "8") (re.comp (str.to_re "8")))
                (re.++ (re.comp (str.to_re "8")) (str.to_re "8"))
                (re.++ (str.to_re "9") (re.range "0" "9")))))
          (re.++
            (str.to_re "9")
            (re.union
              (re.++ (str.to_re "0") (re.comp (str.to_re "0")))
              (re.++ (re.comp (str.to_re "0")) (str.to_re "0"))
              (re.++ (re.range "1" "9") (re.range "1" "9")))))
        (str.to_re ")")
        (re.opt (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
        ((_ re.loop 3 3) (re.range "0" "9"))
        (re.opt (re.union (str.to_re "-") (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}")))
        ((_ re.loop 4 4) (re.range "0" "9")))
      (re.++
        (re.union
          (re.++ (re.range "2" "7") ((_ re.loop 2 2) (re.range "0" "9")))
          (re.++
            (str.to_re "8")
            ((_ re.loop 1 1)
              (re.union
                (re.++ (str.to_re "0") (re.comp (str.to_re "0")))
                (re.++ (re.comp (str.to_re "0")) (str.to_re "0"))
                (re.++ (str.to_re "1") (re.range "0" "9"))
                (re.++ (str.to_re "2") (re.comp (str.to_re "2")))
                (re.++ (re.comp (str.to_re "2")) (str.to_re "2"))
                (re.++ (str.to_re "3") (re.comp (str.to_re "3")))
                (re.++ (re.comp (str.to_re "3")) (str.to_re "3"))
                (re.++ (str.to_re "4") (re.comp (str.to_re "4")))
                (re.++ (re.comp (str.to_re "4")) (str.to_re "4"))
                (re.++ (str.to_re "5") (re.comp (str.to_re "5")))
                (re.++ (re.comp (str.to_re "5")) (str.to_re "5"))
                (re.++ (str.to_re "6") (re.comp (str.to_re "6")))
                (re.++ (re.comp (str.to_re "6")) (str.to_re "6"))
                (re.++ (str.to_re "7") (re.comp (str.to_re "7")))
                (re.++ (re.comp (str.to_re "7")) (str.to_re "7"))
                (re.++ (str.to_re "8") (re.comp (str.to_re "8")))
                (re.++ (re.comp (str.to_re "8")) (str.to_re "8"))
                (re.++ (str.to_re "9") (re.range "0" "9")))))
          (re.++
            (str.to_re "9")
            (re.union
              (re.++ (str.to_re "0") (re.comp (str.to_re "0")))
              (re.++ (re.comp (str.to_re "0")) (str.to_re "0"))
              (re.++ (re.range "1" "9") (re.range "1" "9")))))
        (re.opt (str.to_re "-"))
        ((_ re.loop 3 3) (re.range "0" "9"))
        (re.opt (str.to_re "-"))
        ((_ re.loop 4 4) (re.range "0" "9"))
        (str.to_re "\u{a}")))))

; --- Core parsing structure: request line + headers + blank line + body
(assert (= request_line (str.split_at X "\u{a}" 0)))
(assert (= headers (str.split_at X "\u{a}\u{a}" 0)))
(assert (= body (str.split_rest X "\u{a}\u{a}" 1)))
(assert (>= (str.num_splits X "\u{a}") 2))
(assert (>= (str.num_splits X "\u{a}\u{a}") 2))

; Request line parsing: METHOD SP PATH SP VERSION
(assert (= method (str.split_at request_line " " 0)))
(assert (= path (str.split_at request_line " " 1)))
(assert (= version (str.split_at request_line " " 2)))
(assert (>= (str.num_splits request_line " ") 3))
(assert (str.in_re method (re.union (str.to_re "GET") (str.to_re "POST"))))
(assert (str.prefixof "/" path))
(assert (= version "HTTP/1.1"))

; Header line extraction by newline from headers block
(assert (= host_line (str.split_at headers "\u{a}" 1)))
(assert (= cl_line (str.split_at headers "\u{a}" 2)))
(assert (>= (str.num_splits headers "\u{a}") 3))

; Each header line must contain a colon (key:value)
(assert (>= (str.num_splits host_line ":") 2))
(assert (>= (str.num_splits cl_line ":") 2))

; Parse values
(assert (= host_val (str.split_rest host_line ":" 1)))
(assert (= cl_val (str.split_rest cl_line ":" 1)))

; Require keys
(assert (= (str.split_at host_line ":" 0) "Host"))
(assert (= (str.split_at cl_line ":" 0) "Content-Length"))

; Trim-like: allow optional leading single space in values
(assert (or (= host_val (str.++ " " (str.replace host_val " " ""))) (= (str.at host_val 0) "h") (= (str.at host_val 0) "e") (= (str.at host_val 0) "l") (= (str.at host_val 0) "w") (= (str.at host_val 0) "a") (= (str.at host_val 0) "b") (= (str.at host_val 0) "c") (= (str.at host_val 0) "d") (= (str.at host_val 0) "f") (= (str.at host_val 0) "g")))

; Host value: simple domain-ish constraint (no spaces, contains a dot)
(assert (not (str.contains host_val " ")))
(assert (str.contains host_val "."))

; Content-Length value: allow optional leading space then digits (1..5 digits)
(assert (str.in_re cl_val (re.++ (re.opt (str.to_re " ")) ((_ re.loop 1 5) (re.range "0" "9")))))

; Extract up to 5 digits ignoring a possible leading space by using substr
(assert (= len_digits (str.replace cl_val " " "")))
(assert (str.in_re len_digits ((_ re.loop 1 5) (re.range "0" "9"))))

; Compute integer content_length from up to 5 digits by positional expansion with 0-padding
(assert (<= (str.len len_digits) 5))
(assert (= d0 (str.at (str.++ "00000" len_digits) (- (+ 5 (str.len len_digits)) 5))))
(assert (= d1 (str.at (str.++ "00000" len_digits) (- (+ 5 (str.len len_digits)) 4))))
(assert (= d2 (str.at (str.++ "00000" len_digits) (- (+ 5 (str.len len_digits)) 3))))
(assert (= d3 (str.at (str.++ "00000" len_digits) (- (+ 5 (str.len len_digits)) 2))))
(assert (= d4 (str.at (str.++ "00000" len_digits) (- (+ 5 (str.len len_digits)) 1))))

(assert (str.in_re d0 (re.range "0" "9")))
(assert (str.in_re d1 (re.range "0" "9")))
(assert (str.in_re d2 (re.range "0" "9")))
(assert (str.in_re d3 (re.range "0" "9")))
(assert (str.in_re d4 (re.range "0" "9")))

(assert (= n0 (- (str.to_code d0) (str.to_code "0"))))
(assert (= n1 (- (str.to_code d1) (str.to_code "0"))))
(assert (= n2 (- (str.to_code d2) (str.to_code "0"))))
(assert (= n3 (- (str.to_code d3) (str.to_code "0"))))
(assert (= n4 (- (str.to_code d4) (str.to_code "0"))))

(assert (and (<= 0 n0) (<= n0 9) (<= 0 n1) (<= n1 9) (<= 0 n2) (<= n2 9) (<= 0 n3) (<= n3 9) (<= 0 n4) (<= n4 9)))

(assert (= content_length (+ (* 10000 n0) (* 1000 n1) (* 100 n2) (* 10 n3) n4)))

; Validate: body length must match the declared Content-Length
(assert (= (str.len body) content_length))

; Tie in the seed regex with HTTP parsing: require header_payload to appear in headers
(assert (str.contains headers header_payload))

; Negative membership constraint preserved/mutated from seed
(assert (not (str.in_re X (str.to_re "Host:uploadServer3AdapupdEFErrorSubject:\u{a}"))))

; Additional UNSAT branch guarded by contradiction to ensure diversity:
; If method is GET, force non-empty body but Content-Length computed from digits could be 0 with empty body.
(assert (=> (= method "GET") (>= (str.len body) 1)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
