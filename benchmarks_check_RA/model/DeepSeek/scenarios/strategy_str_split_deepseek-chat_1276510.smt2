(
  (define-fun csv_data () String
    "A")
  (define-fun first_field () String
    "B")
  (define-fun middle_field () String
    "0")
  (define-fun last_field () String
    "C")
  (define-fun delimiter () String
    ",")
  (define-fun field_count () Int
    4)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "XYZ")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 3)) "C"
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 2)) "ID123"
    (ite (and (= x!0 "A") (= x!1 ",") (= x!2 1)) "0"
      "B"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
