(
  (define-fun csv_line_ok () String
    "")
  (define-fun rest1_ok () String
    ",")
  (define-fun f3_ok () String
    "B")
  (define-fun f2_ok () String
    "0")
  (define-fun f1_ok () String
    "C")
  (define-fun delim () String
    ",")
  (define-fun f0_ok () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 1)) "C"
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 2)) "0"
    (ite (and (= x!0 "") (= x!1 ",") (= x!2 3)) "B"
      "A"))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
