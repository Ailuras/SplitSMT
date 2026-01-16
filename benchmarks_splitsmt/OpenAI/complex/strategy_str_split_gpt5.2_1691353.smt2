(set-logic ALL)

; Log Analysis scenario: parsing structured server log entries separated by spaces and colons
; We keep the original seed constraint (mutated by embedding it as an additional check on a payload field)

(declare-const X String)
(declare-const log String)
(declare-const ts String)
(declare-const rest1 String)
(declare-const levelAndRest String)
(declare-const level String)
(declare-const msg String)
(declare-const tag String)
(declare-const payload String)
(declare-const host String)
(declare-const pidStr String)
(declare-const pid Int)

; str_split interface

; Basic splitting by spaces: "<ts> <LEVEL>: <msg>"
(assert (= ts (str.split_at log " " 0)))
(assert (= rest1 (str.split_rest log " " 1)))
(assert (>= (str.num_splits log " ") 2))

; Extract "LEVEL:" then message
(assert (= levelAndRest (str.split_at rest1 " " 0)))
(assert (>= (str.num_splits rest1 " ") 1))
(assert (= msg (str.split_rest rest1 " " 1)))

; Split "LEVEL:" by ':' to obtain level
(assert (>= (str.num_splits levelAndRest ":") 2))
(assert (= level (str.split_at levelAndRest ":" 0)))

; Timestamp format: YYYY-MM-DDTHH:MM:SSZ (strict digits and separators)
(assert (str.in_re ts (re.++
  ((_ re.loop 4 4) (re.range "0" "9"))
  (str.to_re "-")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "-")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "T")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re ":")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re ":")
  ((_ re.loop 2 2) (re.range "0" "9"))
  (str.to_re "Z")
)))

; Allowed log levels
(assert (str.in_re level (re.union (str.to_re "INFO") (re.union (str.to_re "WARN") (re.union (str.to_re "ERROR") (str.to_re "DEBUG"))))))

; Message contains a tag with colon: "host:<hostname> pid:<digits>" somewhere
(assert (str.contains msg "host:"))
(assert (str.contains msg "pid:"))

; Parse host and pid using ':' and spaces
(assert (= tag (str.split_at msg " " 0)))
(assert (>= (str.num_splits msg " ") 1))
(assert (= payload (str.split_rest msg " " 1)))

; tag expected to be "host:<hostname>"
(assert (= (str.split_at tag ":" 0) "host"))
(assert (>= (str.num_splits tag ":") 2))
(assert (= host (str.split_rest tag ":" 1)))
(assert (>= (str.len host) 1))
(assert (str.in_re host (re.++ (re.+ (re.union (re.range "a" "z") (re.union (re.range "A" "Z") (re.union (re.range "0" "9") (re.union (str.to_re "-") (str.to_re ".")))))))))

; payload expected to start with "pid:<digits>" then optionally more text
(assert (= (str.split_at payload " " 0) (str.split_at payload " " 0)))
(assert (= (str.split_at (str.split_at payload " " 0) ":" 0) "pid"))
(assert (>= (str.num_splits (str.split_at payload " " 0) ":") 2))
(assert (= pidStr (str.split_rest (str.split_at payload " " 0) ":" 1)))
(assert (str.in_re pidStr (re.+ (re.range "0" "9"))))
(assert (= pid (str.to_int pidStr)))
(assert (>= pid 0))
(assert (<= pid 65535))

; --- Seed-derived constraint (mutated/embedded) ---
; Ensure X does NOT match a suspicious Referer payload regex (as in the seed), and also keep X tied to payload.
(assert (= X payload))
(assert (not (str.in_re X (re.++
  (str.to_re "/Referer:")
  (re.* (re.union (str.to_re " ") (re.union (str.to_re "\u{9}") (re.union (str.to_re "\u{a}") (re.union (str.to_re "\u{c}") (str.to_re "\u{d}"))))))
  (str.to_re "http:")
  ((_ re.loop 2 2) (str.to_re "/"))
  (re.+ (re.union (re.range "a" "z") (re.union (re.range "0" "9") (re.union (str.to_re ".") (str.to_re "-")))))
  (str.to_re "/s/?k=/Hi\u{a}")
))))

; --- Additional constraints to create both SAT and UNSAT branches in one file ---
; SAT branch: choose a concrete well-formed log line
(declare-const is_sat Bool)
(assert is_sat)
(assert (= log "2025-01-07T13:45:59Z INFO: host:server-1 pid:1234 started"))

; UNSAT sub-instance encoded but disabled by is_sat
(declare-const is_unsat Bool)
(assert (not is_unsat))
(assert (=> is_unsat (= log "2025-13-99T99:99:99Z ERROR: host:bad pid:99999 /Referer: http://aa/s/?k=/Hi\u{a}")))
(assert (=> is_unsat (and (= level "TRACE") (< pid 0))))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
