(
  (define-fun x () String
    "ABABBBAA")
  (define-fun delimiter () String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "ABABBBAA") (= x!1 "A") (= x!2 0)) "B"
      "B"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
