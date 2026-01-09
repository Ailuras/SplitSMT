(set-logic ALL)

; Uninterpreted interface functions for string splitting
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; ---------------------------
; Scenario: HTTP Header Parsing
; ---------------------------

; A: SAT instance (consistent header parsing + content-length validation)
(declare-const reqA String)
(declare-const headerA String)
(declare-const bodyA String)
(declare-const line0A String)
(declare-const line1A String)
(declare-const line2A String)
(declare-const line3A String)
(declare-const line4A String)
(declare-const hostLineA String)
(declare-const clLineA String)
(declare-const uaLineA String)
(declare-const hostValueA String)
(declare-const clValueA String)
(declare-const uaValueA String)
(declare-const clIntA Int)

; Define header/body split by CRLFCRLF
(assert (= headerA (split_at reqA "\r\n\r\n" 0)))
(assert (= bodyA (split_at reqA "\r\n\r\n" 1)))
(assert (>= (num_splits reqA "\r\n\r\n") 2))

; Split header into lines (CRLF)
(assert (>= (num_splits headerA "\r\n") 5))
(assert (= line0A (split_at headerA "\r\n" 0)))
(assert (= line1A (split_at headerA "\r\n" 1)))
(assert (= line2A (split_at headerA "\r\n" 2)))
(assert (= line3A (split_at headerA "\r\n" 3)))
(assert (= line4A (split_at headerA "\r\n" 4)))

; Request line structure: "POST /path HTTP/1.1"
(assert (str.contains line0A " HTTP/1.1"))
(assert (str.contains line0A "POST "))

; Choose specific header lines for parsing
(assert (= hostLineA line1A))
(assert (= clLineA line2A))
(assert (= uaLineA line3A))

; Enforce presence of ':' delimiter in each chosen header line
(assert (>= (num_splits hostLineA ":") 2))
(assert (>= (num_splits clLineA ":") 2))
(assert (>= (num_splits uaLineA ":") 2))

; Extract key/value pairs using ':' split
(assert (= (split_at hostLineA ":" 0) "Host"))
(assert (= hostValueA (split_rest hostLineA ":" 1)))
(assert (= (split_at clLineA ":" 0) "Content-Length"))
(assert (= clValueA (split_rest clLineA ":" 1)))
(assert (= (split_at uaLineA ":" 0) "User-Agent"))
(assert (= uaValueA (split_rest uaLineA ":" 1)))

; Require standard optional whitespace after ':' (at least one leading space in the value)
(assert (str.prefixof " " hostValueA))
(assert (str.prefixof " " clValueA))
(assert (str.prefixof " " uaValueA))

; Concrete instantiation to make the instance clearly SAT
(assert (= hostValueA " example.com"))
(assert (= uaValueA " test-agent/1.0"))

; Content-Length value: " 5" and numeric validation via an integer variable
(assert (= clValueA " 5"))
(assert (= clIntA 5))
(assert (>= clIntA 0))

; Validate that body length matches Content-Length
(assert (= (str.len bodyA) clIntA))

; Build a concrete request satisfying all constraints
(assert (= headerA (str.++
  "POST /submit HTTP/1.1\r\n"
  "Host: example.com\r\n"
  "Content-Length: 5\r\n"
  "User-Agent: test-agent/1.0\r\n"
  "X-Trace: abc123\r\n")))
(assert (= bodyA "Hello"))
(assert (= reqA (str.++ headerA "\r\n\r\n" bodyA)))

(check-sat)

; ---------------------------
; B: UNSAT instance (conflicting content-length vs actual body length)
; ---------------------------

(declare-const reqB String)
(declare-const headerB String)
(declare-const bodyB String)
(declare-const line0B String)
(declare-const clLineB String)
(declare-const clValueB String)
(declare-const clIntB Int)

(assert (= headerB (split_at reqB "\r\n\r\n" 0)))
(assert (= bodyB (split_at reqB "\r\n\r\n" 1)))
(assert (>= (num_splits reqB "\r\n\r\n") 2))

(assert (>= (num_splits headerB "\r\n") 2))
(assert (= line0B (split_at headerB "\r\n" 0)))
(assert (= clLineB (split_at headerB "\r\n" 1)))

(assert (str.contains line0B " HTTP/1.1"))
(assert (>= (num_splits clLineB ":") 2))
(assert (= (split_at clLineB ":" 0) "Content-Length"))
(assert (= clValueB (split_rest clLineB ":" 1)))
(assert (str.prefixof " " clValueB))

; Concrete conflicting setup: header says 4 but body is length 3
(assert (= clValueB " 4"))
(assert (= clIntB 4))
(assert (= (str.len bodyB) clIntB))

(assert (= headerB (str.++
  "GET / HTTP/1.1\r\n"
  "Content-Length: 4\r\n")))
(assert (= bodyB "abc"))
(assert (= reqB (str.++ headerB "\r\n\r\n" bodyB)))

(check-sat)



; [GENERATION STATUS: SUCCESS]