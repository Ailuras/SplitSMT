(
  (define-fun csv_data () String
    "ABCDEFGHIJ")
  (define-fun field_count () Int
    6)
  (define-fun delimiter () String
    ",")
  (define-fun has_empty_field () Bool
    true)
  (define-fun field2 () String
    "ABCDEFGHIJ")
  (define-fun field4 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",,")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "ABCDEFGHIJ") (= x!1 (seq.unit (_ Char 44))) (= x!2 3)) ""
      "ABCDEFGHIJ"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    6)
)
