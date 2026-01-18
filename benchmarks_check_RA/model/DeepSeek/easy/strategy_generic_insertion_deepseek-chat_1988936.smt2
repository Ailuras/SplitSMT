(
  (define-fun X () String
    "410000000\u{a}")
  (define-fun segment0 () String
    "AB")
  (define-fun delimiter () String
    "-")
  (define-fun total_segments () Int
    2)
  (define-fun segment1 () String
    "CDEFGHI")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "410000000\u{a}") (= x!1 (seq.unit (_ Char 45))) (= x!2 1))
      "CDEFGHI"
      "AB"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
