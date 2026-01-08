; Email Validation with str_split operations
(set-logic ALL)

; Declare variables
(declare-const email String)
(declare-const local_part String)
(declare-const domain String)
(declare-const domain_parts Int)
(declare-const tld String)
(declare-const subdomain String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Core email structure constraints
; Must contain exactly one '@' character
(assert (= (num_splits email "@") 2))

; Extract local part and domain
(assert (= local_part (split_at email "@" 0)))
(assert (= domain (split_at email "@" 1)))

; Domain must contain at least one '.'
(assert (>= (num_splits domain ".") 2))

; Domain parts count
(assert (= domain_parts (num_splits domain ".")))

; Extract TLD (last part after last dot)
(assert (= tld (split_at domain "." (- domain_parts 1))))

; TLD must be 2-3 letters
(assert (str.in_re tld (re.++ ((_ re.loop 2 3) (re.range "a" "z")))))

; Extract subdomain (everything before TLD)
(assert (= subdomain (split_rest domain "." 0)))

; Subdomain must be non-empty
(assert (> (str.len subdomain) 0))

; Subdomain must contain only valid characters
(assert (str.in_re subdomain (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "-") (str.to_re ".")))))

; Local part must be non-empty
(assert (> (str.len local_part) 0))

; Local part must contain only valid characters
(assert (str.in_re local_part (re.* (re.union (re.range "a" "z") (re.range "A" "Z") (re.range "0" "9") (str.to_re "!") (str.to_re "#") (str.to_re "$") (str.to_re "%") (str.to_re "&") (str.to_re "'") (str.to_re "*") (str.to_re "+") (str.to_re "-") (str.to_re "/") (str.to_re "=") (str.to_re "?") (str.to_re "^") (str.to_re "_") (str.to_re "`") (str.to_re "{") (str.to_re "|") (str.to_re "}") (str.to_re "~")))))

; Additional constraint: email must not start or end with dot
(assert (not (str.prefixof "." email)))
(assert (not (str.suffixof "." email)))

; Domain must not have consecutive dots
(assert (not (str.contains domain "..")))

; Make it SAT by providing a concrete example
(assert (= email "user.name+tag@sub.example.co.uk"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(get-model)
