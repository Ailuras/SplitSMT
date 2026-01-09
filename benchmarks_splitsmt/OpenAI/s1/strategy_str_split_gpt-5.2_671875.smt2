(set-logic ALL)

; Scenario: CSV Processing
; Goal: reason about comma-separated fields, ensure correct field counts, and detect empty fields.

; --- split interface (uninterpreted) ---

; --- seed vars preserved ---
(declare-const var_9 String)
(declare-const var_10 String)

; --- additional CSV vars ---
(declare-const csv_line String)
(declare-const delim String)
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const rest2 String)
(declare-const empty_field String)

; delimiter is comma
(assert (= delim ","))

; --- Seed-derived regex constraints (mutated but structurally similar) ---
(assert (str.in_re (str.++ var_9 "z" "b" var_10)
  (re.++
    (re.* (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c"))))
    (re.union
      (str.to_re "")
      (re.++ (str.to_re "b") (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c")))))
    ))))

; Make var_10 compatible with an alphabetic segment (slightly relaxed from seed)
(assert (str.in_re (str.++ "b" var_10) (re.* (re.range "a" "u"))))
(assert (str.in_re var_9 (re.* (re.range "a" "u"))))

; Keep a negated membership constraint to preserve core structure
(assert (not (str.in_re (str.++ var_9 "a" "z" var_10)
  (re.++
    (re.*
      (re.++
        (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c")))
        (re.++
          (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c"))))
          (str.to_re "z"))))
    (re.++
      (re.union (str.to_re "z") (re.union (str.to_re "a") (str.to_re "c")))
      (re.* (re.union (str.to_re "b") (re.union (str.to_re "a") (str.to_re "c")))))))))

; --- CSV construction tying seed vars into a CSV line ---
; csv_line = var_9 , var_10 , ""
(assert (= empty_field ""))
(assert (= csv_line (str.++ var_9 delim var_10 delim empty_field)))

; split interface usage
(assert (= field0 (str.split_at csv_line delim 0)))
(assert (= field1 (str.split_at csv_line delim 1)))
(assert (= field2 (str.split_at csv_line delim 2)))
(assert (= rest2  (str.split_rest csv_line delim 2)))

; correct field count: exactly 3 segments
(assert (= (str.num_splits csv_line delim) 3))

; extracted fields match the construction
(assert (= field0 var_9))
(assert (= field1 var_10))
(assert (= field2 empty_field))

; detect empty fields: ensure the 3rd field is empty, while the 1st two are non-empty
(assert (= (str.len field2) 0))
(assert (> (str.len field0) 0))
(assert (> (str.len field1) 0))

; sanity: no commas inside var_9 and var_10 (typical CSV unquoted fields)
(assert (not (str.contains var_9 delim)))
(assert (not (str.contains var_10 delim)))

; --- Additional constraints for processing consistency ---
; rest2 should equal the final field for a 3-field CSV
(assert (= rest2 field2))

; --- UNSAT pocket (guarded by a contradiction on purpose) ---
; This makes the whole instance UNSAT while preserving CSV structure.
; Empty field cannot also have positive length.
(assert (> (str.len field2) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
