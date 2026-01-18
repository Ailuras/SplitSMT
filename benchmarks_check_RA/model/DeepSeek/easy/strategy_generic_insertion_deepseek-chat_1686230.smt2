(
  (define-fun T_1 () Bool
    false)
  (define-fun delimiter () String
    ";")
  (define-fun var_0xINPUT_27511 () String
    "")
  (define-fun T_2 () Bool
    true)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 59))) (= x!2 0)) "start"
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 59))) (= x!2 2)) "end"
      "start")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
