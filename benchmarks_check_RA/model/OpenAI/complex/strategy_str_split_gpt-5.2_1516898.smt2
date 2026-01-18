(
  (define-fun var_0xINPUT_283257 () String
    ",")
  (define-fun has_trailing_comma () Bool
    false)
  (define-fun f2 () String
    "D")
  (define-fun bad_header () Bool
    false)
  (define-fun f3 () String
    "B")
  (define-fun T_1 () Bool
    false)
  (define-fun empty_field () Bool
    false)
  (define-fun f0 () String
    "A")
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "C")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "D,B")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 3)) "B"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 0)) "A"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 1)) "C"
      "D"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
