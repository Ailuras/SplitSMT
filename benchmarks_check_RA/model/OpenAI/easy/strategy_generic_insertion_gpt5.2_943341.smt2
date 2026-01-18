(
  (define-fun value2 () String
    "A\u{a}\u{d}")
  (define-fun cc_directive1 () String
    "==")
  (define-fun key2 () String
    "cache-control")
  (define-fun cc_directive0 () String
    ",=E=")
  (define-fun cc_rest_from2 () String
    "F")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "F")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "A\u{a}\u{d}") (= x!1 ",") (= x!2 1)) "=="
      ",=E="))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    3)
)
