(
  (define-fun csv_line () String
    ",")
  (define-fun f2 () String
    "C")
  (define-fun sat_ok () Bool
    true)
  (define-fun f4 () String
    "!0!")
  (define-fun has_empty () Bool
    true)
  (define-fun no_commas_in_f2 () Bool
    true)
  (define-fun sp () String
    " ")
  (define-fun unsat_bad () Bool
    false)
  (define-fun rest3 () String
    "D")
  (define-fun f3 () String
    "D")
  (define-fun rest2 () String
    "C,D")
  (define-fun mode () Int
    0)
  (define-fun no_commas_in_f1 () Bool
    true)
  (define-fun no_commas_in_f0 () Bool
    true)
  (define-fun f0 () String
    "A")
  (define-fun delim () String
    ",")
  (define-fun f1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 2)) "C,D"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 3)) "D"
      "C,D")))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 0)) "A"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 2)) "C"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 3)) "D"
    (ite (and (= x!0 ",") (= x!1 ",") (= x!2 4)) "!0!"
      "")))))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    4)
)
