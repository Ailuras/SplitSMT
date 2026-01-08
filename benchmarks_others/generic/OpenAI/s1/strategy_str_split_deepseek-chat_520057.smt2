; HTTP Header Parsing scenario: extract key/value pairs using colon and newline; validate Content-Length
(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Header block and derived fields
(declare-const headers String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const key1 String)
(declare-const value1 String)
(declare-const key2 String)
(declare-const value2 String)
(declare-const key3 String)
(declare-const value3 String)

; Content-Length parsing
(declare-const content_length_str String)
(declare-const content_length Int)
(declare-const body String)

; Seed variables kept (core structure preserved but adapted)
(declare-const seed_key2 String)
(declare-const seed_value2 String)

; Split headers into lines
(assert (>= (num_splits headers "\r\n") 3))
(assert (= line0 (split_at headers "\r\n" 0)))
(assert (= line1 (split_at headers "\r\n" 1)))
(assert (= line2 (split_at headers "\r\n" 2)))

; Each header line splits into key/value around ": "
(assert (= key1 (split_at line0 ": " 0)))
(assert (= value1 (split_at line0 ": " 1)))
(assert (>= (num_splits line0 ": ") 2))

(assert (= key2 (split_at line1 ": " 0)))
(assert (= value2 (split_at line1 ": " 1)))
(assert (>= (num_splits line1 ": ") 2))

(assert (= key3 (split_at line2 ": " 0)))
(assert (= value3 (split_at line2 ": " 1)))
(assert (>= (num_splits line2 ": ") 2))

; Require at least one of the lines to be Content-Length
(assert (or (= key1 "Content-Length") (= key2 "Content-Length") (= key3 "Content-Length")))

; Tie content_length_str to the corresponding value
(assert (= content_length_str
           (ite (= key1 "Content-Length") value1
           (ite (= key2 "Content-Length") value2
                                     value3))))

; Basic hygiene: no newline inside a single value
(assert (not (str.contains content_length_str "\r")))
(assert (not (str.contains content_length_str "\n")))

; Content-Length must be a non-empty sequence of digits
(assert (> (str.len content_length_str) 0))
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))

; Relate integer content_length with body length (relaxation: bound consistency)
(assert (>= content_length 0))
(assert (= (str.len body) content_length))

; Cache-Control parsing constraint (mutated from seed)
; Ensure a Cache-Control line exists and contains a directive separated by comma
(assert (or (= key1 "Cache-Control") (= key2 "Cache-Control") (= key3 "Cache-Control")))
(declare-const cache_line String)
(declare-const cache_value String)
(assert (= cache_line (ite (= key1 "Cache-Control") line0 (ite (= key2 "Cache-Control") line1 line2))))
(assert (= cache_value (split_at cache_line ": " 1)))
(assert (str.contains cache_value ","))
(assert (>= (- (str.indexof cache_value "," 0) 0) 0))
(assert (>= (+ (str.indexof cache_value "," 0) 1) 0))
(assert (>= (- (str.len cache_value) (+ (str.indexof cache_value "," 0) 1)) 0))

; Seed-like constraints adapted: prefix before first comma contains either "A" or "B" and has '='
(declare-const prefix String)
(assert (= prefix (str.substr cache_value 0 (- (str.indexof cache_value "," 0) 0))))
(assert (not (= (str.len prefix) 0)))
(assert (not (= (str.indexof prefix "=" 0) (- 1))))
(assert (or (str.contains prefix "A") (str.contains prefix "B")))

; Keep original seed vars and link them to this scenario to preserve structure
(assert (= seed_key2 key2))
(assert (= seed_value2 cache_value))

; Key constraints (distinctness and typical header casing)
(assert (not (= key1 "")))
(assert (not (= key2 "")))
(assert (not (= key3 "")))
(assert (not (= key1 key2)))
(assert (not (= key2 key3)))

; ---- Additional instance (UNSAT block) ----
; Create an internal contradiction about body length vs. content_length to ensure diversity
; If content_length_str is "0" then enforce body length > 0 (inconsistent with (= (str.len body) content_length) and digit-only parsing)
(assert (=> (= content_length_str "0") (> (str.len body) 0)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
