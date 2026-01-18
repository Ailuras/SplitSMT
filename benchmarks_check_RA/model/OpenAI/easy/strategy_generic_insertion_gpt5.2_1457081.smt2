(
  (define-fun X () String
    "\u{a}")
  (define-fun day () String
    "IH")
  (define-fun year () String
    "BCDE")
  (define-fun month () String
    "GF")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 47))) (= x!2 1)) "GF"
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 47))) (= x!2 2)) "IH"
      "BCDE")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
