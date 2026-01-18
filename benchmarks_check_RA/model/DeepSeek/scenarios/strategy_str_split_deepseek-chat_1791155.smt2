(
  (define-fun csv_line () String
    "z\u{a}")
  (define-fun field5 () String
    "END")
  (define-fun field3 () String
    ",")
  (define-fun field1 () String
    "p")
  (define-fun field4 () String
    "B")
  (define-fun field2 () String
    "0")
  (define-fun num_fields () Int
    5)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "z\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "0"
    (ite (and (= x!0 "z\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) ","
    (ite (and (= x!0 "z\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 3)) "B"
    (ite (and (= x!0 "z\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 4)) "END"
      "p")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
