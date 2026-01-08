(set-logic ALL)

; Uninterpreted interface for string split operations

; Seed-style string building blocks retained (mutated to log paths/messages)
(declare-fun sigmaStar_5 () String)
(declare-fun sigmaStar_6 () String)
(declare-fun sigmaStar_7 () String)
(declare-fun literal_8 () String)
(declare-fun x_11 () String)
(declare-fun literal_9 () String)
(declare-fun x_12 () String)
(declare-fun literal_10 () String)
(declare-fun x_13 () String)
(declare-fun x_16 () String)
(declare-fun literal_1 () String)

; New variables for log analysis scenario
(declare-const logline String)
(declare-const ts String)
(declare-const level String)
(declare-const pid String)
(declare-const component String)
(declare-const msg String)
(declare-const datePart String)
(declare-const timePart String)
(declare-const hour String)
(declare-const minute String)
(declare-const second String)
(declare-const ms String)
(declare-const levelPrefix String)
(declare-const unusedRest String)

; Mutate literals to resemble log tokens / message tails
(assert (= literal_8 "ERROR"))
(assert (= x_11 (str.++ sigmaStar_5 literal_8)))
(assert (= literal_9 "WARN"))
(assert (= x_12 (str.++ sigmaStar_6 literal_9)))
(assert (= literal_10 "INFO"))
(assert (= x_13 (str.++ sigmaStar_7 literal_10)))
(assert (= literal_1 "DEBUG"))

; Choose extracted level among common levels (core structure preserved via x_16)
(assert (or (= x_16 x_11) (= x_16 literal_1) (= x_16 x_13) (= x_16 x_12)))

; Split log line by spaces: "<ts> <level>: <pid> <component>: <msg>"
(assert (>= (str.num_splits logline " ") 5))
(assert (= ts (str.split_at logline " " 0)))
(assert (= levelPrefix (str.split_at logline " " 1)))
(assert (= pid (str.split_at logline " " 2)))
(assert (= component (str.split_at logline " " 3)))
(assert (= msg (str.split_rest logline " " 4)))

; Extract level token before ':'
(assert (>= (str.num_splits levelPrefix ":") 2))
(assert (= level (str.split_at levelPrefix ":" 0)))
(assert (= x_16 level))

; Component must end with ':' in the original token (e.g., "auth:")
(assert (str.in_re component (re.++ (re.* re.allchar) (str.to_re ":"))))

; Timestamp validation: enforce ISO-like "YYYY-MM-DDTHH:MM:SS.mmmZ"
(assert (>= (str.num_splits ts "T") 2))
(assert (= datePart (str.split_at ts "T" 0)))
(assert (= timePart (str.split_at ts "T" 1)))

; Date pattern YYYY-MM-DD
(assert (str.in_re datePart
  (re.++
    (re.++
      (re.++
        (re.++ (re.loop (re.range "0" "9") 4 4) (str.to_re "-"))
        (re.++ (re.loop (re.range "0" "9") 2 2) (str.to_re "-")))
      (re.loop (re.range "0" "9") 2 2))
    (re.* (str.to_re "")))))

; Time part split on ':' -> HH, MM, and "SS.mmmZ"
(assert (>= (str.num_splits timePart ":") 3))
(assert (= hour (str.split_at timePart ":" 0)))
(assert (= minute (str.split_at timePart ":" 1)))
(assert (= second (str.split_at timePart ":" 2)))

; Hour and minute are 2 digits
(assert (str.in_re hour (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re minute (re.loop (re.range "0" "9") 2 2)))

; Seconds token must be "SS.mmmZ" with SS 2 digits, mmm 3 digits, Z literal
(assert (>= (str.num_splits second ".") 2))
(assert (= ms (str.split_at second "." 1)))
(assert (= unusedRest (str.split_at second "." 0)))
(assert (str.in_re unusedRest (re.loop (re.range "0" "9") 2 2)))
(assert (str.in_re ms (re.++ (re.loop (re.range "0" "9") 3 3) (str.to_re "Z"))))

; PID must be digits
(assert (str.in_re pid (re.+ (re.range "0" "9"))))

; Message should contain either "timeout" or "login" (simple content check)
(assert (or (str.contains msg "timeout") (str.contains msg "login")))

; Security check: message must not contain "evil" (UNSAT if combined with next assertion)
(assert (not (str.contains msg "evil")))

; Keep seed's regex-style check but adapt to log message content to create tension
(assert (str.in_re msg (re.++ (re.* re.allchar) (re.++ (str.to_re "evil") (re.* re.allchar)))))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
