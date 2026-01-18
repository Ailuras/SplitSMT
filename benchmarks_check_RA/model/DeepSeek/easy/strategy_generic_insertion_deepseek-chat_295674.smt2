(
  (define-fun x () String
    "OO?")
  (define-fun delimiter () String
    "O")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "OO?") (= x!1 "O") (= x!2 1)) "??"
      "??"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "OO?") (= x!1 "O") (= x!2 0)) "?"
      "?"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
