; Scenario: HTTP Header Parsing (mutated/extended from seed)
(set-logic ALL)

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Header block and parsed components ---
(declare-const headers String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const key0 String)
(declare-const val0 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const key2 String)
(declare-const val2 String)

; Content-Length validation
(declare-const content_length_str String)
(declare-const content_length Int)

; --- Core structure: colon and newline separated key-value pairs ---
(assert (= line0 (split_at headers "\n" 0)))
(assert (= line1 (split_at headers "\n" 1)))
(assert (= line2 (split_at headers "\n" 2)))
(assert (>= (num_splits headers "\n") 3))

(assert (= key0 (split_at line0 ":" 0)))
(assert (= val0 (split_at line0 ":" 1)))
(assert (= key1 (split_at line1 ":" 0)))
(assert (= val1 (split_at line1 ":" 1)))
(assert (= key2 (split_at line2 ":" 0)))
(assert (= val2 (split_at line2 ":" 1)))

; Ensure these are key:value lines (at least two segments when split by colon)
(assert (>= (num_splits line0 ":") 2))
(assert (>= (num_splits line1 ":") 2))
(assert (>= (num_splits line2 ":") 2))

; --- Mutated concrete header shape from the seed, but extended to a full HTTP-like header block ---
; Equivalent concrete block with explicit newlines and key:value structure
(assert (= headers (str.++ "Host:youRoot" "\n" "Referer:onBeta" "\n" "Content-Length:5" "\n")))

; Specific extraction constraints
(assert (= key0 "Host"))
(assert (= val0 "youRoot"))
(assert (= key1 "Referer"))
(assert (= val1 "onBeta"))
(assert (= key2 "Content-Length"))
(assert (= content_length_str val2))

; --- Content-Length must be digits and parse to an integer ---
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))
(assert (= content_length 5))

; Additional basic sanity constraints typical for header parsing
(assert (not (str.contains key0 "\n")))
(assert (not (str.contains key1 "\n")))
(assert (not (str.contains key2 "\n")))
(assert (> (str.len val2) 0))

; --- UNSAT branch to ensure diversity: conflicting Content-Length requirement ---
; The parsed string is "5" and content_length is forced to 5 above, but here we require 6.
(assert (= content_length 6))

(check-sat)


; [GENERATION STATUS: SUCCESS]