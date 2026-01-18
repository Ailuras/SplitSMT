(
  (define-fun csv () String
    "\u{a}")
  (define-fun sat_case () Bool
    true)
  (define-fun has_empty () Bool
    false)
  (define-fun rest2 () String
    "")
  (define-fun field2 () String
    "D")
  (define-fun field1 () String
    "C")
  (define-fun field0 () String
    "B")
  (define-fun delim () String
    ",")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 1)) "C"
    (ite (and (= x!0 "\u{a}") (= x!1 (seq.unit (_ Char 44))) (= x!2 2)) "D"
      "B")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
