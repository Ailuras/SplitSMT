(
  (define-fun var1594 () String
    ".")
  (define-fun var3 () Int
    (- 1))
  (define-fun var231 () Int
    (ite (> (- 1) 0)
     (ite (< (num_splits var1594 ".") (- 1)) (num_splits var1594 ".") (- 1))
     (num_splits var1594 ".")))
  (define-fun var853 () Int
    0)
  (define-fun null-String () String
    "")
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
