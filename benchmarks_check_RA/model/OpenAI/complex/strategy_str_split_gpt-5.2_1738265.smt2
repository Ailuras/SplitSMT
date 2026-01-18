(
  (define-fun csv () String
    "")
  (define-fun f2 () String
    "")
  (define-fun suffix_from_2 () String
    ",")
  (define-fun f3 () String
    "B")
  (define-fun f0 () String
    "11")
  (define-fun f1 () String
    "C")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 0)) "11"
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 1)) "C"
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 3)) "B"
      ""))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
