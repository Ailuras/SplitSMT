(
  (define-fun seg0 () String
    "T")
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_110061 () String
    "Type")
  (define-fun seg1 () String
    "pe")
  (define-fun rest1 () String
    "pe")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 84))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 121)))
              (= x!2 1))
      "pe"
      "pe"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 84))
                         (seq.unit (_ Char 121))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 101))))
              (= x!1 (seq.unit (_ Char 121)))
              (= x!2 1))
      "pe"
      "T"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
