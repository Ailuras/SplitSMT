(set-logic ALL)

; Uninterpreted functions for string splitting (relaxation-based interface)

; =====================
; Instance A (SAT): parse headers and validate Content-Length
; =====================
(declare-const reqA String)
(declare-const headerBlockA String)
(declare-const bodyA String)
(declare-const contentLenLineA String)
(declare-const clKeyA String)
(declare-const clValA String)
(declare-const hostLineA String)
(declare-const hostKeyA String)
(declare-const hostValA String)
(declare-const userAgentLineA String)
(declare-const uaKeyA String)
(declare-const uaValA String)
(declare-const parsedCLA Int)

; Request consists of headers, blank line, then body
(assert (= reqA (str.++ headerBlockA "\r\n\r\n" bodyA)))

; Header block has at least 3 lines: Host, User-Agent, Content-Length
(assert (>= (str.num_splits headerBlockA "\r\n") 3))
(assert (= hostLineA (str.split_at headerBlockA "\r\n" 0)))
(assert (= userAgentLineA (str.split_at headerBlockA "\r\n" 1)))
(assert (= contentLenLineA (str.split_at headerBlockA "\r\n" 2)))

; Each header line must have at least one colon splitting key and value
(assert (>= (str.num_splits hostLineA ":") 2))
(assert (>= (str.num_splits userAgentLineA ":") 2))
(assert (>= (str.num_splits contentLenLineA ":") 2))

; Extract keys and values around ':'
(assert (= hostKeyA (str.split_at hostLineA ":" 0)))
(assert (= hostValA (str.split_rest hostLineA ":" 1)))
(assert (= uaKeyA (str.split_at userAgentLineA ":" 0)))
(assert (= uaValA (str.split_rest userAgentLineA ":" 1)))
(assert (= clKeyA (str.split_at contentLenLineA ":" 0)))
(assert (= clValA (str.split_rest contentLenLineA ":" 1)))

; Constrain exact keys (common HTTP header casing)
(assert (= hostKeyA "Host"))
(assert (= uaKeyA "User-Agent"))
(assert (= clKeyA "Content-Length"))

; Values should be non-empty; allow leading space after ':'
(assert (>= (str.len hostValA) 2))
(assert (= (str.at hostValA 0) " "))
(assert (>= (str.len uaValA) 2))
(assert (= (str.at uaValA 0) " "))
(assert (>= (str.len clValA) 2))
(assert (= (str.at clValA 0) " "))

; Host value constraints (simple domain-like token after leading space): " example.com"
(assert (= hostValA " example.com"))

; User-Agent contains a product token; keep it simple
(assert (str.contains uaValA " MyClient/1.0"))

; Content-Length value is " 5" and matches body length 5
(assert (= clValA " 5"))
(assert (= bodyA "abcde"))
(assert (= (str.len bodyA) 5))

; Validate parsed Content-Length as integer with explicit binding
(assert (= parsedCLA 5))
(assert (= parsedCLA (str.len bodyA)))

; Constrain full concrete request for satisfiable example
(assert (= headerBlockA (str.++ "Host: example.com\r\n" "User-Agent: MyClient/1.0\r\n" "Content-Length: 5")))

; =====================
; Instance B (UNSAT): inconsistent Content-Length vs body
; =====================
(declare-const reqB String)
(declare-const headerBlockB String)
(declare-const bodyB String)
(declare-const contentLenLineB String)
(declare-const clKeyB String)
(declare-const clValB String)
(declare-const parsedCLB Int)

(assert (= reqB (str.++ headerBlockB "\r\n\r\n" bodyB)))
(assert (>= (str.num_splits headerBlockB "\r\n") 1))
(assert (= contentLenLineB (str.split_at headerBlockB "\r\n" 0)))
(assert (>= (str.num_splits contentLenLineB ":") 2))
(assert (= clKeyB (str.split_at contentLenLineB ":" 0)))
(assert (= clValB (str.split_rest contentLenLineB ":" 1)))
(assert (= clKeyB "Content-Length"))
(assert (= clValB " 4"))

; Body is length 5 but parsed content-length is 4 -> UNSAT
(assert (= bodyB "HELLO"))
(assert (= (str.len bodyB) 5))
(assert (= parsedCLB 4))
(assert (= parsedCLB (str.len bodyB)))

; Concrete header block for clarity
(assert (= headerBlockB "Content-Length: 4"))

(check-sat)


; [GENERATION STATUS: SUCCESS]
(exit)
