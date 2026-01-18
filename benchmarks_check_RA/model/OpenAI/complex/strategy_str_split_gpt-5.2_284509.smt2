(
  (define-fun email () String
    ".@..CB")
  (define-fun tld_len () Int
    3)
  (define-fun domain_len () Int
    3)
  (define-fun local_len () Int
    1)
  (define-fun at_count () Int
    2)
  (define-fun local () String
    "@")
  (define-fun remainder_from_dot () String
    "")
  (define-fun first_dot_seg () String
    "F")
  (define-fun domain () String
    "@DA")
  (define-fun tld () String
    "com")
  (define-fun dot_count () Int
    2)
  (define-fun second_level () String
    "F")
  (define-fun rest_after_at () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "@DA") (= x!1 ".") (= x!2 1)) "com"
    (ite (and (= x!0 ".@..CB") (= x!1 "@") (= x!2 0)) "@"
    (ite (and (= x!0 "@DA") (= x!1 ".") (= x!2 0)) "F"
      "@DA"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
