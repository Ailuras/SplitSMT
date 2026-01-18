(
  (define-fun var_0xINPUT_35287 () String
    ",B")
  (define-fun i () Int
    0)
  (define-fun f2 () String
    "C")
  (define-fun T_1 () Bool
    false)
  (define-fun T_5 () Bool
    false)
  (define-fun T_3 () Bool
    false)
  (define-fun T_6 () Bool
    true)
  (define-fun T_2 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun rest1 () String
    ",")
  (define-fun rest2 () String
    ",")
  (define-fun T_7 () Bool
    true)
  (define-fun T_8 () Bool
    true)
  (define-fun f0 () String
    "P")
  (define-fun n () Int
    4)
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "0")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",B") (= x!1 ",") (= x!2 1)) "0"
    (ite (and (= x!0 ",B") (= x!1 ",") (= x!2 2)) "C"
      "P")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
