(
  (define-fun seg0 () String
    "A")
  (define-fun T_1 () Bool
    true)
  (define-fun var_0xINPUT_112727 () String
    "-")
  (define-fun seg1 () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 45)))
              (= x!1 (seq.unit (_ Char 45)))
              (= x!2 0))
      "A"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
