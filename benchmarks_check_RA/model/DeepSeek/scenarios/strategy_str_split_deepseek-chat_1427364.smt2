(
  (define-fun csv_line () String
    "ABCDEFGHI0")
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
    (ite (and (= x!0 "ABCDEFGHI0") (= x!1 (seq.unit (_ Char 44))) (= x!2 8857))
      "K"
    (ite (and (= x!0 "ABCDEFGHI0") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) ""
      "J")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    8858)
)
