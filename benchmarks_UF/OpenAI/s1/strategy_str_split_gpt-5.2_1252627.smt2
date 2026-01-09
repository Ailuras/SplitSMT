(set-logic ALL)

; Uninterpreted split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Log line under analysis
(declare-const X String)

; Derived fields
(declare-const ts String)
(declare-const level_with_colon String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)

; Basic structure: "<timestamp> <LEVEL>: <message>"
(assert (= ts (split_at X " " 0)))
(assert (= level_with_colon (split_at X " " 1)))
(assert (= msg (split_rest X " " 2)))
(assert (>= (num_splits X " ") 3))

; Timestamp must contain date and time separated by 'T'
(assert (= date (split_at ts "T" 0)))
(assert (= time (split_at ts "T" 1)))
(assert (= (num_splits ts "T") 2))

; Date format: YYYY-MM-DD
(assert (str.in_re date (re.++ ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")))))

; Time format: HH:MM:SSZ
(assert (str.in_re time (re.++ ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "Z"))))

; Extract log level from "LEVEL:" and validate
(assert (= level (split_at level_with_colon ":" 0)))
(assert (= (num_splits level_with_colon ":") 2))
(assert (str.in_re level (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))))

; Message constraints
(assert (> (str.len msg) 0))
(assert (not (str.contains msg "\n")))
(assert (not (str.contains msg "\r")))

; Mutated/retained flavor from seed: keep X inside a strict pattern but adapted to log-like prefix
(assert (str.in_re X
  (re.++
    ; timestamp + space
    (re.++
      (re.++
        ((_ re.loop 4 4) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "-") ((_ re.loop 2 2) (re.range "0" "9"))
      )
      (str.to_re "T")
      ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re ":") ((_ re.loop 2 2) (re.range "0" "9")) (str.to_re "Z")
    )
    (str.to_re " ")
    ; level + ": "
    (re.++
      (re.union (str.to_re "INFO") (str.to_re "WARN") (str.to_re "ERROR") (str.to_re "DEBUG"))
      (str.to_re ": ")
    )
    ; message (printable, no newlines)
    (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re " ") (str.to_re "-") (str.to_re "_") (str.to_re ".") (str.to_re "/") (str.to_re "=") (str.to_re ",") (str.to_re "(") (str.to_re ")")))
  )))

; Additional policy: disallow suspicious header injection artifacts (mutated from seed idea)
(assert (not (str.contains X "Subject:")))
(assert (not (str.contains X "User-Agent:")))

; Create an UNSAT corner by contradicting the extracted level
(assert (not (= level "INFO")))
(assert (= level "INFO"))

(check-sat)


; [GENERATION STATUS: SUCCESS]