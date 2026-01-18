(
  (define-fun var_0xINPUT_40963 () String
    "A,,")
  (define-fun f2 () String
    "")
  (define-fun T_1 () Bool
    true)
  (define-fun rest2 () String
    "")
  (define-fun T_4 () Bool
    true)
  (define-fun rest1 () String
    ",")
  (define-fun T_3 () Bool
    true)
  (define-fun f0 () String
    "A")
  (define-fun n () Int
    3)
  (define-fun T_2 () Bool
    true)
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,,") (= x!1 ",") (= x!2 2)) ""
      ","))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,,") (= x!1 ",") (= x!2 0)) "A"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
