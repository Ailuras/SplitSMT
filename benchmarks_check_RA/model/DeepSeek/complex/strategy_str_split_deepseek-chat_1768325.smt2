(
  (define-fun csv_line () String
    "123,John Doe,30,USA")
  (define-fun has_empty_field () Bool
    false)
  (define-fun last_field () String
    "")
  (define-fun middle_field () String
    "")
  (define-fun field_count () Int
    0)
  (define-fun first_field () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 74))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 68))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 85))
                         (seq.unit (_ Char 83))
                         (seq.unit (_ Char 65))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "E"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 74))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 104))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 32))
                         (seq.unit (_ Char 68))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 48))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 85))
                         (seq.unit (_ Char 83))
                         (seq.unit (_ Char 65))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "C"
      "B")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
