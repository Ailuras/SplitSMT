(set-logic ALL)

; Uninterpreted interface for string splitting

; ----------------------------
; SAT instance: well-formed log line
; Format (space-separated): "YYYY-MM-DDTHH:MM:SSZ LEVEL module:message"
; Example: "2026-01-09T13:45:07Z INFO auth:login ok"
; ----------------------------
(declare-const log_line_ok String)
(declare-const ts_ok String)
(declare-const level_ok String)
(declare-const modmsg_ok String)
(declare-const module_ok String)
(declare-const message_ok String)

; Basic split by spaces
(assert (>= (str.num_splits log_line_ok " ") 3))
(assert (= ts_ok (str.split_at log_line_ok " " 0)))
(assert (= level_ok (str.split_at log_line_ok " " 1)))
(assert (= modmsg_ok (str.split_rest log_line_ok " " 2)))

; Level extraction constraints
(assert (or (= level_ok "INFO") (= level_ok "WARN") (= level_ok "ERROR") (= level_ok "DEBUG")))

; modmsg_ok must contain a colon separating module and message
(assert (>= (str.num_splits modmsg_ok ":") 2))
(assert (= module_ok (str.split_at modmsg_ok ":" 0)))
(assert (= message_ok (str.split_rest modmsg_ok ":" 1)))

; Timestamp format validation via regex: YYYY-MM-DDTHH:MM:SSZ
(declare-const re_digit RegLan)
(declare-const re_2d RegLan)
(declare-const re_4d RegLan)
(declare-const re_ts RegLan)
(assert (= re_digit (re.range "0" "9")))
(assert (= re_2d (re.++ re_digit re_digit)))
(assert (= re_4d (re.++ re_2d re_2d)))
(assert (= re_ts
  (re.++
    re_4d (str.to_re "-") re_2d (str.to_re "-") re_2d
    (str.to_re "T")
    re_2d (str.to_re ":") re_2d (str.to_re ":") re_2d
    (str.to_re "Z"))))
(assert (str.in_re ts_ok re_ts))

; Some additional plausibility constraints
(assert (>= (str.len module_ok) 1))
(assert (>= (str.len message_ok) 1))
(assert (not (str.contains module_ok " ")))

; Provide a concrete witness to keep SAT straightforward
(assert (= log_line_ok "2026-01-09T13:45:07Z INFO auth:login ok"))

(check-sat)

; ----------------------------
; UNSAT instance: contradictory timestamp and level requirements
; ----------------------------
(declare-const log_line_bad String)
(declare-const ts_bad String)
(declare-const level_bad String)

(assert (>= (str.num_splits log_line_bad " ") 2))
(assert (= ts_bad (str.split_at log_line_bad " " 0)))
(assert (= level_bad (str.split_at log_line_bad " " 1)))

; Require valid timestamp regex...
(assert (str.in_re ts_bad re_ts))

; ...but also require an impossible timestamp length
(assert (not (= (str.len ts_bad) 20)))

; Level must be INFO, but also must not be INFO
(assert (= level_bad "INFO"))
(assert (not (= level_bad "INFO")))

; Concrete string (still unsat due to contradictions above)
(assert (= log_line_bad "2026-01-09T13:45:07Z INFO x:y"))

(check-sat)
(exit)
