; HTTP Header Parsing with str_split operations
(set-logic ALL)

; Declare variables for HTTP header components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_key String)
(declare-const host_val String)
(declare-const user_agent_key String)
(declare-const user_agent_val String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Header must contain at least one colon-separated key-value pair
(assert (>= (num_splits header ":") 2))

; Constraint 2: Extract content-length value from header
(assert (str.contains header "content-length:"))
(assert (= content_length_str (split_at header "content-length:" 1)))
(assert (str.contains content_length_str "\n"))
(assert (= content_length_str (split_at content_length_str "\n" 0)))
(assert (>= (str.len content_length_str) 1))
(assert (= content_length_val (str.to_int content_length_str)))

; Constraint 3: Validate content-length value (must be positive integer)
(assert (> content_length_val 0))
(assert (< content_length_val 10000))

; Constraint 4: Extract host key-value pair
(assert (str.contains header "host:"))
(assert (= host_key (split_at header "host:" 0)))
(assert (= host_val (split_at header "host:" 1)))
(assert (str.contains host_val "\n"))
(assert (= host_val (split_at host_val "\n" 0)))
(assert (>= (str.len host_val) 3))

; Constraint 5: Extract user-agent key-value pair
(assert (str.contains header "user-agent:"))
(assert (= user_agent_key (split_at header "user-agent:" 0)))
(assert (= user_agent_val (split_at header "user-agent:" 1)))
(assert (str.contains user_agent_val "\n"))
(assert (= user_agent_val (split_at user_agent_val "\n" 0)))
(assert (>= (str.len user_agent_val) 5))

; Constraint 6: Header must end with newline
(assert (str.suffixof "\n" header))

; Constraint 7: Header length constraints
(assert (>= (str.len header) 20))
(assert (<= (str.len header) 200))

; Constraint 8: Make it UNSAT by adding contradictory constraint
(assert (< (str.len host_val) 3))

(check-sat)

; [GENERATION STATUS: SUCCESS]
(get-model)
