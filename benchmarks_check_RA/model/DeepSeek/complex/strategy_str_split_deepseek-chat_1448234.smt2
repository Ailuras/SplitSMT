(
  (define-fun email () String
    "pp\u{2003d}")
  (define-fun tld () String
    "pp")
  (define-fun at_splits () Int
    2)
  (define-fun domain_name () String
    ".")
  (define-fun domain () String
    "pp\u{2003d}")
  (define-fun local_part () String
    ".")
  (define-fun dot_splits () Int
    0)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "pp")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "pp\u{2003d}") (= x!1 (seq.unit (_ Char 64))) (= x!2 1))
      "pp\u{2003d}"
      "."))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
