(
  (define-fun X () String
    "")
  (define-fun seg0 () String
    "A")
  (define-fun seg2 () String
    "")
  (define-fun seg1 () String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 47))) (= x!2 2)) ""
      "/"))
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    (ite (and (= x!0 "") (= x!1 (seq.unit (_ Char 47))) (= x!2 0)) "A"
      ""))
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    2)
)
