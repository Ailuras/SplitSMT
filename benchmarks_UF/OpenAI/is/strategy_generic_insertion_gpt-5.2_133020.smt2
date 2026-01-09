(set-logic ALL)
(declare-const X String)
(assert (not (str.in_re X (re.++ (str.to_re "/.php?hgfc=") (re.+ (re.union (re.range "a" "f") (re.range "0" "9"))) (str.to_re "/U\u{a}")))))
(assert (not (str.in_re X (str.to_re "//bin.exe/U\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "Host:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Agentbody=%21%21%21Optix\u{13}\u{a}")))))

; --- START CONSTRAINT ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

(declare-const path_part String)
(declare-const query_part String)
(declare-const hgfc_val String)

(assert (>= (num_splits X "?") 1))
(assert (= path_part (split_at X "?" 0)))
(assert (= query_part (split_rest X "?" 1)))

; If there is a query part, constrain hgfc parsing: hgfc=<hex>
(assert (=> (>= (num_splits X "?") 2)
            (and (>= (num_splits query_part "hgfc=") 2)
                 (= hgfc_val (split_at query_part "hgfc=" 1))
                 (str.in_re hgfc_val (re.+ (re.union (re.range "a" "f") (re.range "0" "9")))))))
; --- END CONSTRAINT ---

(check-sat)

; [GENERATION STATUS: SUCCESS]
(exit)
