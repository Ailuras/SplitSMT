(
  (define-fun idx_empty () Int
    2)
  (define-fun csv_line () String
    "")
  (define-fun nfields () Int
    4)
  (define-fun field3 () String
    "")
  (define-fun rest3 () String
    ",")
  (define-fun rest2 () String
    ",")
  (define-fun field2 () String
    "")
  (define-fun field0 () String
    "B")
  (define-fun field4 () String
    "")
  (define-fun field1 () String
    "0")
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 0)) "B"
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 1)) "0"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
