(
  (define-fun csv_data () String
    "\u{11c}")
  (define-fun field_count () Int
    3)
  (define-fun third_field () String
    "0")
  (define-fun second_field () String
    " ")
  (define-fun delimiter () String
    ",")
  (define-fun rest_fields () String
    "")
  (define-fun first_field () String
    "0")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\u{11c}") (= x!1 ",") (= x!2 1)) " "
      "0"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
