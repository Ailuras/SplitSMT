(
  (define-fun seg0 () String
    "Example")
  (define-fun T_1 () Bool
    true)
  (define-fun T_5 () Bool
    false)
  (define-fun T_c () Bool
    true)
  (define-fun rest1 () String
    "")
  (define-fun var_0xINPUT_253192 () String
    "Example:")
  (define-fun T_f () Bool
    false)
  (define-fun T_11 () Bool
    true)
  (define-fun T_3 () Bool
    true)
  (define-fun T_e () Bool
    true)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun T_12 () Bool
    true)
  (define-fun T_10 () Bool
    true)
  (define-fun T_a () Bool
    false)
  (define-fun seg1 () String
    "")
  (define-fun T_9 () Bool
    true)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun T_b () Bool
    true)
  (define-fun T_d () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 69))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 58))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "Example"
    (ite (and (= x!0
                 (str.++ (seq.unit (_ Char 69))
                         (seq.unit (_ Char 120))
                         (seq.unit (_ Char 97))
                         (seq.unit (_ Char 109))
                         (seq.unit (_ Char 112))
                         (seq.unit (_ Char 108))
                         (seq.unit (_ Char 101))
                         (seq.unit (_ Char 58))))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      ""
      "Example")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
