(
  (define-fun X () String
    "/USER NT-2 * 0 :/mi\u{a}")
  (define-fun first_segment () String
    "/USER")
  (define-fun second_segment () String
    "/USER")
  (define-fun delimiter () String
    " ")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "/USER")
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
