(
  (define-fun csv_line () String
    "A,C,123,B,END")
  (define-fun field5 () String
    "END")
  (define-fun field3 () String
    "123")
  (define-fun field1 () String
    "A")
  (define-fun delimiter () String
    ",")
  (define-fun field2 () String
    "C")
  (define-fun field4 () String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,C,123,B,END") (= x!1 (seq.unit (_ Char 44))) (= x!2 2))
      "123"
    (ite (and (= x!0 "A,C,123,B,END") (= x!1 (seq.unit (_ Char 44))) (= x!2 4))
      "END"
    (ite (and (= x!0 "A,C,123,B,END") (= x!1 (seq.unit (_ Char 44))) (= x!2 1))
      "C"
    (ite (and (= x!0 "A,C,123,B,END") (= x!1 (seq.unit (_ Char 44))) (= x!2 3))
      "B"
      "A")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
