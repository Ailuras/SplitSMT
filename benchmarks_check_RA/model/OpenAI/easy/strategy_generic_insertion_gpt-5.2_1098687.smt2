(
  (define-fun var0 () String
    "1122")
  (define-fun seg0 () String
    "11")
  (define-fun seg1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "2")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "1122") (= x!1 "2") (= x!2 1)) ""
      "11"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
