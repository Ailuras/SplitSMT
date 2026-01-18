(
  (define-fun value2 () String
    "C")
  (define-fun total_splits () Int
    2)
  (define-fun key2 () String
    "cache-control")
  (define-fun split_segment1 () String
    "B")
  (define-fun split_segment0 () String
    "A")
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "C") (= x!1 ",") (= x!2 1)) "B"
      "A"))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
)
