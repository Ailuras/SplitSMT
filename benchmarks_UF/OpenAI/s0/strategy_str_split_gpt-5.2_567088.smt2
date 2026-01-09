(set-logic ALL)

; Uninterpreted functions for str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; =====================
; SAT instance: well-formed CSV with 4 fields, no empty fields
; =====================
(declare-const csv_line_ok String)
(declare-const f0_ok String)
(declare-const f1_ok String)
(declare-const f2_ok String)
(declare-const f3_ok String)

(assert (= csv_line_ok "alpha,beta,gamma,delta"))
(assert (= (num_splits csv_line_ok ",") 4))
(assert (= f0_ok (split_at csv_line_ok "," 0)))
(assert (= f1_ok (split_at csv_line_ok "," 1)))
(assert (= f2_ok (split_at csv_line_ok "," 2)))
(assert (= f3_ok (split_at csv_line_ok "," 3)))

; indices are natural
(assert (>= 0 0))
(assert (>= 1 0))
(assert (>= 2 0))
(assert (>= 3 0))

; no empty fields
(assert (> (str.len f0_ok) 0))
(assert (> (str.len f1_ok) 0))
(assert (> (str.len f2_ok) 0))
(assert (> (str.len f3_ok) 0))

; basic content sanity
(assert (str.contains csv_line_ok ","))
(assert (not (str.contains f0_ok ",")))
(assert (not (str.contains f1_ok ",")))
(assert (not (str.contains f2_ok ",")))
(assert (not (str.contains f3_ok ",")))

; rest reconstruction checks (interface-style usage)
(declare-const rest1_ok String)
(declare-const rest2_ok String)
(assert (= rest1_ok (split_rest csv_line_ok "," 1)))
(assert (= rest2_ok (split_rest csv_line_ok "," 2)))
(assert (str.contains rest1_ok "beta"))
(assert (str.contains rest2_ok "gamma"))

; =====================
; SAT instance: detect empty field due to consecutive commas
; =====================
(declare-const csv_line_empty String)
(declare-const e0 String)
(declare-const e1 String)
(declare-const e2 String)

(assert (= csv_line_empty "a,,c"))
(assert (= (num_splits csv_line_empty ",") 3))
(assert (= e0 (split_at csv_line_empty "," 0)))
(assert (= e1 (split_at csv_line_empty "," 1)))
(assert (= e2 (split_at csv_line_empty "," 2)))

; empty middle field should be detectable
(assert (= e0 "a"))
(assert (= e2 "c"))
(assert (= (str.len e1) 0))

; =====================
; UNSAT instance: impossible requirement (both empty and non-empty)
; =====================
(declare-const csv_line_bad String)
(declare-const b0 String)
(declare-const b1 String)
(declare-const b2 String)

(assert (= csv_line_bad "x,,z"))
(assert (= (num_splits csv_line_bad ",") 3))
(assert (= b0 (split_at csv_line_bad "," 0)))
(assert (= b1 (split_at csv_line_bad "," 1)))
(assert (= b2 (split_at csv_line_bad "," 2)))

; Contradiction on the empty field
(assert (= (str.len b1) 0))
(assert (> (str.len b1) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]