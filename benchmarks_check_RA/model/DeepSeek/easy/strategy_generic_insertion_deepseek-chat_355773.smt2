(
  (define-fun y () String
    "+*+*")
  (define-fun x () String
    "+*")
  (define-fun delimiter () String
    "+")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "+*+*") (= x!1 "+") (= x!2 1)) "+*"
      "+"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "+*+*") (= x!1 "+")) 2
      1))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
