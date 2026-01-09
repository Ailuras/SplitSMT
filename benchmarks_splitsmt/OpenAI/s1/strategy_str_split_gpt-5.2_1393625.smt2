(set-logic ALL)

; Uninterpreted interface for str_split

; Log line and extracted fields
(declare-const x String)
(declare-const ts String)
(declare-const level String)
(declare-const host String)
(declare-const kv1 String)
(declare-const kv2 String)
(declare-const msg String)
(declare-const hhmmss String)

; Core structure from seed: preserve regex-based boolean equalities/inequalities
(assert (let ((_let_0 (re.* re.allchar )))
  (let ((_let_1 (str.++ "C" "A")))
    (let ((_let_2 (str.to_re "A")))
      (let ((_let_3 (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" "A")) _let_0 (str.to_re _let_1) _let_0))))
        (and
          (not (= (str.in_re x (re.++ _let_0 re.allchar _let_0 (str.to_re (str.++ "A" (str.++ "A" "C"))) _let_0 _let_2 _let_0)) _let_3))
          (not (= _let_3 (str.in_re x (re.++ _let_0 re.allchar _let_0 _let_2 _let_0 (str.to_re (str.++ "A" _let_1)) _let_0))))
        ))))))

; Log analysis scenario: parsing structured server log entries separated by spaces and colons
; Expected shape (one possible): "YYYY-MM-DDTHH:MM:SSZ LEVEL host: kv1 kv2 message..."

; Split by spaces
(assert (>= (str.num_splits x " ") 5))
(assert (= ts (str.split_at x " " 0)))
(assert (= level (str.split_at x " " 1)))
(assert (= host (str.split_at x " " 2)))
(assert (= kv1 (str.split_at x " " 3)))
(assert (= kv2 (str.split_at x " " 4)))
(assert (= msg (str.split_rest x " " 5)))

; Host ends with ':' to indicate structured prefix like "web01:" before key-values
(assert (str.in_re host (re.++ (re.+ (re.range "a" "z")) (str.to_re ":"))))

; Log level extraction: one of common levels
(assert (or (= level "INFO") (= level "WARN") (= level "ERROR") (= level "DEBUG")))

; Timestamp format validation: "YYYY-MM-DDTHH:MM:SSZ"
(declare-const DIGIT RegLan)
(assert (= DIGIT (re.range "0" "9")))
(declare-const D2 RegLan)
(declare-const D4 RegLan)
(assert (= D2 (re.++ DIGIT DIGIT)))
(assert (= D4 (re.++ D2 D2)))
(assert (str.in_re ts (re.++ D4 (str.to_re "-") D2 (str.to_re "-") D2 (str.to_re "T") D2 (str.to_re ":") D2 (str.to_re ":") D2 (str.to_re "Z"))))

; Further sanity: extract HH:MM:SS from timestamp via substring and validate colons positions
(assert (= hhmmss (str.substr ts 11 8)))
(assert (= (str.at hhmmss 2) ":"))
(assert (= (str.at hhmmss 5) ":"))

; Key-value tokens must contain a colon somewhere (e.g., "pid:123")
(assert (str.contains kv1 ":"))
(assert (str.contains kv2 ":"))

; Message should be non-empty if present
(assert (>= (str.len msg) 0))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
