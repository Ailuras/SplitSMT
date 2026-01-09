(set-logic ALL)

; Scenario: Log Analysis
; Parsing structured server log entries separated by spaces and colons.
; Key checks include timestamp format validation and log level extraction.

; str_split interface (uninterpreted)

; Seed variables preserved
(declare-fun key1 () String)
(declare-fun value2 () String)
(declare-fun key2 () String)
(declare-fun value1 () String)

; New variables for log parsing
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const kv1 String)
(declare-const kv2 String)
(declare-const tsDate String)
(declare-const tsTimeZ String)
(declare-const tsTime String)
(declare-const zone String)
(declare-const year String)
(declare-const month String)
(declare-const day String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)

; ------------------------------
; Core structure: space- and colon-separated parsing
; Format (example intent): "YYYY-MM-DDTHH:MM:SSZ LEVEL component: key1=value1 key2=value2, ..."
; ------------------------------

(assert (>= (str.num_splits logline " ") 4))
(assert (= ts (str.split_at logline " " 0)))
(assert (= level (str.split_at logline " " 1)))
(assert (= component (str.split_at logline " " 2)))
(assert (= msg (str.split_rest logline " " 3)))

; component should end with ':' and have at least 2 chars
(assert (>= (str.len component) 2))
(assert (= (str.at component (- (str.len component) 1)) ":"))

; message contains kv pairs separated by spaces
(assert (>= (str.num_splits msg " ") 2))
(assert (= kv1 (str.split_at msg " " 0)))
(assert (= kv2 (str.split_at msg " " 1)))

; kv parsing: key=value
(assert (>= (str.num_splits kv1 "=") 2))
(assert (>= (str.num_splits kv2 "=") 2))
(assert (= key1 (str.split_at kv1 "=" 0)))
(assert (= value1 (str.split_rest kv1 "=" 1)))
(assert (= key2 (str.split_at kv2 "=" 0)))
(assert (= value2 (str.split_rest kv2 "=" 1)))

; keys are not "cache-control" (seed constraints preserved)
(assert (not (= key1 "cache-control")))
(assert (not (= key2 "cache-control")))

; values must not contain '=' and must contain ',' somewhere (seed-like constraints)
(assert (= (str.indexof value1 "=" 0) (- 1)))
(assert (= (str.indexof value2 "=" 0) (- 1)))
(assert (str.contains value1 ","))
(assert (str.contains value2 ","))
(assert (> (str.len value1) 0))
(assert (> (str.len value2) 0))

; ------------------------------
; Timestamp checks
; Require ISO-8601-like: YYYY-MM-DDTHH:MM:SSZ
; ------------------------------

(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

(assert (= tsDate (str.split_at ts "T" 0)))
(assert (= tsTimeZ (str.split_at ts "T" 1)))
(assert (= tsTime (str.split_at tsTimeZ "Z" 0)))
(assert (= zone (str.split_rest tsTimeZ "Z" 1)))
(assert (= zone ""))

(assert (= year (str.split_at tsDate "-" 0)))
(assert (= month (str.split_at tsDate "-" 1)))
(assert (= day (str.split_at tsDate "-" 2)))
(assert (= hour (str.split_at tsTime ":" 0)))
(assert (= minute (str.split_at tsTime ":" 1)))
(assert (= second (str.split_at tsTime ":" 2)))

(assert (= (str.len year) 4))
(assert (= (str.len month) 2))
(assert (= (str.len day) 2))
(assert (= (str.len hour) 2))
(assert (= (str.len minute) 2))
(assert (= (str.len second) 2))

; numeric regex checks for timestamp fields
(assert (str.in_re year (re.+ (re.range "0" "9"))))
(assert (str.in_re month (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re day (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re hour (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re minute (re.++ (re.range "0" "9") (re.range "0" "9"))))
(assert (str.in_re second (re.++ (re.range "0" "9") (re.range "0" "9"))))

; ------------------------------
; Log level extraction and validation
; ------------------------------
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Ensure logline is reconstructable (weak consistency tying tokens together)
(assert (str.contains logline (str.++ ts " ")))
(assert (str.contains logline (str.++ " " level " ")))
(assert (str.contains logline (str.++ " " component " ")))

; Seed-inspired character guards on value1/value2 boundaries (simplified but similar flavor)
(assert (not (= (str.at value1 0) " ")))
(assert (not (= (str.at value2 0) " ")))
(assert (not (= (str.at value1 (- (str.len value1) 1)) " ")))
(assert (not (= (str.at value2 (- (str.len value2) 1)) " ")))

; ------------------------------
; Make this instance UNSAT: contradict timestamp zone check
; (ts is forced to end with 'Z' and have empty zone, but also require it to contain "+00:00")
; ------------------------------
(assert (str.contains ts "+00:00"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
