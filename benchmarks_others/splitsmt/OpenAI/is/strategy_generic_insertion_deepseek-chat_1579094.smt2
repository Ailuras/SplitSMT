(set-logic ALL)
(declare-const X String)
(assert (str.in_re X (re.++ (str.to_re "{") ((_ re.loop 8 8) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 4 4) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "-") ((_ re.loop 12 12) (re.union (re.range "a" "f") (re.range "A" "F") (re.range "0" "9"))) (str.to_re "}\u{a}"))))

; --- START CONSTRAINT ---

(declare-const uuid_body String)
(declare-const line_after_uuid String)

; X ends with "}\n" so splitting by "}\n" yields exactly 2 segments: body-with-leading-{ and empty tail
(assert (= (str.num_splits X "}\n") 2))
(assert (= (str.split_at X "}\n" 1) ""))
(assert (= line_after_uuid (str.split_rest X "}\n" 1)))
(assert (= line_after_uuid ""))

; isolate the part before the final "}\n" and constrain its expected structure "{" + 8-4-4-4-12 hex
(assert (= uuid_body (str.split_at X "}\n" 0)))
(assert (= (str.num_splits uuid_body "-") 5))
(assert (= (str.split_at uuid_body "-" 0) (str.++ "{" (str.split_at uuid_body "-" 0))))
(assert (= (str.len (str.split_at uuid_body "-" 0)) 9))
(assert (= (str.len (str.split_at uuid_body "-" 1)) 4))
(assert (= (str.len (str.split_at uuid_body "-" 2)) 4))
(assert (= (str.len (str.split_at uuid_body "-" 3)) 4))
(assert (= (str.len (str.split_at uuid_body "-" 4)) 12))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
