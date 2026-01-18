(
  (define-fun csv_line () String
    "BCDE,")
  (define-fun middle_field () String
    "A")
  (define-fun last_field () String
    "A")
  (define-fun field_count () Int
    3)
  (define-fun has_empty_field () Bool
    false)
  (define-fun first_field () String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "A")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
