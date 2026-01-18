(
  (define-fun X () String
    ".")
  (define-fun delimiter () String
    ".")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "myway")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 (seq.unit (_ Char 46)))
              (= x!1 (seq.unit (_ Char 46)))
              (= x!2 0))
      "www"
      "www"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
