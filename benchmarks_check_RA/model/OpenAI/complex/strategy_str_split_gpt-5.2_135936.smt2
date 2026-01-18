(
  (define-fun f1 () String
    "")
  (define-fun f3 () String
    "B")
  (define-fun f0 () String
    "A")
  (define-fun f2 () String
    "")
  (define-fun rest1 () String
    ",,B")
  (define-fun T_5 () Bool
    true)
  (define-fun var_0xINPUT_399334 () String
    "A,,,B")
  (define-fun rest2 () String
    ",B")
  (define-fun T_3 () Bool
    true)
  (define-fun T_4 () Bool
    true)
  (define-fun T_2 () Bool
    false)
  (define-fun T_1 () Int
    5)
  (define-fun delim () String
    ",")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,,,B") (= x!1 ",") (= x!2 2)) ",B"
      ",,B"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A,,,B") (= x!1 ",") (= x!2 0)) "A"
    (ite (and (= x!0 "A,,,B") (= x!1 ",") (= x!2 3)) "B"
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
