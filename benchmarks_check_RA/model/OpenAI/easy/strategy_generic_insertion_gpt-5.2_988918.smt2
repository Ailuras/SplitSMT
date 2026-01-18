(
  (define-fun X () String
    "")
  (define-fun year () String
    "CD")
  (define-fun day () String
    "F")
  (define-fun year_and_time () String
    "\u{a}")
  (define-fun month () String
    "E")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "\u{a}")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 47))) (= x!2 1)) "F"
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 32))) (= x!2 0)) "CD"
      "E")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 32)))) 1
      3))
)
