(
  (define-fun var_0xINPUT_127551 () String
    ":")
  (define-fun rest1 () String
    "")
  (define-fun T_1 () Bool
    true)
  (define-fun T_5 () Bool
    true)
  (define-fun seg1 () String
    "")
  (define-fun delim_colon () String
    ":")
  (define-fun T_3 () Bool
    false)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun seg0 () String
    "Example")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 0))
      "Example"
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      ""
      "Example")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
