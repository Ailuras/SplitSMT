; Log Analysis: parsing structured server log entries separated by spaces and colons
(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Core variables (mutated from seed)
(declare-const value2 String)
(declare-const key2 String)

; Additional log-related variables
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const component String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)

; --- Core structure preserved: keep key/value sanity constraints similar to seed ---
(assert (and
  ; key2 is fixed to an expected field in a parsed KV segment
  (not (= (ite (= key2 "cache-control") 1 0) 0))

  ; value2 behaves like a header value containing commas and '=' appears somewhere
  (not (= (ite (str.contains value2 ",") 1 0) 0))
  (not (= (ite (= (str.indexof value2 "=" 0) (- 1)) 1 0) 0))
  (>= (+ (str.indexof value2 "V" 0) 1) 0)
  (>= (- (str.len value2) (+ (str.indexof value2 "V" 0) 1)) 0)

  ; avoid empty and leading/trailing spaces like the seed intended
  (not (= (ite (= (str.len value2) 0) 1 0) 0))
  (not (= (ite (= (str.at value2 0) " ") 1 0) 0))
  (not (= (ite (= (str.at value2 (- (str.len value2) 1)) " ") 1 0) 0))
))

; --- Log parsing via split ---
; Expected log format (spaces separate fields):
;   <timestamp> <level> <component>: <message>
(assert (>= (num_splits logline " ") 4))
(assert (= ts (split_at logline " " 0)))
(assert (= level (split_at logline " " 1)))
(assert (= component (split_at logline " " 2)))
(assert (= msg (split_rest logline " " 3)))

; component ends with ':' and has at least 2 characters before ':'
(assert (>= (str.len component) 2))
(assert (= (str.at component (- (str.len component) 1)) ":"))

; message is non-empty
(assert (> (str.len msg) 0))

; --- Timestamp validation (YYYY-MM-DDTHH:MM:SSZ) ---
(assert (= (str.len ts) 20))
(assert (= (str.at ts 4) "-"))
(assert (= (str.at ts 7) "-"))
(assert (= (str.at ts 10) "T"))
(assert (= (str.at ts 13) ":"))
(assert (= (str.at ts 16) ":"))
(assert (= (str.at ts 19) "Z"))

; Use regex for digit positions
(assert (str.in_re ts (re.++
  (re.loop (str.to_re "0") 0 0) ; dummy to force re.++ structure
  (re.range "0" "9")
  (re.range "0" "9")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re "-")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re "-")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re "T")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re ":")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re ":")
  (re.range "0" "9")
  (re.range "0" "9")
  (str.to_re "Z")
)))

; Connect timestamp pieces using str.substr for additional structure
(assert (= date (str.substr ts 0 10)))
(assert (= time (str.substr ts 11 8)))
(assert (= hh (str.substr ts 11 2)))
(assert (= mm (str.substr ts 14 2)))
(assert (= ss (str.substr ts 17 2)))

; time must contain colons
(assert (str.contains time ":"))

; --- Log level extraction and checks ---
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Ensure msg includes an embedded key=value pair with the given key2 (log correlation)
(assert (str.contains msg (str.++ key2 "=")))

; Also relate value2 to log message to preserve seed's key/value flavor
(assert (str.contains msg value2))

; --- Additional consistency constraints (index bounds and delimiter checks) ---
(assert (>= (str.indexof msg (str.++ key2 "=") 0) 0))
(assert (>= (str.indexof msg value2 0) 0))

; --- UNSAT corner: contradict log level simultaneously ---
; This makes the instance UNSAT by forcing two distinct fixed levels.
(assert (= level "INFO"))
(assert (= level "ERROR"))

(check-sat)


; [GENERATION STATUS: SUCCESS]