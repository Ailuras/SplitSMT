(
  (define-fun csv_line () String
    "")
  (define-fun middle_field () String
    "")
  (define-fun last_field () String
    "A")
  (define-fun field_count () Int
    5)
  (define-fun first_field () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 4)) "A"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) ""
      "B")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
)
