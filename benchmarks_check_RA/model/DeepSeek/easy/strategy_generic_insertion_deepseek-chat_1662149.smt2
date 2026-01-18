(
  (define-fun segment0 () String
    "A")
  (define-fun T_1 () Bool
    false)
  (define-fun num_segments () Int
    2)
  (define-fun var_0xINPUT_10301 () String
    "")
  (define-fun T_2 () Bool
    true)
  (define-fun segment1 () String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "B"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
