(
  (define-fun X () String
    "/filename=.avi/i\u{a}")
  (define-fun filename () String
    "w")
  (define-fun extension () String
    "avi")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "w") (= x!1 (seq.unit (_ Char 46))) (= x!2 1)) "avi"
      "w"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
