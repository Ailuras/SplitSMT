(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; Log Analysis: parsing server log entries separated by spaces and colons
; We create both SAT and UNSAT instances under a top-level disjunction.

; --- str_split interface (uninterpreted) ---

; --- Inputs ---
(declare-const logline String)

; Space-separated fields
(declare-const field0 String)
(declare-const field1 String)
(declare-const field2 String)
(declare-const field3plus String)

; Timestamp parts (split by ':')
(declare-const ts_full String)
(declare-const ts_hh String)
(declare-const ts_mm String)
(declare-const ts_ss String)
(declare-const ts_tail String)

; Log level and message
(declare-const level String)
(declare-const msg String)

; Indices
(declare-const k0 Int)
(declare-const k1 Int)
(declare-const k2 Int)
(declare-const k3 Int)

; --- Basic index / bound discipline for str_split interface ---
(assert (= k0 0))
(assert (= k1 1))
(assert (= k2 2))
(assert (= k3 3))
(assert (>= k0 0))
(assert (>= k1 0))
(assert (>= k2 0))
(assert (>= k3 0))

; --- Split logline by spaces into key fields ---
(assert (= field0 (split_at logline " " 0)))
(assert (= field1 (split_at logline " " 1)))
(assert (= field2 (split_at logline " " 2)))
(assert (= field3plus (split_rest logline " " 3)))

; At least: timestamp, level, component, message
(assert (>= (num_splits logline " ") 4))

; Interpret fields
(assert (= ts_full field0))
(assert (= level field1))
(assert (= msg field3plus))

; --- Timestamp parsing: HH:MM:SS as first 3 segments split by ':' ---
(assert (= ts_hh (split_at ts_full ":" 0)))
(assert (= ts_mm (split_at ts_full ":" 1)))
(assert (= ts_ss (split_at ts_full ":" 2)))
(assert (= ts_tail (split_rest ts_full ":" 3)))

; Must have exactly 3 ':'-separated parts (no tail)
(assert (= (num_splits ts_full ":") 3))
(assert (= ts_tail ""))

; --- Regex definitions ---
; Digit and two-digit patterns
(define-fun re_digit () RegLan (re.range "0" "9"))
(define-fun re_2digits () RegLan (re.++ re_digit re_digit))

; Log level set
(define-fun re_level () RegLan
  (re.union (str.to_re "INFO")
    (re.union (str.to_re "WARN")
      (re.union (str.to_re "ERROR") (str.to_re "DEBUG")))))

; --- Structural validations ---
; Timestamp parts are exactly two digits
(assert (str.in_re ts_hh re_2digits))
(assert (str.in_re ts_mm re_2digits))
(assert (str.in_re ts_ss re_2digits))

; Additional simple sanity checks on timestamp ranges (relaxed, still meaningful)
(assert (<= (str.len ts_hh) 2))
(assert (<= (str.len ts_mm) 2))
(assert (<= (str.len ts_ss) 2))

; Level must be one of the known tokens
(assert (str.in_re level re_level))

; Message should be non-empty and not contain newlines
(assert (> (str.len msg) 0))
(assert (not (str.contains msg "\n")))
(assert (not (str.contains msg "\r")))

; Component field has a trailing ':' like "auth:" or "db:" (colon at end)
(assert (> (str.len field2) 1))
(assert (= (str.at field2 (- (str.len field2) 1)) ":"))

; --- Make both SAT and UNSAT instances (diversity) ---
; SAT branch: consistent well-formed log
(define-fun sat_branch () Bool
  (and
    (= logline "12:34:56 INFO auth: user=alice action=login")
    (= ts_full "12:34:56")
    (= level "INFO")
    (= field2 "auth:")
    (str.contains msg "user=alice")
    (str.contains msg "action=login")))

; UNSAT branch: contradictory requirements on the same fixed line
(define-fun unsat_branch () Bool
  (and
    (= logline "07:08:09 ERROR db: query=SELECT")
    (= ts_full "07:08:09")
    (= level "ERROR")
    ; Contradiction: require level to be INFO while fixed as ERROR
    (= level "INFO")))

(assert (or sat_branch unsat_branch))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
