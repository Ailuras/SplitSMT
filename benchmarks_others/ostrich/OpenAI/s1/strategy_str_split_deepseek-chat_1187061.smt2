(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks include timestamp format validation and log level extraction.

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; --- seed-core declarations (kept / extended) ---
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

; --- log-specific declarations ---
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const message String)
(declare-const timepart String)
(declare-const y String)
(declare-const mo String)
(declare-const da String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const host String)
(declare-const kvpair String)
(declare-const key String)
(declare-const val String)

; --- seed core structure: a large regex membership with loop, and result concatenation ---
(assert (str.in_re attack (re.++ prefix ((_ re.loop 5000 5000) infix) postfix)))

; Mutated prefix to resemble a log header fragment: "x86_64 " then "1" digit "1" digit
(assert (= prefix
  (re.++
    (str.to_re "x")
    (re.++ (str.to_re "8")
    (re.++ (str.to_re "6")
    (re.++ (str.to_re "_")
    (re.++ (str.to_re "6")
    (re.++ (str.to_re "4")
    (re.++ (str.to_re " ")
    (re.++ (str.to_re "1")
    (re.++ (re.range "0" "9")
          (re.++ (str.to_re "1") (re.range "0" "9")))))))))))))

; Keep infix as intersection of digit+ and any tail, but tighten to ensure at least one digit then arbitrary chars
(assert (= infix
  (re.inter
    (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar))
    (re.++ (re.+ (re.range "0" "9")) (re.* re.allchar)))))

; Postfix is '@' per seed; keep and also require postfixs is exactly "@" (mutated from length>=1)
(assert (= postfix (str.to_re "@")))
(assert (str.in_re postfixs postfix))
(assert (= postfixs "@"))

(assert (= result (str.++ attack postfixs)))

; --- Build a structured logline from result and additional fields ---
; logline = "<ts> <level>: <message> <result>"
(assert (= logline (str.++ ts (str.++ " " (str.++ level (str.++ ": " (str.++ message (str.++ " " result))))))))

; Ensure basic splitting expectations: " " separators and ":" delimiter usage
(assert (>= (num_splits logline " ") 5))
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= message (split_at logline " " 2)))

; Parse "level:" by splitting message at ':' for an additional check; require message contains ':'
(assert (str.contains (str.++ level ":") ":"))

; Timestamp format validation: YYYY-MM-DDTHH:MM:SSZ
(assert (= timepart ts))
(assert (= (str.len timepart) 20))
(assert (= (str.at timepart 4) "-"))
(assert (= (str.at timepart 7) "-"))
(assert (= (str.at timepart 10) "T"))
(assert (= (str.at timepart 13) ":"))
(assert (= (str.at timepart 16) ":"))
(assert (= (str.at timepart 19) "Z"))

; Extract components via substrings
(assert (= y  (str.substr timepart 0 4)))
(assert (= mo (str.substr timepart 5 2)))
(assert (= da (str.substr timepart 8 2)))
(assert (= hh (str.substr timepart 11 2)))
(assert (= mm (str.substr timepart 14 2)))
(assert (= ss (str.substr timepart 17 2)))

; Component regex constraints
(assert (str.in_re y  (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.++ (re.range "0" "9") (re.range "0" "9"))))))
(assert (str.in_re mo (re.++ (re.range "0" "1") (re.range "0" "9"))))
(assert (str.in_re da (re.++ (re.range "0" "3") (re.range "0" "9"))))
(assert (str.in_re hh (re.++ (re.range "0" "2") (re.range "0" "9"))))
(assert (str.in_re mm (re.++ (re.range "0" "5") (re.range "0" "9"))))
(assert (str.in_re ss (re.++ (re.range "0" "5") (re.range "0" "9"))))

; Log level extraction constraints (allow INFO|WARN|ERROR)
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (str.to_re "ERROR")))))

; Additional parsing: message expected like "host:xyz"; split at ':'
(assert (str.contains message ":"))
(assert (= host (split_at message ":" 0)))
(assert (= kvpair (split_at message ":" 1)))
(assert (= host "host"))
(assert (>= (str.len kvpair) 1))

; Include a key=value pair after host value, e.g., "<val> key=..." in the rest
(assert (>= (num_splits (split_rest logline " " 3) "=") 2))
(assert (= key (split_at (split_rest logline " " 3) "=" 0)))
(assert (= val (split_at (split_rest logline " " 3) "=" 1)))

; --- UNSAT toggle via contradictory constraints (kept as part of file diversity) ---
; Force both INFO and ERROR simultaneously (impossible)
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
