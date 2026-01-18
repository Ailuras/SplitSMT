(
  (define-fun X () String
    "/")
  (define-fun Month () String
    "FG")
  (define-fun Year () String
    "BCDE")
  (define-fun Day () String
    "IH")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "/")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "/") (= x!1 "/") (= x!2 1)) "FG"
    (ite (and (= x!0 "/") (= x!1 "/") (= x!2 2)) "IH"
      "BCDE")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
