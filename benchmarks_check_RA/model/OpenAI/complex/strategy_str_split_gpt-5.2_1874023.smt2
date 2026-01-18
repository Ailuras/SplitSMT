(
  (define-fun domain_part () String
    "B.")
  (define-fun T_1 () Bool
    false)
  (define-fun dot () String
    ".")
  (define-fun var_0xINPUT_479903 () String
    "")
  (define-fun domain_with_dot () String
    "B.")
  (define-fun domain_rest () String
    "")
  (define-fun at () String
    "@")
  (define-fun tld () String
    "A")
  (define-fun T_2 () Bool
    true)
  (define-fun domain_label0 () String
    "B")
  (define-fun local_part () String
    ".")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 64))) (= x!2 1)) "B."
    (ite (and (= x!0 "B.") (= x!1 ".") (= x!2 0)) "B"
    (ite (and (= x!0 "B.") (= x!1 ".") (= x!2 8366)) "A"
      "."))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 (seq.unit (_ Char 64)))) 1
    (ite (and (= x!0 "B.") (= x!1 ".")) 8367
      2)))
)
