(
  (define-fun rest1 () String
    "")
  (define-fun X () String
    "/")
  (define-fun seg1 () String
    "DEFG")
  (define-fun seg0 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "/") (= x!1 "/") (= x!2 1)) "DEFG"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
