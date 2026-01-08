(set-logic ALL)
; HTTP Header Parsing Scenario
; Variables for HTTP request header string and extracted components
(declare-const header String)
(declare-const content_length_str String)
(declare-const content_length_val Int)
(declare-const host_str String)
(declare-const host_val String)
(declare-const user_agent_str String)
(declare-const user_agent_val String)

; Declare str_split interface functions
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Constraint 1: Header must contain at least 3 lines (key-value pairs) separated by newline
(assert (>= (num_splits header "\n") 3))

; Constraint 2: Extract Content-Length value from header
; First, split header by newline to get lines, then find line containing "Content-Length:"
(assert (str.contains header "Content-Length:"))
; Assume Content-Length is in the first line for simplicity; in practice, we'd search
(assert (= content_length_str (split_at header "\n" 0)))
(assert (str.contains content_length_str "Content-Length:"))
; Split the Content-Length line by colon to get value part
(assert (>= (num_splits content_length_str ":") 2))
(assert (= (split_at content_length_str ":" 1) (str.from_int content_length_val)))
; Validate content_length_val is a positive integer
(assert (> content_length_val 0))
(assert (<= content_length_val 10000))

; Constraint 3: Extract Host value
(assert (str.contains header "Host:"))
; Assume Host is in the second line
(assert (= host_str (split_at header "\n" 1)))
(assert (str.contains host_str "Host:"))
(assert (>= (num_splits host_str ":") 2))
(assert (= host_val (split_at host_str ":" 1)))
; Host must be a non-empty string
(assert (> (str.len host_val) 0))

; Constraint 4: Extract User-Agent value
(assert (str.contains header "User-Agent:"))
; Assume User-Agent is in the third line
(assert (= user_agent_str (split_at header "\n" 2)))
(assert (str.contains user_agent_str "User-Agent:"))
(assert (>= (num_splits user_agent_str ":") 2))
(assert (= user_agent_val (split_at user_agent_str ":" 1)))
; User-Agent must contain common browser identifiers
(assert (or (str.contains user_agent_val "Mozilla") (str.contains user_agent_val "Chrome") (str.contains user_agent_val "Safari")))

; Constraint 5: Header must end with a newline (optional, but common in HTTP)
(assert (str.suffixof "\n" header))

; Constraint 6: Additional validation: no empty lines in header
; Check that each line (split by newline) has length > 0
(assert (forall ((i Int)) (=> (and (>= i 0) (< i (num_splits header "\n"))) (> (str.len (split_at header "\n" i)) 0))))

; Constraint 7: SAT instance: ensure header is non-empty and constraints are satisfiable
(assert (> (str.len header) 0))

(check-sat)
(get-model)

; [GENERATION STATUS: SUCCESS]
