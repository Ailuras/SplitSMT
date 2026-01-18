(
  (define-fun x () String
    "")
  (define-fun delimiter () String
    ":")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "data")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 58))) (= x!2 0)) "example"
      "example"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    1)
)
