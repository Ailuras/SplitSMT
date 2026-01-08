; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables
(declare-const request String)
(declare-const content_length String)
(declare-const host String)
(declare-const user_agent String)
(declare-const num_headers Int)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)
(declare-const -1 Int)
(assert (= -1 (- 1)))

; Constraint 1: Request must contain at least 3 headers (split by newline)
(assert (>= (num_splits request "\n") 3))

; Constraint 2: Extract host from first header line (split by colon)
(assert (= host (split_at (split_at request "\n" 0) ":" 1)))

; Constraint 3: Extract user-agent from second header line
(assert (= user_agent (split_at (split_at request "\n" 1) ":" 1)))

; Constraint 4: Extract content-length from third header line
(assert (= content_length (split_at (split_at request "\n" 2) ":" 1)))

; Constraint 5: Content-length must be a non-empty string
(assert (not (= (str.len content_length) 0)))

; Constraint 6: Content-length must be a valid integer (digits only)
(assert (str.in_re content_length (re.+ (re.range "0" "9"))))

; Constraint 7: Host must contain a dot (domain validation)
(assert (str.contains host "."))

; Constraint 8: User-agent must not be empty
(assert (not (= (str.len user_agent) 0)))

; Constraint 9: Request must end with a newline
(assert (str.suffixof "\n" request))

; Constraint 10: Total number of header lines (excluding empty ones)
(assert (= num_headers (num_splits request "\n")))
(assert (>= num_headers 3))
(assert (<= num_headers 5))

; Constraint 11: Content-length value must be between 100 and 10000
(assert (let ((cl_int (str.to_int content_length)))
  (and (>= cl_int 100) (<= cl_int 10000))))

; Constraint 12: First header line must start with "Host:"
(assert (str.prefixof "Host:" (split_at request "\n" 0)))

; Constraint 13: Second header line must start with "User-Agent:"
(assert (str.prefixof "User-Agent:" (split_at request "\n" 1)))

; Constraint 14: Third header line must start with "Content-Length:"
(assert (str.prefixof "Content-Length:" (split_at request "\n" 2)))

; Constraint 15: All header lines must have exactly one colon
(assert (forall ((i Int))
  (=> (and (>= i 0) (< i num_headers))
      (= (num_splits (split_at request "\n" i) ":") 2))))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
