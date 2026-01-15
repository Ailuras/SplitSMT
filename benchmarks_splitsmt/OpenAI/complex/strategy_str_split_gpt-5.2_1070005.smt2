(set-logic ALL)

; Log Analysis scenario: parse structured server log entries separated by spaces and colons.
; We use split_at/num_splits/split_rest as an abstract split interface.


(declare-const X String)
(declare-const ts String)
(declare-const level String)
(declare-const msg String)
(declare-const date String)
(declare-const time String)
(declare-const hms String)
(declare-const hh String)
(declare-const mm String)
(declare-const ss String)
(declare-const tag String)

; Preserve core structure from seed: keep a negated regex membership constraint on X.
(assert
  (not
    (str.in_re
      X
      (re.++
        (str.to_re "/")
        (re.union (str.to_re "\u{19}\u{0}") (str.to_re "\u{0}\u{5c}"))
        (str.to_re "\u{0}n\u{0}w\u{0}d\u{0}b\u{0}l\u{0}i\u{0}b\u{0}.\u{0}d\u{0}l\u{0}l\u{0}\u{0}\u{0}/i\u{a}")
      )
    )
  )
)

; Parse log format: "YYYY-MM-DD HH:MM:SS LEVEL: message"
(assert (>= (str.num_splits X " ") 3))
(assert (= ts (str.++ (str.split_at X " " 0) " " (str.split_at X " " 1))))
(assert (= level (str.split_at X " " 2)))
(assert (= msg (str.split_rest X " " 3)))

; The 2nd token should contain a colon-separated time; overall timestamp uses a space.
(assert (>= (str.num_splits ts " ") 2))
(assert (= date (str.split_at ts " " 0)))
(assert (= time (str.split_at ts " " 1)))

; Validate date format YYYY-MM-DD with digits only.
(assert (str.in_re date (re.++ (re.loop (re.range "0" "9") 4 4)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re "-")
                               (re.loop (re.range "0" "9") 2 2))))

; Validate time format HH:MM:SS with digits only.
(assert (str.in_re time (re.++ (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2)
                               (str.to_re ":")
                               (re.loop (re.range "0" "9") 2 2))))

; Extract HH,MM,SS via split on ':'
(assert (>= (str.num_splits time ":") 3))
(assert (= hh (str.split_at time ":" 0)))
(assert (= mm (str.split_at time ":" 1)))
(assert (= ss (str.split_at time ":" 2)))

; Constrain log level and require a colon appears after it in the remaining message.
(assert (str.in_re level (re.union (str.to_re "INFO")
                                   (re.union (str.to_re "WARN")
                                             (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; The rest-of-line message should be non-empty and include a tag before a ':' such as "auth:".
(assert (>= (str.len msg) 1))
(assert (>= (str.num_splits msg ":") 2))
(assert (= tag (str.split_at msg ":" 0)))
(assert (str.in_re tag (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.range "0" "9"))))
                               (re.* (str.to_re "-")))))

; Create diversity: add a concrete SAT witness pattern for X consistent with constraints.
(assert (= X "2025-01-09 12:34:56 INFO auth: login ok"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
