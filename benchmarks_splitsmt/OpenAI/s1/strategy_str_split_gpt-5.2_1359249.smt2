(set-logic ALL)

; === Uninterpreted interface for str_split ===

; === Core input and derived CSV fields ===
(declare-const X String)
(declare-const csv String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)

; === Mutated seed-style regex constraints kept as "noise" structure ===
(assert (not (str.in_re X
  (re.++
    (re.union (str.to_re "<") (str.to_re ">") (str.to_re "&") (str.to_re "~") (str.to_re "^") (str.to_re "%")
              (re.range "A" "Z") (re.range "a" "z") (str.to_re "\\") (str.to_re " ")
              (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))
    ((_ re.loop 1 25)
      (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re "%") (str.to_re "^") (str.to_re "\\") (str.to_re "<") (str.to_re ">")))
    (str.to_re "\u{a}")))))
(assert (not (str.in_re X (str.to_re "ProjectMyWebSearchSearchAssistantfast-look.comOneReporter\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".f4v/i\u{a}")))))
(assert (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.range "0" "9")) (str.to_re "Host:") (re.* re.allchar) (str.to_re "communitytipHost:GirafaClient\u{13}\u{a}"))))

; === Scenario: CSV Processing ===
; X is the raw CSV record (reuse X as csv input)
(assert (= csv X))

; Require exactly 4 fields separated by commas => num_splits = 4
(assert (= (str.num_splits csv ",") 4))

; Bind each field via split_at
(assert (= f0 (str.split_at csv "," 0)))
(assert (= f1 (str.split_at csv "," 1)))
(assert (= f2 (str.split_at csv "," 2)))
(assert (= f3 (str.split_at csv "," 3)))

; Structural relation with split_rest
(assert (= (str.split_rest csv "," 0) csv))
(assert (= (str.split_rest csv "," 1) (str.++ f1 "," f2 "," f3)))
(assert (= (str.split_rest csv "," 2) (str.++ f2 "," f3)))
(assert (= (str.split_rest csv "," 3) f3))

; Detect empty fields: enforce at least one empty field exists
(assert (or (= f0 "") (= f1 "") (= f2 "") (= f3 "")))

; Also enforce field-count sanity via comma counting: if 4 fields then at least 3 commas
(assert (>= (str.len csv) 3))
(assert (str.contains csv ","))

; Disallow newlines in CSV record
(assert (not (str.contains csv "\n")))
(assert (not (str.contains csv "\r")))

; Some content constraints typical for CSV processing
; f0 is an integer ID (digits only, non-empty)
(assert (str.in_re f0 (re.+ (re.range "0" "9"))))

; f1 is a name: letters and spaces only (may be empty in this instance)
(assert (str.in_re f1 (re.* (re.union (re.range "A" "Z") (re.range "a" "z") (str.to_re " ")))))

; f2 is an amount like 12 or 12.34 (may be empty in this instance)
(declare-const dot String)
(assert (= dot "."))
(assert (or (= f2 "")
            (str.in_re f2 (re.++ (re.+ (re.range "0" "9")) (re.opt (re.++ (str.to_re ".") ((_ re.loop 2 2) (re.range "0" "9"))))))))

; f3 is a status token (must be one of OK/ERR/NA; may be empty in this instance)
(assert (or (= f3 "") (= f3 "OK") (= f3 "ERR") (= f3 "NA")))

; === UNSAT slice: force contradiction about emptiness ===
; Require no empty fields, while previously requiring at least one empty field.
(assert (and (not (= f0 "")) (not (= f1 "")) (not (= f2 "")) (not (= f3 ""))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
