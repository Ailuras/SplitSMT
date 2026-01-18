(
  (define-fun T_1 () Bool
    false)
  (define-fun T_3 () Bool
    false)
  (define-fun var_0xINPUT_49072 () String
    "")
  (define-fun delimiter () String
    ",")
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "end"
      "end"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 0)) "start"
      "start"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
