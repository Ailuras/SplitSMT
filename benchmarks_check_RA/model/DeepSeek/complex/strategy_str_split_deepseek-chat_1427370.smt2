(
  (define-fun email () String
    "AB")
  (define-fun tld () String
    ".C")
  (define-fun domain_name () String
    "D")
  (define-fun domain () String
    "")
  (define-fun local_part () String
    "E")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ".C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "AB") (= x!1 "@") (= x!2 0)) "E"
    (ite (and (= x!0 "") (= x!1 ".") (= x!2 0)) "D"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
