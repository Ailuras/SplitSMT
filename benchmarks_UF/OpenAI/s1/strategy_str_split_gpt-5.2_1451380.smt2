(set-logic ALL)

; CSV Processing scenario: comma-separated fields, field count, and empty-field detection

; str_split interface (uninterpreted)
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const X String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest2 String)
(declare-const hasEmpty Bool)

; Preserve core seed structure (negated membership in a literal regex)
(assert (not (str.in_re X (str.to_re "richfind.comdcww.dmcast.com\u{a}"))))

; CSV delimiter is a comma
(assert (= delim ","))

; Require at least 3 fields
(assert (>= (num_splits X delim) 3))

; Extract first three fields and the remaining tail
(assert (= f0 (split_at X delim 0)))
(assert (= f1 (split_at X delim 1)))
(assert (= f2 (split_at X delim 2)))
(assert (= rest2 (split_rest X delim 2)))

; Field sanity: f0 must be non-empty, f1 must be numeric only, f2 is allowed empty
(assert (> (str.len f0) 0))
(assert (str.in_re f1 (re.* (re.range "0" "9"))))

; Detect empty fields among first three
(assert (= hasEmpty (or (= f0 "") (= f1 "") (= f2 ""))))
(assert hasEmpty)

; Constructive constraints to force an empty second field, while keeping f1 numeric -> UNSAT
(assert (= f1 ""))

(check-sat)


; [GENERATION STATUS: SUCCESS]