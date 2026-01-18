(
  (define-fun var_0xINPUT_154702 () String
    ":")
  (define-fun T_1 () Bool
    false)
  (define-fun segment_1 () String
    "")
  (define-fun segment_0 () String
    "B")
  (define-fun delimiter () String
    ":")
  (define-fun T_2 () Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 58)))
              (= x!1 (seq.unit (_ Char 58)))
              (= x!2 1))
      ""
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
