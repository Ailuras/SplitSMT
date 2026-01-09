(set-logic ALL)

; Uninterpreted functions for str_split interface

; -------------------------------
; SAT instance: CSV line with 4 fields, no empty fields, specific patterns
; -------------------------------
(declare-const csv_line_sat String)
(declare-const comma String)
(declare-const f0 String)
(declare-const f1 String)
(declare-const f2 String)
(declare-const f3 String)
(declare-const tail_from_2 String)
(declare-const idx_nonneg Int)

(assert (= comma ","))
(assert (= f0 (str.split_at csv_line_sat comma 0)))
(assert (= f1 (str.split_at csv_line_sat comma 1)))
(assert (= f2 (str.split_at csv_line_sat comma 2)))
(assert (= f3 (str.split_at csv_line_sat comma 3)))
(assert (= tail_from_2 (str.split_rest csv_line_sat comma 2)))

; Exactly 4 segments total
(assert (= (str.num_splits csv_line_sat comma) 4))

; No empty fields
(assert (> (str.len f0) 0))
(assert (> (str.len f1) 0))
(assert (> (str.len f2) 0))
(assert (> (str.len f3) 0))

; Field content constraints (typical CSV processing checks)
; f0: uppercase alphabetic code length 3
(assert (= (str.len f0) 3))
(assert (str.in_re f0 (re.++ (re.range "A" "Z") (re.++ (re.range "A" "Z") (re.range "A" "Z")))))

; f1: integer (optional leading '-') and at least 1 digit
(assert (str.in_re f1 (re.++ (re.opt (str.to_re "-")) (re.+ (re.range "0" "9")))))

; f2: email-like token without comma: [a-z]+ '@' [a-z]+ '.' [a-z]+
(assert (str.in_re f2 (re.++ (re.+ (re.range "a" "z"))
                            (re.++ (str.to_re "@")
                                  (re.++ (re.+ (re.range "a" "z"))
                                        (re.++ (str.to_re ".") (re.+ (re.range "a" "z"))))))))

; f3: non-empty, no commas (approximate by forbidding contains ",")
(assert (not (str.contains f3 comma)))

; Structural reconstruction (typical CSV: f0,f1,f2,f3)
(assert (= csv_line_sat (str.++ f0 (str.++ comma (str.++ f1 (str.++ comma (str.++ f2 (str.++ comma f3))))))))

; Consistency with split_rest: tail_from_2 should match f2,f3
(assert (= tail_from_2 (str.++ f2 (str.++ comma f3))))

; Index discipline example (natural integer)
(assert (>= idx_nonneg 0))
(assert (< idx_nonneg (str.len csv_line_sat)))

(check-sat)

; -------------------------------
; UNSAT instance: demand 4 fields but also require an empty field while forbidding empties
; Detect empty fields via split_at = ""
; -------------------------------
(declare-const csv_line_unsat String)
(declare-const u0 String)
(declare-const u1 String)
(declare-const u2 String)
(declare-const u3 String)

(assert (= u0 (str.split_at csv_line_unsat comma 0)))
(assert (= u1 (str.split_at csv_line_unsat comma 1)))
(assert (= u2 (str.split_at csv_line_unsat comma 2)))
(assert (= u3 (str.split_at csv_line_unsat comma 3)))
(assert (= (str.num_splits csv_line_unsat comma) 4))

; Forbid empty fields
(assert (> (str.len u0) 0))
(assert (> (str.len u1) 0))
(assert (> (str.len u2) 0))
(assert (> (str.len u3) 0))

; But also require an empty second field (classic consecutive commas like "a,,b,c")
(assert (= u1 ""))

(check-sat)
(exit)
