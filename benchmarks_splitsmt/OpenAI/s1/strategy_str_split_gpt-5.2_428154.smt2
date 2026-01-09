(set-logic ALL)

; CSV Processing: comma-separated fields, field count, and empty field detection

; Uninterpreted split interface

; Primary CSV line
(declare-const x String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const rest1 String)
(declare-const rest2 String)

; Secondary CSV line to create an UNSAT sub-instance
(declare-const y String)
(declare-const y0 String)
(declare-const y1 String)
(declare-const y2 String)

(assert (= delim ","))

; Core structure preserved: nested let with regex membership relations (mutated to CSV-oriented patterns)
(assert
  (let ((_let_0 (re.* re.allchar)))
    (let ((_let_1 (str.to_re delim)))
      (let ((_let_2 (re.++ _let_0 _let_1 _let_0 _let_1 _let_0)))
        (let ((_let_3 (str.in_re x _let_2)))
          (and
            ; must contain at least two commas (>= 3 fields)
            _let_3
            ; ensure it is not the case that x matches a pattern with exactly one comma
            (not (= (str.in_re x (re.++ _let_0 _let_1 _let_0)) _let_3))
            ; ensure it is not trivially empty (some non-comma character exists somewhere)
            (str.in_re x (re.++ _let_0 (re.union (str.to_re "A") (str.to_re "B")) _let_0))
          ))))))

; Split-based CSV constraints: three fields expected
(assert (>= (str.num_splits x delim) 3))
(assert (= f0 (str.split_at x delim 0)))
(assert (= f1 (str.split_at x delim 1)))
(assert (= f2 (str.split_at x delim 2)))
(assert (= rest1 (str.split_rest x delim 1)))
(assert (= rest2 (str.split_rest x delim 2)))

; Field bounds and empty-field detection
(assert (and (>= (str.len f0) 0) (>= (str.len f1) 0) (>= (str.len f2) 0)))
(assert (or (= f0 "") (= f1 "") (= f2 "")))

; Light sanity: first field is not containing a comma (best-effort constraint)
(assert (not (str.contains f0 delim)))

; A separate UNSAT instance: y is declared to have 3 splits but also constrained to have no commas
(assert (= (str.num_splits y delim) 3))
(assert (not (str.contains y delim)))
(assert (= y0 (str.split_at y delim 0)))
(assert (= y1 (str.split_at y delim 1)))
(assert (= y2 (str.split_at y delim 2)))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
