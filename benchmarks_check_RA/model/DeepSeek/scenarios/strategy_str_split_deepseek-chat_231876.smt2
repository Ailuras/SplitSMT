(
  (define-fun middle_field () String
    "B")
  (define-fun last_field () String
    "C")
  (define-fun field_count () Int
    5)
  (define-fun delimiter () String
    ",")
  (define-fun csv_line () String
    "John,Doe,30,New York,USA")
  (define-fun first_field () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "Doe")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (let ((a!1 (ite (and (= x!0 "John,Doe,30,New York,USA")
                         (= x!1 ",")
                         (not (<= 4 x!2)))
                    "B"
                    "!0!")))
      (ite (and (= x!0 "John,Doe,30,New York,USA") (= x!1 ",") (<= 4 x!2))
           "C"
           a!1)))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
)
