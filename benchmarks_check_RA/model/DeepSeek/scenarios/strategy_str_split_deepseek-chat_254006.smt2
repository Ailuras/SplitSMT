(
  (define-fun is_valid () Bool
    true)
  (define-fun csv_line () String
    "name,age,city,country")
  (define-fun has_empty_field () Bool
    false)
  (define-fun last_field () String
    "")
  (define-fun field_count () Int
    0)
  (define-fun first_field () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (let ((a!1 (ite (and (= x!0 "name,age,city,country")
                         (= x!1 ",")
                         (not (<= 1 x!2)))
                    "A"
                    "!0!")))
      (ite (and (= x!0 "name,age,city,country")
                (= x!1 ",")
                (<= 1 x!2)
                (<= 2 x!2))
           "B"
           a!1)))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 111))
                         (seq.unit (_ Char 117))
                         (seq.unit (_ Char 110))
                         (seq.unit (_ Char 116))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 121))))
              (= x!1 (seq.unit (_ Char 44))))
      3
      (- 1)))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
