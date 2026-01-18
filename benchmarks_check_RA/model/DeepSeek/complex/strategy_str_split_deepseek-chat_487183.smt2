(
  (define-fun csv_line () String
    "A")
  (define-fun empty_field_index () Int
    1)
  (define-fun field3 () String
    "")
  (define-fun field1 () String
    "B")
  (define-fun field_count () Int
    4)
  (define-fun field2 () String
    "")
  (define-fun field4 () String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 0)) "B"
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 3)) "C"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
