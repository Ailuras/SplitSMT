(
  (define-fun var_0xINPUT_78913 () String
    ",")
  (define-fun rest_after1 () String
    ",")
  (define-fun T_1 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun field2 () String
    "!0!")
  (define-fun field1 () String
    "")
  (define-fun field0 () String
    "A")
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 2)) "!0!"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 0)) "A"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
