(
  (define-fun csv_line () String
    "3AX9,JpT")
  (define-fun field5 () String
    "C")
  (define-fun field3 () String
    "0")
  (define-fun field1 () String
    "B")
  (define-fun field2 () String
    "")
  (define-fun field4 () String
    "D")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "DC")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "3AX9,JpT") (= x!1 ",") (= x!2 2)) "0"
    (ite (and (= x!0 "3AX9,JpT") (= x!1 ",") (= x!2 1)) ""
    (ite (and (= x!0 "3AX9,JpT") (= x!1 ",") (= x!2 3)) "D"
    (ite (and (= x!0 "3AX9,JpT") (= x!1 ",") (= x!2 4)) "C"
      "B")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
)
