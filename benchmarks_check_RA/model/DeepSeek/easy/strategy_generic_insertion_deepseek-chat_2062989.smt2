(
  (define-fun var_0xINPUT_101935 () String
    ";")
  (define-fun T_1 () Bool
    true)
  (define-fun delimiter () String
    ";")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 59)))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 1))
      "B"
    (ite (and (= x!0 (seq.unit (_ Char 59)))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 2))
      "A"
      "C")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
