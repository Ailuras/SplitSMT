(
  (define-fun var_0xINPUT_137609 () String
    "gaMUIKcECR")
  (define-fun T_1 () Bool
    true)
  (define-fun seg2 () String
    "ga")
  (define-fun seg1 () String
    "g")
  (define-fun rest1 () String
    "g")
  (define-fun seg0 () String
    "g")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "g")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "g") (= x!1 (seq.unit (_ Char 77))) (= x!2 0)) "ga"
    (ite (and (= x!0 "g") (= x!1 (seq.unit (_ Char 77))) (= x!2 1)) ""
      "g")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
