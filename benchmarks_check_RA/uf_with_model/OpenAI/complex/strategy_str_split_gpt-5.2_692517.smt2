(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Scenario: CSV Processing
; Goal: reason about comma-separated fields, field counts, and empty fields.

; Uninterpreted interface operations (as required)

; Core inputs
(declare-const X String)
(declare-const csv String)
(declare-const delim String)

; Derived fields
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; Basic setup
(assert (= delim ","))
(assert (= csv X))

; Preserve mutated core structure: keep the original negative regex checks on X
(assert (not (str.in_re X (re.++ (str.to_re "wowokay") (re.+ (re.range "0" "9")) (str.to_re "FTP") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Host:Filtered\u{22}reaction.txt\u{22}\u{a}")))))
(assert (not (str.in_re X (str.to_re "clvompycem/cen.vcnHost:User-Agent:\u{d}\u{a}\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".jfif/i\u{a}")))))

; CSV constraints: ensure correct field counts and detect empty fields
(assert (>= (str.len csv) 0))
(assert (>= (num_splits csv delim) 1))

; Tie split interface to named fields
(assert (= f0 (split_at csv delim 0)))
(assert (= f1 (split_at csv delim 1)))
(assert (= f2 (split_at csv delim 2)))
(assert (= f3 (split_at csv delim 3)))

; Force exactly 4 fields (3 commas)
(assert (= (num_splits csv delim) 4))

; Ensure CSV has no newlines (typical single-line record)
(assert (not (str.contains csv "\u{a}")))
(assert (not (str.contains csv "\u{d}")))

; Detect empty fields: require at least one empty field among the first four
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Also require at least one non-empty field (avoid all-empty degenerate row like ",,,")
(assert (or (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

; Simple content restrictions on specific fields to mimic CSV validation
; f0 is an ID: must be digits only and non-empty if present
(assert (=> (not (= f0 "")) (str.in_re f0 (re.+ (re.range "0" "9")))))

; f1 is a name-like token: cannot contain commas
(assert (not (str.contains f1 delim)))

; f2 is a flag: either "Y" or "N" if non-empty
(assert (=> (not (= f2 "")) (or (= f2 "Y") (= f2 "N"))))

; f3 is a comment: may contain spaces, but cannot contain commas (since split is on commas)
(assert (not (str.contains f3 delim)))

; Additional shape constraint using split_rest: concatenation from field 2 onward should not be empty
(assert (not (= (split_rest csv delim 2) "")))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(get-model)
(exit)
