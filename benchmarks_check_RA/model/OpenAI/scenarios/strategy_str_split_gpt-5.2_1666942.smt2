(
  (define-fun sld_bad () String
    "A")
  (define-fun u1_ok () String
    "A")
  (define-fun domain_bad () String
    "@")
  (define-fun email_ok () String
    "alice@sub.example.com")
  (define-fun tld_ok () String
    "com")
  (define-fun domain_ok () String
    "A")
  (define-fun rest_ok () String
    "A")
  (define-fun u0_ok () String
    "A")
  (define-fun local_bad () String
    "A")
  (define-fun email_bad () String
    "bob@example.com")
  (define-fun tld_bad () String
    ".A")
  (define-fun sld_ok () String
    "example")
  (define-fun local_ok () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A") (= x!1 ".") (= x!2 2)) "bob@example.com"
    (ite (and (= x!0 "bob@example.com") (= x!1 "@") (= x!2 1)) "@"
    (ite (and (= x!0 "@") (= x!1 ".") (= x!2 1)) ".A"
      "A"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "A") (= x!1 ".")) 4
      2))
)
