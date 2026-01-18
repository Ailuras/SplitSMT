(
  (define-fun var_0xINPUT_4701 () String
    "file:A")
  (define-fun after_colon () String
    "A")
  (define-fun T_1 () Bool
    true)
  (define-fun scheme_part () String
    "file")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "file:A") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "file"
      "file"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
