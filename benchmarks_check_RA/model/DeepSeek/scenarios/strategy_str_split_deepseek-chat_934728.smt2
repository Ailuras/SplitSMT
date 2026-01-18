(
  (define-fun email () String
    "")
  (define-fun tld () String
    ".C")
  (define-fun domain_name () String
    "H")
  (define-fun domain () String
    "FB")
  (define-fun local_part () String
    "D")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 64))) (= x!2 0)) "D"
    (ite (and (= x!0 "FB") (= x!1 ".") (= x!2 0)) "H"
    (ite (and (= x!0 "FB") (= x!1 ".") (= x!2 1)) ".C"
      "FB"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
