(
  (define-fun csv_line () String
    "A123,empty,value,test,456")
  (define-fun has_empty_field () Bool
    true)
  (define-fun last_field () String
    "")
  (define-fun middle_field () String
    "")
  (define-fun field_count () Int
    0)
  (define-fun first_field () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (let ((a!1 (ite (and (= x!0 "A123,empty,value,test,456")
                         (= x!1 ",")
                         (not (<= 1 x!2)))
                    "A"
                    "!0!")))
      (ite (and (= x!0 "A123,empty,value,test,456")
                (= x!1 ",")
                (<= 1 x!2)
                (not (<= 4 x!2)))
           ""
           (ite (and (= x!0 "A123,empty,value,test,456")
                     (= x!1 ",")
                     (<= 1 x!2)
                     (<= 4 x!2))
                "0"
                a!1))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    5)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
