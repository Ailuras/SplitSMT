(
  (define-fun email () String
    "example.comuser.name")
  (define-fun tld () String
    "Pk")
  (define-fun at_splits () Int
    2)
  (define-fun domain_name () String
    "B")
  (define-fun domain () String
    "@")
  (define-fun local_part () String
    "G")
  (define-fun dot_splits () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "Pk")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "example.comuser.name") (= x!1 "@") (= x!2 0)) "G"
    (ite (and (= x!0 "@") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "B"
      "@")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
