(
  (define-fun var_0xINPUT_57953 () String
    ";")
  (define-fun T_1 () Bool
    false)
  (define-fun delimiter () String
    ";")
  (define-fun T_2 () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "data")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 59)))
              (= x!1 (seq.unit (_ Char 59)))
              (= x!2 0))
      "Search"
      "Search"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
