(
  (define-fun bad2 () String
    "")
  (define-fun field3 () String
    "")
  (define-fun bad0 () String
    "")
  (define-fun rest_from2 () String
    "")
  (define-fun field2 () String
    "")
  (define-fun field0 () String
    "A")
  (define-fun csv_row () String
    "alice,42,,NY")
  (define-fun bad1 () String
    ",")
  (define-fun field1 () String
    "B")
  (define-fun delim () String
    ",")
  (define-fun csv_row_bad () String
    "x,,z")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 0))
      "A"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 105))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 52))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 78))
                         (seq.unit (_ Char 89))))
              (= x!1 ",")
              (= x!2 1))
      "B"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 120))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 122))))
              (= x!1 ",")
              (= x!2 1))
      ","
      ""))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 120))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 122))))
              (= x!1 ","))
      3
      4))
)
