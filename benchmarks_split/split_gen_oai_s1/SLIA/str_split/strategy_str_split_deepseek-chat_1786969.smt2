(set-logic ALL)

; Uninterpreted interface operations for string split constraints
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; Header parsing variables
(declare-const req String)
(declare-const line0 String)
(declare-const line1 String)
(declare-const line2 String)
(declare-const hostLine String)
(declare-const clLine String)
(declare-const hostKey String)
(declare-const hostVal String)
(declare-const clKey String)
(declare-const clVal String)
(declare-const body String)

; Reuse/mutate seed-style variables (all over 'a')
(declare-const T String)
(declare-const U String)
(declare-const V String)
(declare-const W String)
(declare-const X String)

; Numeric content-length
(declare-const contentLength Int)

(assert
  (and
    ; Seed core structure preserved, but slightly extended
    (not (str.contains (str.++ T U V W X T) (str.++ W V U T)))
    (str.in_re T (re.* (str.to_re "a")))
    (str.in_re U (re.* (str.to_re "a")))
    (str.in_re V (re.* (str.to_re "a")))
    (str.in_re W (re.* (str.to_re "a")))
    (str.in_re X (re.* (str.to_re "a")))

    ; Request consists of 3 lines + blank line + body
    (= line0 (split_at req "\n" 0))
    (= line1 (split_at req "\n" 1))
    (= line2 (split_at req "\n" 2))
    (>= (num_splits req "\n") 4)

    ; Ensure we have an empty line separator after headers: line2 is ""
    (= line2 "")

    ; Body is everything after the blank line (index 3 onwards)
    (= body (split_rest req "\n" 3))

    ; Two header lines are treated as key-value pairs split by ":"
    (= hostLine line0)
    (= clLine line1)

    (>= (num_splits hostLine ":") 2)
    (= hostKey (split_at hostLine ":" 0))
    (= hostVal (split_rest hostLine ":" 1))

    (>= (num_splits clLine ":") 2)
    (= clKey (split_at clLine ":" 0))
    (= clVal (split_rest clLine ":" 1))

    ; Constrain keys to expected headers
    (= hostKey "Host")
    (= clKey "Content-Length")

    ; Basic sanity: values should not contain newlines
    (not (str.contains hostVal "\n"))
    (not (str.contains clVal "\n"))

    ; Content-Length should be all digits (possibly with leading spaces stripped by assumptions)
    ; Here we assume clVal is digits only and equals the body length.
    (str.in_re clVal (re.+ (re.range "0" "9")))

    ; Relate parsed numeric length to body size (model contentLength as exact body length)
    (= contentLength (str.len body))

    ; Force a specific content length string that contradicts body length -> UNSAT instance
    (= clVal "0")
    (> (str.len body) 0)

    ; Additional variation: hostVal contains at least one 'a' and is non-empty
    (str.contains hostVal "a")
    (> (str.len hostVal) 0)
  )
)

(check-sat)


; [GENERATION STATUS: SUCCESS]