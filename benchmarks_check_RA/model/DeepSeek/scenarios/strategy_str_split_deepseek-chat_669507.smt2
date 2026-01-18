(
  (define-fun csv_line () String
    "A")
  (define-fun delimiter () String
    ",")
  (define-fun last_field () String
    "")
  (define-fun middle_field () String
    "")
  (define-fun field_count () Int
    0)
  (define-fun first_field () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "data")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 0)) "D"
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 4)) "B"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
)
