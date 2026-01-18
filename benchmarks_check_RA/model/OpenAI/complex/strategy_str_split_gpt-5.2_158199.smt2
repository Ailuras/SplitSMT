(
  (define-fun var_0xINPUT_168034 () String
    ".")
  (define-fun dom_label1 () String
    ".")
  (define-fun T_1 () Bool
    false)
  (define-fun T_5 () Bool
    true)
  (define-fun dom_label0 () String
    "@")
  (define-fun domain () String
    ".")
  (define-fun tld () String
    "@@")
  (define-fun T_3 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun at_splits () Int
    4)
  (define-fun T_4 () Bool
    true)
  (define-fun dot_splits () Int
    3)
  (define-fun local_part () String
    ".")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 0)) "@"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 2)) "@@"
      ".")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 ".")) 3
      4))
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
