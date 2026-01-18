(
  (define-fun email () String
    "")
  (define-fun tld () String
    "C@")
  (define-fun domain_name () String
    "@")
  (define-fun domain () String
    ".k")
  (define-fun local_part () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C@")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 "@") (= x!2 1)) ".k"
    (ite (and (= x!0 ".k") (= x!1 ".") (= x!2 0)) "@"
      "B")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
