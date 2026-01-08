(set-logic ALL)

; Uninterpreted split interface for email validation

; Mutated/extended seed-style declarations
(declare-fun I0_6 () Int)
(declare-fun PCTEMP_LHS_1 () String)
(declare-fun PCTEMP_LHS_2 () Int)
(declare-fun T0_6 () String)
(declare-fun T1_11 () String)
(declare-fun T1_12 () String)
(declare-fun T1_5 () String)
(declare-fun T1_6 () String)
(declare-fun T2_11 () String)
(declare-fun T2_12 () String)
(declare-fun T2_5 () String)
(declare-fun T2_6 () String)
(declare-fun T3_6 () String)
(declare-fun T4_6 () String)
(declare-fun T5_6 () String)
(declare-fun T_2 () String)
(declare-fun T_4 () Bool)
(declare-fun T_5 () String)
(declare-fun T_6 () String)
(declare-fun T_SELECT_1 () Bool)

; Email-specific auxiliaries
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const subdomain String)
(declare-const tld String)
(declare-const firstLabel String)
(declare-const restAfterAt String)
(declare-const restAfterFirstDot String)
(declare-const satFlag Bool)

; Keep a core seed-like structure but pivot to email content
(assert (= PCTEMP_LHS_1 email))
(assert (= T1_5 PCTEMP_LHS_1))
(assert (= T2_5 ""))
(assert (= T_2 (str.++ T1_5 T2_5)))

; Basic email must contain '@' exactly once: num_splits by '@' is 2 segments
(assert (= (str.num_splits email "@") 2))
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (= restAfterAt (str.split_rest email "@" 1)))
(assert (= restAfterAt domain))

; Local-part constraints: non-empty, no spaces, no consecutive dots, cannot start/end with '.'
(assert (> (str.len local) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "..")))
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))

; Domain constraints: must contain dots, no spaces, no consecutive dots, cannot start/end with '.'
(assert (> (str.len domain) 0))
(assert (not (str.contains domain " ")))
(assert (not (str.contains domain "..")))
(assert (not (= (str.at domain 0) ".")))
(assert (not (= (str.at domain (- (str.len domain) 1)) ".")))
(assert (>= (str.num_splits domain ".") 2))

; Structure: first label and remainder after first dot
(assert (= firstLabel (str.split_at domain "." 0)))
(assert (= restAfterFirstDot (str.split_rest domain "." 1)))
(assert (> (str.len firstLabel) 0))
(assert (> (str.len restAfterFirstDot) 0))

; TLD: take last segment by constraining at least two segments and focusing on segment 1 when exactly two
(assert (>= (str.num_splits domain ".") 2))

; Encode a seed-like conditional selection using PCTEMP_LHS_2, but now for '@' position segment index check
(assert (= T_SELECT_1 (not (= PCTEMP_LHS_2 (- 1)))))
(assert (ite T_SELECT_1
  (and
    (= PCTEMP_LHS_2 (+ I0_6 0))
    (= I0_6 (str.len T4_6))
    (= 0 (str.len T0_6))
    (= T_2 (str.++ T0_6 T1_6))
    (= T1_6 (str.++ T2_6 T3_6))
    (= T2_6 (str.++ T4_6 T5_6))
    (= T5_6 "@"); pivot from "//" to "@"
    (not (str.contains T4_6 "@")))
  (and
    (= PCTEMP_LHS_2 (- 1))
    (= T_2 (str.++ T0_6 T1_6))
    (= 0 (str.len T0_6))
    (not (str.contains T1_6 "@")))))

; Force selection to the first segment around '@'
(assert (= T_4 (= PCTEMP_LHS_2 0)))
(assert T_4)

; Tie the seed-style concatenation chain to email pieces
(assert (= T_5 (str.++ T1_11 T2_11)))
(assert (= T1_11 local))
(assert (= T2_11 (str.++ "@" domain)))
(assert (= T_6 (str.++ T1_12 T2_12)))
(assert (= T1_12 "mailto:"))
(assert (= T2_12 T_5))

; More domain structure: subdomain and tld for exactly two labels, otherwise keep consistent pieces
(assert (=> (= (str.num_splits domain ".") 2)
  (and
    (= subdomain (str.split_at domain "." 0))
    (= tld (str.split_at domain "." 1))
    (> (str.len subdomain) 0)
    (> (str.len tld) 1)
    (<= (str.len tld) 24)
    (not (str.contains tld "-"))
  )))

; SAT/UNSAT diversity within one file: constrain satFlag to allow a satisfiable branch
; The UNSAT branch forces contradictory requirements on tld length.
(assert (or satFlag (not satFlag)))
(assert (ite satFlag
  (and
    (= email "alice.smith@dept.example")
    (= (str.num_splits "dept.example" ".") 2))
  (and
    (= email "bob@x.y")
    (= (str.num_splits "x.y" ".") 2)
    (= tld (str.split_at "x.y" "." 1))
    (> (str.len tld) 5)
    (< (str.len tld) 2))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
