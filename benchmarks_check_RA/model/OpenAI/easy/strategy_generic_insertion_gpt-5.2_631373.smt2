(
  (define-fun value2 () String
    "\u{b}\u{9} ")
  (define-fun cc_directive1 () String
    "")
  (define-fun key2 () String
    "cache-control")
  (define-fun cc_directive0 () String
    "")
  (define-fun cc_v0 () String
    ",")
  (define-fun cc_k0 () String
    "A")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 "=") (= x!2 2)) ""
      ","))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 "=") (= x!2 0)) "A"
    (ite (and (= x!0 "") (= x!1 "=") (= x!2 1)) ","
      "")))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
