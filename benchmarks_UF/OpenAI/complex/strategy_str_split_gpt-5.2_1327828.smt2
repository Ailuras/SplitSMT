(set-logic ALL)

; Scenario: CSV Processing
; Goal: enforce correct field counts and detect empty fields using split_at/num_splits/split_rest

(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3 String)
(declare-const tail_from2 String)
(declare-const has_empty Bool)
(declare-const idx2 Int)

; delimiter is comma for CSV
(assert (= delim ","))

; At least 4 fields => num_splits >= 4 (segments count)
(assert (>= (num_splits csv_line delim) 4))

; Constrain index used with split_rest to be natural and in-range
(assert (= idx2 2))
(assert (>= idx2 0))
(assert (< idx2 (num_splits csv_line delim)))

; Extract the first four fields
(assert (= field0 (split_at csv_line delim 0)))
(assert (= field1 (split_at csv_line delim 1)))
(assert (= field2 (split_at csv_line delim 2)))
(assert (= field3 (split_at csv_line delim 3)))

; Tail from field2 onwards (field2,field3,...) as a single CSV suffix
(assert (= tail_from2 (split_rest csv_line delim idx2)))

; Core structural constraint: the tail should start with field2 and a comma (since there is at least field3)
(assert (str.prefixof (str.++ field2 delim) tail_from2))

; Detect empty fields among the first four
(assert (= has_empty (or (= field0 "") (= field1 "") (= field2 "") (= field3 ""))))

; Require existence of at least one empty field (to "detect empty fields")
(assert has_empty)

; Also enforce that at least one of the first four fields is non-empty (avoid all-empty degenerate case)
(assert (or (not (= field0 "")) (not (= field1 "")) (not (= field2 "")) (not (= field3 ""))))

; CSV sanity: no newline characters in the line
(assert (not (str.contains csv_line "\n")))
(assert (not (str.contains csv_line "\r")))

; Keep a mutated fragment of the seed regex constraint as a side condition on csv_line
; Ensure csv_line is not in a particular complex regex (arbitrary blacklist)
(assert (not (str.in_re csv_line
  (re.++
    (str.to_re ".\u{a}")
    ((_ re.loop 2 3) (re.range "a" "z"))
    (re.* (re.++ (str.to_re ".")
                 (re.union (re.range "a" "z") (re.range "A" "Z"))
                 (re.* (re.union (re.range "a" "z")
                                 (re.range "A" "Z")
                                 (str.to_re "_")
                                 (str.to_re "$")
                                 (re.range "0" "9")))))
    (re.range "A" "Z")
    (re.* (re.union (re.range "a" "z")
                    (re.range "A" "Z")
                    (str.to_re "_")
                    (str.to_re "$")
                    (re.range "0" "9")))))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
