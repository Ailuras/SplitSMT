(
  (define-fun X () String
    "4001000000000\u{a}")
  (define-fun segment1 () String
    "000000000000\u{a}")
  (define-fun delimiter () String
    "4")
  (define-fun total_segments () Int
    2)
  (define-fun segment0 () String
    "\u{a}")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "4001000000000\u{a}")
              (= x!1 (seq.unit (_ Char 52)))
              (= x!2 1))
      "000000000000\u{a}"
      "\u{a}"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
