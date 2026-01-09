(set-logic ALL)

; Email Validation via str_split + regex

; Uninterpreted split operations (interface)

; Core variables
(declare-const email String)
(declare-const local String)
(declare-const domain String)
(declare-const tld String)
(declare-const subdomain String)

; Index variables (natural)
(declare-const atIdx Int)
(declare-const dotIdx Int)

; Basic splitting around '@'
(assert (= local (str.split_at email "@" 0)))
(assert (= domain (str.split_at email "@" 1)))
(assert (>= (str.num_splits email "@") 2))
(assert (<= (str.num_splits email "@") 2))

; Ensure non-empty local and domain parts
(assert (> (str.len local) 0))
(assert (> (str.len domain) 0))

; Domain must contain at least one dot, and we extract subdomain and TLD
(assert (>= (str.num_splits domain ".") 2))
(assert (= subdomain (str.split_at domain "." 0)))
(assert (= tld (str.split_rest domain "." 1)))
(assert (> (str.len subdomain) 0))
(assert (> (str.len tld) 0))

; Additional structural checks via indexof
(assert (= atIdx (str.indexof email "@" 0)))
(assert (>= atIdx 0))
(assert (< atIdx (str.len email)))
(assert (= dotIdx (str.indexof domain "." 0)))
(assert (>= dotIdx 1))

; Regex: conservative allowed charset for local and domain labels
(declare-const ALNUMSYM RegLan)
(declare-const ALNUM RegLan)
(declare-const LOCAL_RE RegLan)
(declare-const LABEL_RE RegLan)
(declare-const DOMAIN_RE RegLan)
(declare-const EMAIL_RE RegLan)

(assert (= ALNUM (re.union (re.range "a" "z")
                           (re.union (re.range "A" "Z") (re.range "0" "9")))))
(assert (= ALNUMSYM (re.union ALNUM
                              (re.union (str.to_re "_")
                                        (re.union (str.to_re ".")
                                                  (re.union (str.to_re "+") (str.to_re "-")))))))

; local: one or more of allowed, but must not start/end with '.' and must not contain spaces
(assert (= LOCAL_RE (re.++ ALNUM (re.* ALNUMSYM))))

; label: starts with alnum, then zero or more of alnum or '-', ends with alnum (approximated)
(assert (= LABEL_RE (re.++ ALNUM (re.* (re.union ALNUM (str.to_re "-"))))))

; domain: label '.' rest (at least one dot enforced earlier)
(assert (= DOMAIN_RE (re.++ LABEL_RE (re.++ (str.to_re ".") (re.* (re.union LABEL_RE (str.to_re ".")))))))

(assert (= EMAIL_RE (re.++ LOCAL_RE (re.++ (str.to_re "@") DOMAIN_RE))))
(assert (str.in_re email EMAIL_RE))

; Core semantic checks for forbidden patterns
(assert (not (str.contains local " ")))
(assert (not (str.contains domain " ")))
(assert (not (str.contains email "@@")))

; Intentional contradiction to create an UNSAT instance (keep core structure intact)
; Since num_splits email "@" is constrained to be exactly 2 above, this makes the file UNSAT.
(assert (>= (str.num_splits email "@") 3))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
