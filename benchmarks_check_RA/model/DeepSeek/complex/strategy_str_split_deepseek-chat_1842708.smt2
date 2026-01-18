(
  (define-fun csv_data () String
    "AHBICJDEKL")
  (define-fun middle_field () String
    "")
  (define-fun last_field () String
    "G")
  (define-fun field_count () Int
    5)
  (define-fun delimiter () String
    ",")
  (define-fun first_field () String
    "F")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "data")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "AHBICJDEKL") (= x!1 (seq.unit (_ Char 44))) (= x!2 4)) "G"
    (ite (and (= x!0 "AHBICJDEKL") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) ""
      "F")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
)
