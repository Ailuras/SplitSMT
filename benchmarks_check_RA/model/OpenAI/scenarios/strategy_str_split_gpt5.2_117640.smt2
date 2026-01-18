(
  (define-fun rest3_sat () String
    "")
  (define-fun rest2_sat () String
    "")
  (define-fun rest1_sat () String
    "")
  (define-fun f3_sat () String
    "NY")
  (define-fun f0_sat () String
    "Alice")
  (define-fun f1_sat () String
    "42")
  (define-fun f2_sat () String
    "")
  (define-fun csv_sat () String
    "Alice,42,,NY")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 0))
      "Alice"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 1))
      "42"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 2))
      ""
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 65))
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
              (= x!1 (seq.unit (_ Char 44)))
              (= x!2 3))
      "NY"
      "Alice")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
