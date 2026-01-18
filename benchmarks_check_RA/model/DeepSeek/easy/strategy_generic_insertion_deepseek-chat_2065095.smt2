(
  (define-fun x () String
    "tttttt")
  (define-fun delimiter () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "tttttt") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "bc"
      "bc"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "tttttt") (= x!1 (seq.unit (_ Char 44))) (= x!2 0)) "a"
      "a"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
