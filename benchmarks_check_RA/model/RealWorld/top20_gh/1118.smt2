(
  (define-fun var3490 () String
    "BA")
  (define-fun null-String () String
    "=")
  (define-fun var1421 () Int
    (let ((a!1 (num_splits (str.substr var3490 2 (- (str.len var3490) 2)) "=")))
  (ite (> (- 1) 0) (ite (< a!1 (- 1)) a!1 (- 1)) a!1)))
  (define-fun var2440 () String
    (str.substr var3490 2 (- (str.len var3490) 2)))
  (define-fun var1879 () Int
    0)
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
