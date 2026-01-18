(
  (define-fun var_8 () String
    "b")
  (define-fun var_7 () String
    "a")
  (define-fun whole () String
    "azb")
  (define-fun delim () String
    "z")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "b")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "azb") (= x!1 "z") (= x!2 1)) "b"
      "a"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
