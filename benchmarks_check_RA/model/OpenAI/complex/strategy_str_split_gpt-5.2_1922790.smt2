(
  (define-fun var_0xINPUT_239267 () String
    "Example:,")
  (define-fun T_1 () Bool
    true)
  (define-fun T_5 () Bool
    false)
  (define-fun field0 () String
    "]")
  (define-fun T_3 () Bool
    true)
  (define-fun T_11 () Bool
    true)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun T_12 () Bool
    true)
  (define-fun T_10 () Bool
    true)
  (define-fun field3 () String
    "\")
  (define-fun field2 () String
    "")
  (define-fun T_9 () Bool
    true)
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun field1 () String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "Example:,") (= x!1 ",") (= x!2 3)) "\"
    (ite (and (= x!0 "Example:,") (= x!1 ",") (= x!2 0)) "]"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
