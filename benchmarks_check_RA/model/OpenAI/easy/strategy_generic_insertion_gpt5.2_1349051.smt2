(
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_283257 () String
    "Search")
  (define-fun seg1 () String
    "arch")
  (define-fun seg0 () String
    "S")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 104))))
              (= x!1 (seq.unit (_ Char 101)))
              (= x!2 1))
      "arch"
      "arch"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 83))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 114))
                         (seq.unit (_ Char 99))
                         (seq.unit (_ Char 104))))
              (= x!1 (seq.unit (_ Char 101)))
              (= x!2 1))
      "arch"
      "S"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
