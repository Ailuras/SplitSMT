(
  (define-fun email () String
    "")
  (define-fun domain_part () String
    ".D")
  (define-fun tld () String
    ".D")
  (define-fun domain_name () String
    "C")
  (define-fun local_part () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ".D")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 64))) (= x!2 0)) "B"
    (ite (and (= x!0 ".D") (= x!1 (seq.unit (_ Char 46))) (= x!2 0)) "C"
      ".D")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
