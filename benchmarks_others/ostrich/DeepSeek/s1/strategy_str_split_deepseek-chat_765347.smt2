; Email Validation Scenario: Validating complex email address formats using '@' and '.' as delimiters
; Core structure preserved with added str_split constraints for segment validation
(set-logic ALL)

; Declare string variables for email components
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_name String)
(declare-const tld String)
(declare-const result String)
(declare-const attack String)
(declare-const prefix RegLan)
(declare-const infix RegLan)
(declare-const postfix RegLan)
(declare-const postfixs String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Original regex constraints from seed (preserved with minor modifications)
(assert (str.in_re attack (re.++ prefix ((_ re.loop 5000 5000) infix) postfix)))
(assert (= prefix 
     (re.++  (re.++  (str.to_re "h") (re.++  (str.to_re "t")  (str.to_re "c"))) (re.+  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.union  (str.to_re ";") (re.union  (str.to_re "\\-")  (str.to_re "_")))) ))
))
(assert (= infix 
        (re.inter  (re.++ (re.+  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.union  (str.to_re ";") (re.union  (str.to_re "\\-")  (str.to_re "_")))) ) (re.+  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_"))) ))  (re.++ (re.+  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.union  (str.to_re ";") (re.union  (str.to_re "\\-")  (str.to_re "_")))) ) (re.+  (re.union (re.union (str.to_re "\u{09}") (str.to_re "\u{0a}") (str.to_re "\u{0d}") (str.to_re " ")) (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "_"))) )) )
))
(assert (= postfix 
         (str.to_re "@")
))
(assert (str.in_re postfixs postfix))
(assert (>= (str.len postfixs) 1))
(assert (= result (str.++ attack postfixs)))

; New email validation constraints using str_split
; Define email as combination of attack and postfixs
(assert (= email (str.++ attack postfixs "example.com")))

; Split email at '@' to get local part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_rest email "@" 1)))
(assert (>= (num_splits email "@") 2))

; Validate domain structure: split domain at '.' to get domain name and TLD
(assert (= domain_name (split_at domain "." 0)))
(assert (= tld (split_rest domain "." 1)))
(assert (>= (num_splits domain ".") 2))

; Additional constraints for email format validation
(assert (>= (str.len local_part) 1))
(assert (>= (str.len domain_name) 1))
(assert (>= (str.len tld) 2))
(assert (str.contains tld "."))

; Ensure no empty segments in splits
(assert (not (= local_part "")))
(assert (not (= domain_name "")))
(assert (not (= tld "")))

; Constraint to make instance SAT: ensure valid email format
(assert (str.contains email "@"))
(assert (str.contains domain "."))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
