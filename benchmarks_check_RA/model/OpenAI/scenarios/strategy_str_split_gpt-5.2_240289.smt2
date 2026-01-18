(
  (define-fun subdomain_first_sat () String
    "@")
  (define-fun domain_sat () String
    "[")
  (define-fun email_sat () String
    "john.doe+tag@sub.mail.example.COM")
  (define-fun tld_sat () String
    "Za")
  (define-fun first_label_len_sat () Int
    1)
  (define-fun domain_rest_sat () String
    "")
  (define-fun local_sat () String
    "[")
  (define-fun dot_count_sat () Int
    21657)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "[") (= x!1 ".") (= x!2 0)) "@"
    (ite (and (= x!0 "[") (= x!1 ".") (= x!2 21656)) "Za"
      "[")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "[") (= x!1 ".")) 21657
      2))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
