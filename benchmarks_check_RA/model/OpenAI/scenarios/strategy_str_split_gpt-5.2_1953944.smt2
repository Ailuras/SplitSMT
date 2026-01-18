(
  (define-fun uns_field1 () String
    "")
  (define-fun digit_re () RegLan
    (re.range "0" "9"))
  (define-fun sat_field2 () String
    "")
  (define-fun sat_rest2 () String
    ",8")
  (define-fun sat_field1 () String
    "-")
  (define-fun sat_field4 () String
    "8")
  (define-fun sat_field0 () String
    "2")
  (define-fun csv_line_unsat () String
    "a,,b,c")
  (define-fun sat_field3 () String
    "")
  (define-fun uns_field0 () String
    "")
  (define-fun sat_rest4 () String
    "8")
  (define-fun uns_field3 () String
    "")
  (define-fun comma () String
    ",")
  (define-fun uns_field2 () String
    "")
  (define-fun csv_line_sat () String
    "123,aa-bb,,X,99")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 57))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      ",8"
      "8"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 57))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "2"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 57))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 4))
      "8"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 49))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 51))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 45))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 57))
                         (seq.unit (_ Char 57))))
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "-"
      ""))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 97))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 98))
                         (seq.unit (_ Char 44))
                         (seq.unit (_ Char 99))))
              (= x!1 (seq.unit (_ Char 44))))
      3
      5))
)
