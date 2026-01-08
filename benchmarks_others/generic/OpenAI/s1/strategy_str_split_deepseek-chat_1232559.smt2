(set-logic ALL)

; --- Uninterpreted interface for str_split ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Core variables (mutated from seed) ---
(declare-const var_5 String)
(declare-const var_6 String)

; --- HTTP header parsing scenario variables ---
(declare-const request String)
(declare-const headers String)
(declare-const body String)
(declare-const first_line String)
(declare-const host_line String)
(declare-const cl_line String)
(declare-const host_key String)
(declare-const host_val String)
(declare-const cl_key String)
(declare-const cl_val String)
(declare-const cl_num Int)

; --- Preserve core structure: regex constraints over (var_5 "z" var_6) ---
(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (str.to_re "a") (re.++ (re.* (str.to_re "a")) (str.to_re "z")))))
    (re.++ (str.to_re "a") (re.* (str.to_re "a"))))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (re.union (str.to_re "z") (str.to_re "b"))
                    (re.++ (str.to_re "a") (re.union (str.to_re "z") (str.to_re "a")))))
    (str.to_re "a"))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.++
    (re.* (re.union (str.to_re "z")
                    (re.++ (re.union (str.to_re "b") (str.to_re "a"))
                          (re.union (str.to_re "z") (str.to_re "b")))))
    (re.union (str.to_re "b") (str.to_re "a")))))

(assert (str.in_re (str.++ var_5 "z" var_6 )
  (re.* (re.++ (re.union (str.to_re "z") (str.to_re "a"))
              (re.++ (re.* (str.to_re "z")) (str.to_re "a"))))))

(assert (str.in_re var_6 (re.* (re.range "a" "u"))))
(assert (str.in_re var_5 (re.* (re.range "a" "u"))))
(assert (not (str.in_re (str.++ "b" var_6 ) (re.* (re.range "a" "u")))))

; --- Connect seed vars into HTTP parsing (mutate/extend semantics) ---
; request is composed of var_5 and var_6 around a 'z' marker then headers/body
(assert (= request (str.++ var_5 "z" var_6 "\r\n" headers "\r\n\r\n" body)))

; --- Basic HTTP request line and header block splitting by CRLF ---
(assert (= first_line (split_at request "\r\n" 0)))
(assert (= headers (split_rest request "\r\n" 1)))
(assert (>= (num_splits request "\r\n") 3))

; first line contains spaces: METHOD SP PATH SP HTTP/V
(assert (>= (num_splits first_line " ") 3))

; --- Extract specific header lines from the headers block ---
; We model two header lines at fixed positions for simplicity
(assert (= host_line (split_at headers "\r\n" 0)))
(assert (= cl_line   (split_at headers "\r\n" 1)))
(assert (>= (num_splits headers "\r\n") 2))

; --- Parse "Key: Value" using split_at with ": " delimiter ---
(assert (= host_key (split_at host_line ": " 0)))
(assert (= host_val (split_at host_line ": " 1)))
(assert (>= (num_splits host_line ": ") 2))

(assert (= cl_key (split_at cl_line ": " 0)))
(assert (= cl_val (split_at cl_line ": " 1)))
(assert (>= (num_splits cl_line ": ") 2))

; --- Constrain keys and basic value patterns ---
(assert (= host_key "Host"))
(assert (= cl_key "Content-Length"))

; Host value should be non-empty and not contain CRLF
(assert (> (str.len host_val) 0))
(assert (not (str.contains host_val "\r")))
(assert (not (str.contains host_val "\n")))

; Content-Length value: digits-only (non-empty)
(assert (> (str.len cl_val) 0))
(assert (str.in_re cl_val (re.+ (re.range "0" "9"))))

; Link integer cl_num to string length: enforce that value is exactly "0" and body length is 0
; This acts as an UNSAT-inducing core when body is forced non-empty below.
(assert (= cl_num 0))
(assert (= cl_val "0"))
(assert (= (str.len body) cl_num))

; Additional constraints: require body to be non-empty (contradicts Content-Length 0)
(assert (> (str.len body) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
