(
  (define-fun email () String
    "example@domain.com")
  (define-fun tld () String
    "pp")
  (define-fun num_at_splits () Int
    2)
  (define-fun num_dot_splits () Int
    2)
  (define-fun domain_name () String
    "0")
  (define-fun domain () String
    "")
  (define-fun local_part () String
    "m")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "pp"
      ""))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "0"
      "m"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
