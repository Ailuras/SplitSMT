(
  (define-fun X () String
    ",")
  (define-fun f2 () String
    "")
  (define-fun f3 () String
    "")
  (define-fun csv () String
    ",")
  (define-fun f0 () String
    "")
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "B")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "C")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 1)) "B"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
