(
  (define-fun var_0xINPUT_109105 () String
    "A")
  (define-fun tld () String
    "")
  (define-fun T_1 () Bool
    false)
  (define-fun T_5 () Bool
    true)
  (define-fun U_2 () Bool
    true)
  (define-fun U_3 () Bool
    true)
  (define-fun T_3 () Bool
    false)
  (define-fun U_1 () Bool
    true)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun domain_rest_from1 () String
    "B")
  (define-fun domain_label0 () String
    "A")
  (define-fun U_4 () Bool
    true)
  (define-fun domain_full () String
    "A")
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun U_5 () Bool
    true)
  (define-fun local_part () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A") (= x!1 ".") (= x!2 1)) "C"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "A") (= x!1 ".")) 3
      2))
)
