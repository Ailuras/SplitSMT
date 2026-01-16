(set-logic ALL)

; Uninterpreted interface for CSV splitting

; Seed variable preserved
(declare-const var0 String)

; CSV scenario variables
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const f4 String)
(declare-const rest2 String)
(declare-const n Int)

; Mutated seed regex constraint kept as a background constraint on var0
(assert (str.in_re var0
  (re.++
    (re.+ (re.* (str.to_re "000")))
    (re.++
      (re.union (re.* (str.to_re "1")) (re.+ (str.to_re "2")))
      (re.++
        (re.+ (re.+ (str.to_re "3")))
        (re.++
          (re.union (re.+ (str.to_re "444")) (re.union (str.to_re "55") (str.to_re "6")))
          (re.++
            (re.* (re.* (str.to_re "77")))
            (re.++
              (re.* (re.+ (str.to_re "8")))
              (re.++
                (re.+ (re.union (str.to_re "9") (str.to_re "a")))
                (re.++
                  (re.+ (re.+ (str.to_re "bbb")))
                  (re.++
                    (re.union (re.union (str.to_re "c") (str.to_re "d")) (re.union (str.to_re "eee") (str.to_re "ff")))
                    (re.++ (re.* (str.to_re "ggg")) (re.* (str.to_re "ggg"))))))))))))))
(assert (<= 240 (str.len var0)))

; Core CSV constraints
(assert (= delim ","))
(assert (= csv (str.split_rest var0 delim 0)))
(assert (>= (str.len csv) 10))

; Split fields using the str_split interface
(assert (= f0 (str.split_at csv delim 0)))
(assert (= f1 (str.split_at csv delim 1)))
(assert (= f2 (str.split_at csv delim 2)))
(assert (= f3 (str.split_at csv delim 3)))
(assert (= f4 (str.split_at csv delim 4)))
(assert (= rest2 (str.split_rest csv delim 2)))
(assert (= n (str.num_splits csv delim)))

; Field count constraints (expect at least 5 fields)
(assert (>= n 5))

; Detect empty fields: enforce that field 2 is empty and field 3 is non-empty
(assert (= f2 ""))
(assert (> (str.len f3) 0))

; Additional sanity constraints often used in CSV processing
; - delimiter not allowed inside fields 0 and 3
(assert (not (str.contains f0 delim)))
(assert (not (str.contains f3 delim)))

; rest2 should contain at least two delimiters if there are >=5 fields (heuristic check)
(assert (str.contains rest2 delim))

; SAT instance: make an explicit consistent shape for the CSV content
(assert (= csv (str.++ f0 "," f1 "," f2 "," f3 "," f4)))
(assert (= f0 "ID"))
(assert (= f1 "42"))
(assert (= f3 "OK"))
(assert (= f4 "END"))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
