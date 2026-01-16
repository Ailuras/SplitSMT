(set-logic ALL)
(declare-fun split_at (String String Int) String)
(declare-fun split_rest (String String Int) String)
(declare-fun num_splits (String String) Int)

; --- Uninterpreted interface for str_split ---

; --- Seed-like variables (preserve core structure) ---
(declare-fun T_1 () Int)
(declare-fun T_2 () Bool)
(declare-fun T_3 () Bool)
(declare-fun var_0xINPUT_520976 () String)

; --- HTTP header parsing variables ---
(declare-const request String)
(declare-const headers String)
(declare-const header0 String)
(declare-const header1 String)
(declare-const header2 String)
(declare-const h0_key String)
(declare-const h0_val String)
(declare-const h1_key String)
(declare-const h1_val String)
(declare-const contentLengthStr String)
(declare-const contentLengthVal Int)
(declare-const body String)
(declare-const bodyLen Int)

; --- Keep core structure: length and non-empty check ---
(assert (= T_1 (str.len var_0xINPUT_520976)))
(assert (= T_2 (= T_1 0)))
(assert (= T_3 (not T_2)))
(assert T_3)

; Tie seed input to HTTP request under analysis
(assert (= request var_0xINPUT_520976))

; Basic well-formedness: request contains header/body separator
(assert (str.contains request "\r\n\r\n"))
(assert (>= (num_splits request "\r\n\r\n") 2))
(assert (= headers (split_at request "\r\n\r\n" 0)))
(assert (= body (split_rest request "\r\n\r\n" 1)))

; Headers consist of request-line plus at least two header lines
(assert (>= (num_splits headers "\r\n") 3))
(assert (= header0 (split_at headers "\r\n" 1)))
(assert (= header1 (split_at headers "\r\n" 2)))
(assert (= header2 (split_at headers "\r\n" 0)))

; Each header line must be key-value separated by colon
(assert (>= (num_splits header0 ":") 2))
(assert (>= (num_splits header1 ":") 2))

; Parse header0: key and value
(assert (= h0_key (split_at header0 ":" 0)))
(assert (= h0_val (split_rest header0 ":" 1)))
; Trim requirement approximated: value starts with a space (common in HTTP)
(assert (>= (str.len h0_val) 1))
(assert (= (str.at h0_val 0) " "))

; Parse header1: key and value
(assert (= h1_key (split_at header1 ":" 0)))
(assert (= h1_val (split_rest header1 ":" 1)))
(assert (>= (str.len h1_val) 1))
(assert (= (str.at h1_val 0) " "))

; Constrain header1 to be Content-Length (case-sensitive for simplicity)
(assert (= h1_key "Content-Length"))
; Forbid empty value after the space
(assert (> (str.len h1_val) 1))

; Extract the digits part of Content-Length by skipping the leading space
(assert (= contentLengthStr (str.substr h1_val 1 (- (str.len h1_val) 1))))

; Content-Length must be digits only (non-empty)
(assert (>= (str.len contentLengthStr) 1))
(assert (str.in_re contentLengthStr (re.+ (re.range "0" "9"))))

; Interpret numeric value via an uninterpreted relation to allow string/integer connection
(declare-fun parse_int (String) Int)
(assert (= contentLengthVal (parse_int contentLengthStr)))

; Body length accounting
(assert (= bodyLen (str.len body)))

; --- Create both SAT and UNSAT branches within one file using disjunction ---
; Branch A (SAT-like): contentLengthVal matches bodyLen and is non-negative
; Branch B (UNSAT-like): contentLengthVal mismatches bodyLen and equals bodyLen simultaneously
(assert (or
  (and (>= contentLengthVal 0)
       (= contentLengthVal bodyLen)
       (str.contains headers "Content-Length"))
  (and (not (= contentLengthVal bodyLen))
       (= contentLengthVal bodyLen))))

; Additional sanity: request-line must start with method token
(assert (or (str.prefixof "GET " header2)
            (str.prefixof "POST " header2)
            (str.prefixof "HEAD " header2)))



; [GENERATION STATUS: SUCCESS]
(check-sat)
(exit)
