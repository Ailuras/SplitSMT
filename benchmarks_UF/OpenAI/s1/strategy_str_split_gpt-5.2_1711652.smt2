(set-logic ALL)

; --- str_split interface (uninterpreted) ---
(declare-fun split_at (String String Int) String)
(declare-fun num_splits (String String) Int)
(declare-fun split_rest (String String Int) String)

; --- Seed-derived variable retained as header blob ---
(declare-const var0 String)

; --- HTTP header parsing variables ---
(declare-const request String)
(declare-const headers String)
(declare-const header0 String)
(declare-const header1 String)
(declare-const key0 String)
(declare-const val0 String)
(declare-const key1 String)
(declare-const val1 String)
(declare-const content_length_str String)
(declare-const body String)
(declare-const body_len Int)

; --- Keep core structure: complex regex membership on var0 (mutated slightly) ---
(assert
  (str.in_re var0
    (re.++
      (re.+ (re.* (str.to_re "0")))
      (re.++
        (re.* (re.union (str.to_re "11") (str.to_re "222")))
        (re.++
          (re.union (re.* (str.to_re "3")) (re.+ (str.to_re "4")))
          (re.++
            (re.+ (re.union (str.to_re "55") (str.to_re "666")))
            (re.++
              (re.+ (re.+ (str.to_re "77")))
              (re.++
                (re.* (re.union (str.to_re "8") (str.to_re "99")))
                (re.++
                  (re.union (re.union (str.to_re "aa") (str.to_re "b")) (re.* (str.to_re "cc")))
                  (re.++
                    (re.* (re.union (str.to_re "d") (str.to_re "ee")))
                    (re.++
                      (re.union (re.union (str.to_re "fff") (str.to_re "g")) (re.* (str.to_re "h")))
                      (re.++
                        (re.union (re.+ (str.to_re "ii")) (re.union (str.to_re "jj") (str.to_re "k")))
                        (re.++
                          (re.union (re.* (str.to_re "ll")) (re.union (str.to_re "m") (str.to_re "nn")))
                          (re.++
                            (re.union (re.* (str.to_re "oo")) (re.union (str.to_re "pp") (str.to_re "qqq")))
                            (re.++
                              (re.* (re.union (str.to_re "r") (str.to_re "ss")))
                              (re.++
                                (re.union (re.+ (str.to_re "t")) (re.union (str.to_re "uuu") (str.to_re "vv")))
                                (re.++
                                  (re.+ (re.* (str.to_re "www")))
                                  (re.++
                                    (re.union (re.+ (str.to_re "x")) (re.* (str.to_re "yy")))
                                    (re.++
                                      (re.union (re.+ (str.to_re "z")) (re.+ (str.to_re "AAA")))
                                      (re.++
                                        (re.* (re.union (str.to_re "BB") (str.to_re "CC")))
                                        (re.++
                                          (re.union (re.+ (str.to_re "DDD")) (re.+ (str.to_re "E")))
                                          (re.++
                                            (re.+ (re.* (str.to_re "F")))
                                            (re.++
                                              (re.+ (re.union (str.to_re "G") (str.to_re "HH")))
                                              (re.++
                                                (re.union (re.* (str.to_re "I")) (re.+ (str.to_re "JJ")))
                                                (re.++
                                                  (re.union (re.+ (str.to_re "K")) (re.union (str.to_re "LLL") (str.to_re "M")))
                                                  (re.++
                                                    (re.+ (re.* (str.to_re "NN")))
                                                    (re.++
                                                      (re.* (re.union (str.to_re "O") (str.to_re "P")))
                                                      (re.++
                                                        (re.* (re.+ (str.to_re "QQ")))
                                                        (re.++
                                                          (re.union (re.+ (str.to_re "RR")) (re.* (str.to_re "S")))
                                                          (re.++
                                                            (re.* (re.* (str.to_re "T")))
                                                            (re.union (re.+ (str.to_re "UUU")) (re.* (str.to_re "V")))))))))))))))))))))))))))))))))

; --- Scenario: HTTP Header Parsing ---
; Model request as headers + blank line + body. Reuse var0 as the headers blob.
(assert (= headers var0))
(assert (= request (str.++ headers "\r\n\r\n" body)))

; Split headers into lines by CRLF, take first two header lines.
(assert (>= (num_splits headers "\r\n") 2))
(assert (= header0 (split_at headers "\r\n" 0)))
(assert (= header1 (split_at headers "\r\n" 1)))

; Each header line is key:value, split on ':'
(assert (>= (num_splits header0 ":") 2))
(assert (>= (num_splits header1 ":") 2))
(assert (= key0 (split_at header0 ":" 0)))
(assert (= val0 (split_rest header0 ":" 1)))
(assert (= key1 (split_at header1 ":" 0)))
(assert (= val1 (split_rest header1 ":" 1)))

; Basic header well-formedness
(assert (> (str.len key0) 0))
(assert (> (str.len key1) 0))
(assert (not (str.contains key0 "\r")))
(assert (not (str.contains key0 "\n")))
(assert (not (str.contains key1 "\r")))
(assert (not (str.contains key1 "\n")))

; Identify Content-Length header as header0 and capture its value
(assert (= key0 "Content-Length"))
(assert (= content_length_str val0))

; Content-Length value is only digits and has no leading/trailing CRLF
(assert (str.in_re content_length_str (re.+ (re.range "0" "9"))))

; Body length consistency (simple numeric interpretation via bounded cases)
(assert (= body_len (str.len body)))

; SAT branch: allow a valid content-length of 4 and body length 4
(assert (or
  (and (= content_length_str "4") (= body_len 4))
  (and (= content_length_str "0") (= body_len 0))
))

; Additional header constraint: second header key must not be Content-Length and must contain a dash or be Host
(assert (not (= key1 "Content-Length")))
(assert (or (= key1 "Host") (str.contains key1 "-")))

; --- UNSAT instance also included (separate from SAT via push/pop) ---
(push 1)
; Force a contradictory content-length/body relationship
(assert (= content_length_str "1"))
(assert (= body_len 4))
(check-sat)
(pop 1)

; SAT check for the main constraints
(check-sat)



; [GENERATION STATUS: SUCCESS]