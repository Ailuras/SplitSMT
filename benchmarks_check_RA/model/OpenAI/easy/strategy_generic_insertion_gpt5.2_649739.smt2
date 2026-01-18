(
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_49585 () String
    "Search")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 104))))
              (= x!1 (seq.unit (_ Char 97)))
              (= x!2 1))
      "rch"
      "rch"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 104))))
              (= x!1 (seq.unit (_ Char 97)))
              (= x!2 0))
      "Se"
      "Se"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
