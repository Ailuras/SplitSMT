(
  (define-fun X () String
    "\u{21e}")
  (define-fun delimiter () String
    "|")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "\u{21e}") (= x!1 (seq.unit (_ Char 124))) (= x!2 1)) "Z"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
