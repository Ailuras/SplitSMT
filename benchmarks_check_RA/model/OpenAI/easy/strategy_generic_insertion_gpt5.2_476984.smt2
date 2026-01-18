(
  (define-fun var_0xINPUT_238509 () String
    "y")
  (define-fun T_1 () Bool
    false)
  (define-fun input_suffix () String
    "pe")
  (define-fun input_prefix () String
    "T")
  (define-fun T_2 () Bool
    true)
  (define-fun input_num_parts () Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 121)))
              (= x!1 (seq.unit (_ Char 121)))
              (= x!2 1))
      "pe"
      "pe"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "T")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
