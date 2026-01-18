(
  (define-fun email () String
    "example.com@")
  (define-fun tld () String
    "..B")
  (define-fun domain_name () String
    ".")
  (define-fun domain () String
    "@")
  (define-fun local_part () String
    ".")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "example.com@") (= x!1 "@") (= x!2 1)) "@"
    (ite (and (= x!0 "@") (= x!1 ".") (= x!2 1)) "..B"
      ".")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
