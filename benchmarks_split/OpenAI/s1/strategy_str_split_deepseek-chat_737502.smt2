(set-logic ALL)

; Scenario: Email Validation using '@' and '.' delimiters

; str_split interface
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Variables
(declare-const X String)            ; candidate email
(declare-const local String)
(declare-const domain String)
(declare-const dom_first String)
(declare-const dom_rest String)
(declare-const tld String)
(declare-const second_level String)

; Preserve some core structure from seed: keep negative regex membership constraints (mutated to be email-related)
(assert (not (str.in_re X (re.++ (str.to_re "/filename=") (re.* (re.comp (str.to_re "\u{a}"))) (str.to_re ".pui/i\u{a}")))))
(assert (not (str.in_re X (str.to_re "pjpoptwql/rlnjsportsHost:Subject:YAHOOdestroyed!\u{a}"))))
(assert (not (str.in_re X (re.++ (str.to_re "<")
                               (re.+ (re.union (str.to_re "\u{22}") (str.to_re " ") (str.to_re "'") (str.to_re "#")
                                              (str.to_re "*") (str.to_re "=") (str.to_re ",") (str.to_re ".")
                                              (str.to_re "\u{5c}") (str.to_re "(") (str.to_re ")") (str.to_re "/")
                                              (str.to_re "-") (str.to_re "$") (str.to_re "{") (str.to_re "}")
                                              (str.to_re "[") (str.to_re "]") (str.to_re "|") (str.to_re "?")
                                              (str.to_re "+") (str.to_re "^") (str.to_re "&") (str.to_re ":")
                                              (str.to_re "%") (str.to_re ";") (str.to_re "!")
                                              (re.range "0" "9") (re.range "A" "Z") (re.range "a" "z") (str.to_re "_")))
                               (str.to_re ">\u{a}")))))
(assert (not (str.in_re X (re.++ (str.to_re "now") (re.+ (re.range "0" "9")) (str.to_re "/bar_pl/shdoclc.fcgiareHost:e2give.com\u{a}")))))

; Email split constraints
(assert (= local (split_at X "@" 0)))
(assert (= domain (split_at X "@" 1)))
(assert (= "" (split_at X "@" 2)))
(assert (= 2 (num_splits X "@")))
(assert (= (str.++ local "@" domain) X))

; Basic well-formedness
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains local "@")))
(assert (not (str.contains domain "@")))
(assert (not (str.contains domain "..")))
(assert (not (str.contains domain ".")))

; Domain must contain at least one '.' and have a TLD segment
(assert (>= (num_splits domain ".") 2))
(assert (= dom_first (split_at domain "." 0)))
(assert (= dom_rest (split_rest domain "." 1)))
(assert (= tld (split_at domain "." (- (num_splits domain ".") 1))))
(assert (>= (str.len dom_first) 1))
(assert (>= (str.len tld) 2))

; If domain has exactly two labels, the first is second-level; otherwise second-level is penultimate
(assert (ite (= (num_splits domain ".") 2)
            (= second_level (split_at domain "." 0))
            (= second_level (split_at domain "." (- (num_splits domain ".") 2)))))
(assert (>= (str.len second_level) 1))

; Character constraints via regex: local part and labels are limited to common email-safe chars
(declare-const local_safe_re RegLan)
(declare-const label_safe_re RegLan)

(assert (= local_safe_re
           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9")
                           (str.to_re ".") (str.to_re "_") (str.to_re "%") (str.to_re "+") (str.to_re "-")))))
(assert (= label_safe_re
           (re.+ (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-")))))

(assert (str.in_re local local_safe_re))
(assert (str.in_re dom_first label_safe_re))
(assert (str.in_re second_level label_safe_re))
(assert (str.in_re tld (re.++ (re.range "A" "Z") (re.* (re.union (re.range "A" "Z") (re.range "a" "z"))))))

; Additional structure: local cannot start or end with '.' and cannot contain consecutive dots
(assert (not (= (str.at local 0) ".")))
(assert (not (= (str.at local (- (str.len local) 1)) ".")))
(assert (not (str.contains local "..")))

; UNSAT core: contradictory domain constraints (forces no '.' but also requires at least one '.')
; These two together make the instance UNSAT.
(assert (not (str.contains domain ".")))
(assert (>= (num_splits domain ".") 2))

(check-sat)


; [GENERATION STATUS: SUCCESS]