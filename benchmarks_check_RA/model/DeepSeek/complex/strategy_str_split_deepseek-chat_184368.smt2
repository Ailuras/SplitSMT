(
  (define-fun csv_line () String
    ",")
  (define-fun empty_field_detected () Bool
    false)
  (define-fun field3 () String
    "B")
  (define-fun field_count () Int
    4)
  (define-fun field1 () String
    "0123456789")
  (define-fun field2 () String
    "A")
  (define-fun field4 () String
    "C")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "A"
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "B"
    (ite (and (= x!0 (seq.unit (_ Char 44)))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 3))
      "C"
      "0123456789"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
