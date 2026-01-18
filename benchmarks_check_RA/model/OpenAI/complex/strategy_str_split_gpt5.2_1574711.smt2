(
  (define-fun f2 () String
    "age")
  (define-fun literal_5 () String
    "<td>activityreport: </td>")
  (define-fun csv_line () String
    "name,,age")
  (define-fun rest2 () String
    "age")
  (define-fun f0 () String
    "A")
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "age")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      "age"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 110))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 103))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "A"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
