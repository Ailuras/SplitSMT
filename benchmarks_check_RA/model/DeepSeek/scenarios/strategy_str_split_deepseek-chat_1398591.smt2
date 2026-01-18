(
  (define-fun is_valid () Bool
    true)
  (define-fun csv_data () String
    ",")
  (define-fun field_2 () String
    "Name")
  (define-fun field_1 () String
    "0")
  (define-fun field_3 () String
    "Name")
  (define-fun field_count () Int
    4)
  (define-fun field_0 () String
    "Name")
  (define-fun has_empty_field () Bool
    false)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "Name"
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "0"
      "Name")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
