(
  (define-fun csv_row () String
    "A,B,0,END")
  (define-fun field3 () String
    "0")
  (define-fun field1 () String
    "A")
  (define-fun field2 () String
    "B")
  (define-fun field4 () String
    "END")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B,0,END")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,B,0,END") (= x!1 ",") (= x!2 3)) "END"
    (ite (and (= x!0 "A,B,0,END") (= x!1 ",") (= x!2 0)) "A"
    (ite (and (= x!0 "A,B,0,END") (= x!1 ",") (= x!2 1)) "B"
    (ite (and (= x!0 "A,B,0,END") (= x!1 ",") (= x!2 2)) "0"
      "END")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
