(
  (define-fun T_1 () Bool
    false)
  (define-fun var_0xINPUT_323918 () String
    "")
  (define-fun first_label () String
    "B")
  (define-fun domain () String
    ".")
  (define-fun second_label () String
    "C")
  (define-fun tld () String
    "@@")
  (define-fun T_2 () Bool
    true)
  (define-fun local_part () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "@@")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 "@") (= x!2 1)) "."
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 0)) "B"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 1)) "C"
    (ite (and (= x!0 ".") (= x!1 ".") (= x!2 2)) "@@"
      "A")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 ".") (= x!1 ".")) 3
      2))
)
