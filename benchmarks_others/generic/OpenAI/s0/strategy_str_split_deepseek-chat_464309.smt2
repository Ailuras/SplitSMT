(set-logic ALL)

; Uninterpreted str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Additional uninterpreted helper for integer parsing (non-primitive operation)
(declare-fun str_to_int (String) Int)

; =========================
; SAT instance: well-formed HTTP header parsing
; =========================
(declare-const req_sat String)
(declare-const line0_sat String)
(declare-const line1_sat String)
(declare-const line2_sat String)
(declare-const host_line_sat String)
(declare-const cl_line_sat String)
(declare-const host_key_sat String)
(declare-const host_val_sat String)
(declare-const cl_key_sat String)
(declare-const cl_val_sat String)
(declare-const content_length_sat Int)
(declare-const body_sat String)

; Request consists of 3 header lines then a blank line then a body
(assert (= req_sat (str.++ line0_sat "\n" line1_sat "\n" line2_sat "\n\n" body_sat)))

; First line is request line (keep it simple but structured)
(assert (str.in_re line0_sat (re.++ (str.to_re "GET ") (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "/") (str.to_re "_") (str.to_re "-") (str.to_re "."))) (str.to_re " HTTP/1.1"))))

; Header lines: enforce presence of ':' and a space after it
(assert (>= (num_splits line1_sat ":") 2))
(assert (>= (num_splits line2_sat ":") 2))
(assert (= (str.at line1_sat (+ (str.indexof line1_sat ":" 0) 1)) " "))
(assert (= (str.at line2_sat (+ (str.indexof line2_sat ":" 0) 1)) " "))

; Choose line1 = Host header, line2 = Content-Length header
(assert (= host_line_sat line1_sat))
(assert (= cl_line_sat line2_sat))

; Parse key/value around ':' using split_at and split_rest
(assert (= host_key_sat (split_at host_line_sat ":" 0)))
(assert (= host_val_sat (split_rest host_line_sat ":" 1)))
(assert (= cl_key_sat (split_at cl_line_sat ":" 0)))
(assert (= cl_val_sat (split_rest cl_line_sat ":" 1)))

; Keys expected
(assert (= host_key_sat "Host"))
(assert (= cl_key_sat "Content-Length"))

; Values: host must be non-empty and not contain newline/colon; content-length value begins with a space then digits
(assert (> (str.len host_val_sat) 1))
(assert (not (str.contains host_val_sat "\n")))
(assert (not (str.contains host_val_sat ":")))

; Require host value to start with a space then a simple hostname token
(assert (str.in_re host_val_sat (re.++ (str.to_re " ") (re.+ (re.union (str.to_re "a") (str.to_re "b") (str.to_re "c") (str.to_re "d") (str.to_re "e") (str.to_re "f") (str.to_re "g") (str.to_re "h") (str.to_re "i") (str.to_re "j") (str.to_re "k") (str.to_re "l") (str.to_re "m") (str.to_re "n") (str.to_re "o") (str.to_re "p") (str.to_re "q") (str.to_re "r") (str.to_re "s") (str.to_re "t") (str.to_re "u") (str.to_re "v") (str.to_re "w") (str.to_re "x") (str.to_re "y") (str.to_re "z") (str.to_re "A") (str.to_re "B") (str.to_re "C") (str.to_re "D") (str.to_re "E") (str.to_re "F") (str.to_re "G") (str.to_re "H") (str.to_re "I") (str.to_re "J") (str.to_re "K") (str.to_re "L") (str.to_re "M") (str.to_re "N") (str.to_re "O") (str.to_re "P") (str.to_re "Q") (str.to_re "R") (str.to_re "S") (str.to_re "T") (str.to_re "U") (str.to_re "V") (str.to_re "W") (str.to_re "X") (str.to_re "Y") (str.to_re "Z") (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9") (str.to_re "-") (str.to_re "."))))))

; Content-Length value: " " + digits
(assert (str.in_re cl_val_sat (re.++ (str.to_re " ") (re.+ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))))

; Convert to int (uninterpreted), constrain it and link to body length
(assert (= content_length_sat (str_to_int cl_val_sat)))
(assert (>= content_length_sat 0))
(assert (<= content_length_sat 1024))
(assert (= (str.len body_sat) content_length_sat))

; Some extra sanity: request must contain the header-body separator
(assert (str.contains req_sat "\n\n"))

(check-sat)

; =========================
; UNSAT instance: conflicting Content-Length constraints
; =========================
(declare-const req_unsat String)
(declare-const l0_unsat String)
(declare-const l1_unsat String)
(declare-const l2_unsat String)
(declare-const cl_line_unsat String)
(declare-const cl_key_unsat String)
(declare-const cl_val_unsat String)
(declare-const cl_int_unsat Int)
(declare-const body_unsat String)

(assert (= req_unsat (str.++ l0_unsat "\n" l1_unsat "\n" l2_unsat "\n\n" body_unsat)))

; Force line2 to be Content-Length
(assert (= cl_line_unsat l2_unsat))
(assert (= cl_key_unsat (split_at cl_line_unsat ":" 0)))
(assert (= cl_val_unsat (split_rest cl_line_unsat ":" 1)))
(assert (= cl_key_unsat "Content-Length"))

; Value form still looks like space+digits
(assert (str.in_re cl_val_unsat (re.++ (str.to_re " ") (re.+ (re.union (str.to_re "0") (str.to_re "1") (str.to_re "2") (str.to_re "3") (str.to_re "4") (str.to_re "5") (str.to_re "6") (str.to_re "7") (str.to_re "8") (str.to_re "9"))))))

; Link and contradict: body length fixed to 5 but parsed length forced to 10
(assert (= cl_int_unsat (str_to_int cl_val_unsat)))
(assert (= (str.len body_unsat) 5))
(assert (= cl_int_unsat 10))
(assert (= (str.len body_unsat) cl_int_unsat))

(check-sat)


; [GENERATION STATUS: SUCCESS]
