(
  (define-fun var151 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var2902 "(") (- 1)) (num_splits var2902 "(") (- 1))
     (num_splits var2902 "(")))
  (define-fun null-String () String
    "")
  (define-fun var2902 () String
    "(")
  (define-fun num_splits_re ((x!0 String) (x!1 RegLan)) Int
    0)
  (define-fun num_splits ((x!0 String) (x!1 String)) Int
    0)
  (define-fun split_at ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest ((x!0 String) (x!1 String) (x!2 Int)) String
    "")
  (define-fun split_rest_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
  (define-fun split_at_re ((x!0 String) (x!1 RegLan) (x!2 Int)) String
    "")
)
