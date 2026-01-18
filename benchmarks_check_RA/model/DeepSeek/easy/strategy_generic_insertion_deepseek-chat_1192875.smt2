(
  (define-fun T_1 () Bool
    true)
  (define-fun T_3 () Bool
    false)
  (define-fun delimiter () String
    ";")
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun var_0xINPUT_464210 () String
    "VEECEXk2pV")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 86))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 67))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 107))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 86))))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 1))
      "D"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 86))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 67))
                         (seq.unit (_ Char 69))
                         (seq.unit (_ Char 88))
                         (seq.unit (_ Char 107))
                         (seq.unit (_ Char 50))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 86))))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 2))
      "B"
      "A")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
