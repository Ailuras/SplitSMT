(set-logic ALL)

; CSV Processing scenario: ensure correct field counts and detect empty fields

; str_split interface operations

; Variables
(declare-const X String)
(declare-const csv String)
(declare-const delim String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const tail1 String)
(declare-const emptyField Bool)
(declare-const hasHeader Bool)
(declare-const idx0 Int)
(declare-const idx1 Int)
(declare-const idx2 Int)

; Keep core structure from seed: X matches a specific numeric-ish line ending with newline
(assert (str.in_re X
  (re.++
    (re.opt (re.union (str.to_re "E") (str.to_re "V")))
    ((_ re.loop 3 3) (re.range "0" "9"))
    (re.opt (re.++ (str.to_re ".") ((_ re.loop 1 2) (re.range "0" "9"))))
    (str.to_re "\u{a}"))))

; Keep seed-style exclusions (harmless in CSV context; treated as forbidden exact strings)
(assert (not (str.in_re X (str.to_re "User-Agent:User-Agent:\u{a}"))))
(assert (not (str.in_re X (str.to_re "User-Agent:Host:passwordhavewww.alfacleaner.com\u{a}"))))
(assert (not (str.in_re X (str.to_re "XPPreUser-Agent:RemoteYOURsqlStarLoggerclvompycem/cen.vcn\u{a}"))))
(assert (not (str.in_re X
  (re.++
    ((_ re.loop 5 5)
      (re.++
        ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "a" "f") (re.range "A" "F")))
        (str.to_re ":")))
    ((_ re.loop 2 2) (re.union (re.range "0" "9") (re.range "a" "f") (re.range "A" "F")))
    (str.to_re "\u{a}")))))

; CSV-specific constraints
(assert (= delim ","))

; Construct a CSV row by prefixing X with a header and adding two more fields
; Example shape: "ID,<X>,42,"
(assert (= csv (str.++ "ID" delim X delim "42" delim "")))

; Require 4 fields (3 commas => 4 segments)
(assert (= (str.num_splits csv delim) 4))

; Index bounds for split_at/split_rest usage (natural and within segment range)
(assert (= idx0 0))
(assert (= idx1 1))
(assert (= idx2 2))
(assert (>= idx0 0))
(assert (>= idx1 0))
(assert (>= idx2 0))
(assert (< idx0 (str.num_splits csv delim)))
(assert (< idx1 (str.num_splits csv delim)))
(assert (< idx2 (str.num_splits csv delim)))

; Extract fields
(assert (= f0 (str.split_at csv delim idx0)))
(assert (= f1 (str.split_at csv delim idx1)))
(assert (= f2 (str.split_at csv delim idx2)))
(assert (= tail1 (str.split_rest csv delim 1)))

; Header detection and constraints
(assert (= hasHeader (= f0 "ID")))
(assert hasHeader)

; The second field is exactly X (after header)
(assert (= f1 X))

; Field 3 must be numeric and equal to "42"
(assert (= f2 "42"))

; Detect empty fields: the last field is empty because csv ends with a delimiter
(assert (= emptyField (= (str.split_at csv delim 3) "")))
(assert emptyField)

; Additional CSV sanity: exactly one empty field (force other fields non-empty)
(assert (not (= f0 "")))
(assert (not (= f1 "")))
(assert (not (= f2 "")))

; Ensure the remainder after field 1 starts with X and a comma (structure check)
(assert (str.prefixof (str.++ X delim) tail1))

; UNSAT branch: contradictory requirement that there are no empty fields
; This forces UNSAT while preserving core structure and CSV constraints
(assert (forall ((k Int))
  (=> (and (>= k 0) (< k (str.num_splits csv delim)))
      (not (= (str.split_at csv delim k) "")))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
