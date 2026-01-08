(set-logic ALL)

; Scenario: Email Validation with split_at/num_splits/split_rest

; --- Uninterpreted split interface ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Inputs / parts ---
(declare-const X String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const label0 String)
(declare-const label1 String)

; --- Preserve core structure: keep seed-style negative regex constraints ---
(assert (not (str.in_re X (re.++ (str.to_re "NSIS_DOWNLOAD") (re.* re.allchar) (str.to_re "User-Agent:") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "gpstool.globaladserver.com\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "*PORT3*") (re.+ (re.union (str.to_re " ") (str.to_re "\u{9}") (str.to_re "\u{a}") (str.to_re "\u{c}") (str.to_re "\u{d}"))) (str.to_re "Warezxmlns:%3flinkautomatici.com\u{a}")))))
(assert (not (str.in_re X (re.++ (re.union (re.++ (str.to_re "4915") (re.range "0" "1")) (re.++ (str.to_re "491") (re.range "0" "4") (re.range "0" "9")) (re.++ (str.to_re "490") (re.range "0" "9") (re.range "0" "9")) (re.++ (str.to_re "4") (re.range "0" "8") ((_ re.loop 3 3) (re.range "0" "9"))) (re.++ (re.range "1" "3") ((_ re.loop 4 4) (re.range "0" "9"))) (re.++ (re.range "1" "9") ((_ re.loop 0 3) (re.range "0" "9"))) (str.to_re "0")) (str.to_re "\u{a}")))))

; --- Email split constraints ---
; exactly one '@' => two segments
(assert (= (num_splits X "@") 2))
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))

; local part constraints
(assert (>= (str.len local) 1))
(assert (not (str.contains local " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains local ".")))

; domain constraints: at least one '.' => at least two labels
(assert (>= (num_splits domain ".") 2))
(assert (= label0 (split_at domain "." 0)))
(assert (= label1 (split_at domain "." 1)))
(assert (>= (str.len label0) 1))
(assert (>= (str.len label1) 1))

; TLD: last segment after splitting by '.' must be alphabetic-only, length in [2,6]
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len tld) 2))
(assert (<= (str.len tld) 6))
(assert (str.in_re tld (re.+ (re.union (re.range "a" "z") (re.range "A" "Z")))))

; additional domain hygiene
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain "..")))
(assert (not (str.contains domain " ")))

; --- Force a particular structured but still satisfiable domain: "example.<tld>" ---
(assert (= label0 "example"))
(assert (= (num_splits domain ".") 2))
(assert (= label1 tld))

; --- Ensure X is a single-line email-like token (no newlines) ---
(assert (not (str.contains X "\n")))
(assert (not (str.contains X "\r")))

; --- Create both SAT and UNSAT instances: make UNSAT by conflicting TLD constraints ---
; tld cannot be both "com" and "org"
(assert (= tld "com"))
(assert (= tld "org"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
